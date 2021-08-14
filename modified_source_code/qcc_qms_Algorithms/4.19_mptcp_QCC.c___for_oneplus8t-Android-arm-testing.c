/*
 1. passing QoE parameter to Android Kernel				in	tcp_v4_connect()	net/ipv4/tcp_ipv4.c
 2. set rwnd send to sender according to QoE & trigger (set in QCC)	in	__dev_queue_xmit	net/core/dev.c	__tcp_transmit_skb()		net/ipv4/tcp_output.c
 3. set cwnd & ssthresh according to QoE 					in	QCC
 4. select subflow according to sort_rtt & & sort_cwnd & QoE		in	QMS
 */

/*
 *	MPTCP implementation - QoE-Driven Congestion Controller (QCC)
 *	QCC is a BDP and loss-based uncoupled congestion controller
 *	for MPTCP over wireless networks and is used in Android kernel.
 *
 *	QCC is based on TCP CUBIC & BBR.
 *
 *	Algorithm design: Tongguang Zhang <jsjoscpu@163.com>
 *
 *	Implementation: Tongguang Zhang <jsjoscpu@163.com>
 *
 *	This program is free software; you can redistribute it and/or
 *	modify it under the terms of the GNU General Public License
 *	as published by the Free Software Foundation; either version
 *	2 of the License, or (at your option) any later version.
 */

/*
 * TCP CUBIC: Binary Increase Congestion control for TCP v2.3
 * Home page:
 *      http://netsrv.csc.ncsu.edu/twiki/bin/view/Main/BIC
 * This is from the implementation of CUBIC TCP in
 * Sangtae Ha, Injong Rhee and Lisong Xu,
 *  "CUBIC: A New TCP-Friendly High-Speed TCP Variant"
 *  in ACM SIGOPS Operating System Review, July 2008.
 * Available from:
 *  http://netsrv.csc.ncsu.edu/export/cubic_a_new_tcp_2008.pdf
 *
 * CUBIC integrates a new slow start algorithm, called HyStart.
 * The details of HyStart are presented in
 *  Sangtae Ha and Injong Rhee,
 *  "Taming the Elephants: New TCP Slow Start", NCSU TechReport 2008.
 * Available from:
 *  http://netsrv.csc.ncsu.edu/export/hystart_techreport_2008.pdf
 *
 * All testing results are available from:
 * http://netsrv.csc.ncsu.edu/wiki/index.php/TCP_Testing
 *
 * Unless CUBIC is enabled and congestion window is large
 * this behaves the same as the original Reno.
 */

#include <linux/mm.h>
#include <linux/module.h>
#include <linux/math64.h>
#include <net/tcp.h>
#include <net/mptcp.h>

	//--------------------------------------------------------------------------
	// BBR ADD
	//--------------------------------------------------------------------------
//#include <linux/module.h>
//#include <net/tcp.h>
#include <linux/inet_diag.h>
#include <linux/inet.h>
#include <linux/random.h>
#include <linux/win_minmax.h>
	//--------------------------------------------------------------------------

#define MPTCP_QCC_BETA_SCALE    1024	/* Scale factor beta calculation
					 	* max_cwnd = snd_cwnd * beta
					 	*/
#define	MPTCP_QCC_HZ		10	/* BIC HZ 2^10 = 1024 */

/* Two methods of hybrid slow start */
#define HYSTART_ACK_TRAIN	0x1
#define HYSTART_DELAY		0x2

/* Number of delay samples for detecting the increase of delay */
#define HYSTART_MIN_SAMPLES	8
#define HYSTART_DELAY_MIN	(4U<<3)		/* (2U<<3)	Delay increase threshold */
#define HYSTART_DELAY_MAX	(16U<<3)		/* Delay increase threshold */
#define HYSTART_DELAY_THRESH(x)	clamp(x, HYSTART_DELAY_MIN, HYSTART_DELAY_MAX)

	//--------------------------------------------------------------------------
	// BBR ADD many
	//--------------------------------------------------------------------------
/* Scale factor for rate in pkt/uSec unit to avoid truncation in bandwidth
 * estimation. The rate unit ~= (1500 bytes / 1 usec / 2^24) ~= 715 bps.
 * This handles bandwidths from 0.06pps (715bps) to 256Mpps (3Tbps) in a u32.
 * Since the minimum window is >=4 packets, the lower bound isn't
 * an issue. The upper bound isn't an issue with existing technologies.
 */
#define BW_SCALE 24
#define BW_UNIT (1 << BW_SCALE)

#define BBR_SCALE 8	/* scaling factor for fractions in BBR (e.g. gains) */
#define BBR_UNIT (1 << BBR_SCALE)

/* BBR has the following modes for deciding how fast to send: */
enum bbr_mode {
	BBR_STARTUP,	/* ramp up sending rate rapidly to fill pipe */
	BBR_DRAIN,	/* drain any queue created during startup */
	BBR_PROBE_BW,	/* discover, share bw: pace around estimated bw */
	BBR_PROBE_RTT,	/* cut inflight to min to probe min_rtt */
};


#define CYCLE_LEN	8	/* number of phases in a pacing gain cycle */

/* Window length of bw filter (in rounds): */
static const int bbr_bw_rtts = CYCLE_LEN + 2;
/* Window length of min_rtt filter (in sec): */
static const u32 bbr_min_rtt_win_sec = 10;
/* Minimum time (in ms) spent at bbr_cwnd_min_target in BBR_PROBE_RTT mode: */
static const u32 bbr_probe_rtt_mode_ms = 200;
/* Skip TSO below the following bandwidth (bits/sec): */
static const int bbr_min_tso_rate = 1200000;

/* We use a high_gain value of 2/ln(2) because it's the smallest pacing gain
 * that will allow a smoothly increasing pacing rate that will double each RTT
 * and send the same number of packets per RTT that an un-paced, slow-starting
 * Reno or CUBIC flow would:
 */
static const int bbr_high_gain  = BBR_UNIT * 2885 / 1000 + 1;
/* The pacing gain of 1/high_gain in BBR_DRAIN is calculated to typically drain
 * the queue created in BBR_STARTUP in a single round:
 */
static const int bbr_drain_gain = BBR_UNIT * 1000 / 2885;
/* The gain for deriving steady-state cwnd tolerates delayed/stretched ACKs: */
static const int bbr_cwnd_gain  = BBR_UNIT * 2;
/* The pacing_gain values for the PROBE_BW gain cycle, to discover/share bw: */
static const int bbr_pacing_gain[] = {
	BBR_UNIT * 5 / 4,	/* probe for more available bw */
	BBR_UNIT * 3 / 4,	/* drain queue and/or yield bw to other flows */
	BBR_UNIT, BBR_UNIT, BBR_UNIT,	/* cruise at 1.0*bw to utilize pipe, */
	BBR_UNIT, BBR_UNIT, BBR_UNIT	/* without creating excess queue... */
};
/* Randomize the starting gain cycling phase over N phases: */
static const u32 bbr_cycle_rand = 7;

/* Try to keep at least this many packets in flight, if things go smoothly. For
 * smooth functioning, a sliding window protocol ACKing every other packet
 * needs at least 4 packets in flight:
 */
static const u32 bbr_cwnd_min_target = 4;

/* To estimate if BBR_STARTUP mode (i.e. high_gain) has filled pipe... */
/* If bw has increased significantly (1.25x), there may be more bw available: */
static const u32 bbr_full_bw_thresh = BBR_UNIT * 5 / 4;
/* But after 3 rounds w/o significant bw growth, estimate pipe is full: */
static const u32 bbr_full_bw_cnt = 3;

/* "long-term" ("LT") bandwidth estimator parameters... */
/* The minimum number of rounds in an LT bw sampling interval: */
static const u32 bbr_lt_intvl_min_rtts = 4;
/* If lost/delivered ratio > 20%, interval is "lossy" and we may be policed: */
static const u32 bbr_lt_loss_thresh = 50;
/* If 2 intervals have a bw ratio <= 1/8, their bw is "consistent": */
static const u32 bbr_lt_bw_ratio = BBR_UNIT / 8;
/* If 2 intervals have a bw diff <= 4 Kbit/sec their bw is "consistent": */
static const u32 bbr_lt_bw_diff = 4000 / 8;
/* If we estimate we're policed, use lt_bw for this many round trips: */
static const u32 bbr_lt_bw_max_rtts = 48;

/* Gain factor for adding extra_acked to target cwnd: */
static const int bbr_extra_acked_gain = BBR_UNIT;
/* Window length of extra_acked window. */
static const u32 bbr_extra_acked_win_rtts = 5;
/* Max allowed val for ack_epoch_acked, after which sampling epoch is reset */
static const u32 bbr_ack_epoch_acked_reset_thresh = 1U << 20;
/* Time period for clamping cwnd increment due to ack aggregation */
static const u32 bbr_extra_acked_max_us = 100 * 1000;
	//--------------------------------------------------------------------------

static int fast_convergence __read_mostly = 1;		/* Fast convergence */
static int beta __read_mostly = 717;	/* = 717/1024 (MPTCP_QCC_BETA_SCALE) */
static int initial_ssthresh __read_mostly;			/* Initial slow start threshold */
static int bic_scale __read_mostly = 41;
static int tcp_friendliness __read_mostly = 1;		/* Friendliness */

static int hystart __read_mostly = 1;			/* HyStart switch */
static int hystart_detect __read_mostly = HYSTART_ACK_TRAIN | HYSTART_DELAY;
static int hystart_low_window __read_mostly = 16;		/* Unless cwnd exceeds this value, HyStart can be used */
static int hystart_ack_delta __read_mostly = 2;

static u32 cube_rtt_scale __read_mostly;
static u32 beta_scale __read_mostly;
static u64 cube_factor __read_mostly;

/* Note parameters that are used for precomputing scale factors are read-only */
module_param(fast_convergence, int, 0644);
MODULE_PARM_DESC(fast_convergence, "turn on/off fast convergence");
module_param(beta, int, 0644);
MODULE_PARM_DESC(beta, "beta for multiplicative increase");
module_param(initial_ssthresh, int, 0644);
MODULE_PARM_DESC(initial_ssthresh, "initial value of slow start threshold");
module_param(bic_scale, int, 0444);
MODULE_PARM_DESC(bic_scale, "scale (scaled by 1024) value for bic function (bic_scale/1024)");
module_param(tcp_friendliness, int, 0644);
MODULE_PARM_DESC(tcp_friendliness, "turn on/off tcp friendliness");
module_param(hystart, int, 0644);
MODULE_PARM_DESC(hystart, "turn on/off hybrid slow start algorithm");
module_param(hystart_detect, int, 0644);
MODULE_PARM_DESC(hystart_detect, "hyrbrid slow start detection mechanisms"
		 " 1: packet-train 2: delay 3: both packet-train and delay");
module_param(hystart_low_window, int, 0644);
MODULE_PARM_DESC(hystart_low_window, "lower bound cwnd for hybrid slow start");
module_param(hystart_ack_delta, int, 0644);
MODULE_PARM_DESC(hystart_ack_delta, "spacing between ack's indicating train (msecs)");


/* BIC TCP Parameters */
struct mptcp_qcc {
	u32	cnt;			/* increase cwnd by 1 after ACKs */
	u32	last_max_cwnd;	/* last maximum snd_cwnd */

	u32	last_cwnd;	/* the last snd_cwnd */
	u32	last_time;	/* time when updated last_cwnd */
	u32	bic_origin_point;/* origin point of bic function */
	u32	bic_K;		/* time to origin point
				   from the beginning of the current epoch */
	u32	delay_min;	/* min delay (msec << 3) */
	u32	epoch_start;	/* beginning of an epoch */
	u32	ack_cnt;	/* number of acks */
	u32	tcp_cwnd;	/* estimated tcp cwnd */
	u16	unused;
	u8	sample_cnt;	/* number of samples to decide curr_rtt */
	u8	found;		/* the exit point is found? */
	u32	qcc_round_start;	/* beginning of each round */
	u32	end_seq;	/* end_seq of the round */
	u32	last_ack;	/* last time when the ACK spacing is close */
	u32	curr_rtt;	/* the minimum rtt of current round */

	//--------------------------------------------------------------------------
	// BBR ADD	//struct bbr {}	/* BBR congestion control block */
	//--------------------------------------------------------------------------
	u32	min_rtt_us;	        /* min RTT in min_rtt_win_sec window */
	u32	min_rtt_stamp;	        /* timestamp of min_rtt_us */
	u32	probe_rtt_done_stamp;   /* end time for BBR_PROBE_RTT mode */
	struct minmax bw;	/* Max recent delivery rate in pkts/uS << 24 */

	u32	rtt_cnt;	    /* count of packet-timed rounds elapsed */
	u32     next_rtt_delivered; /* scb->tx.delivered at end of round */
	u64	cycle_mstamp;	     /* time of this cycle phase start */
	u32     mode:3,		     /* current bbr_mode in state machine */
		prev_ca_state:3,     /* CA state on previous ACK */
		packet_conservation:1,  /* use packet conservation? */
		round_start:1,	     /* start of packet-timed tx->ack round? */
		idle_restart:1,	     /* restarting after idle? */
		probe_rtt_round_done:1,  /* a BBR_PROBE_RTT round at 4 pkts? */
		unused_x:13,
		lt_is_sampling:1,    /* taking long-term ("LT") samples now? */
		lt_rtt_cnt:7,	     /* round trips in long-term interval */
		lt_use_bw:1;	     /* use lt_bw as our bw estimate? */
	u32	lt_bw;		     /* LT est delivery rate in pkts/uS << 24 */
	u32	lt_last_delivered;   /* LT intvl start: tp->delivered */
	u32	lt_last_stamp;	     /* LT intvl start: tp->delivered_mstamp */
	u32	lt_last_lost;	     /* LT intvl start: tp->lost */
	u32	pacing_gain:10,	/* current gain for setting pacing rate */
		cwnd_gain:10,	/* current gain for setting cwnd */
		full_bw_reached:1,   /* reached full bw in Startup? */
		full_bw_cnt:2,	/* number of rounds without large bw gains */
		cycle_idx:3,	/* current index in pacing_gain cycle array */
		has_seen_rtt:1, /* have we seen an RTT sample yet? */
		unused_b:5;
	u32	prior_cwnd;	/* prior cwnd upon entering loss recovery */
	u32	full_bw;	/* recent bw, to estimate if pipe is full */

	/* For tracking ACK aggregation: */
	u64	ack_epoch_mstamp;	/* start of ACK sampling epoch */
	u16	extra_acked[2];		/* max excess data ACKed in epoch */
	u32	ack_epoch_acked:20,	/* packets (S)ACKed in sampling epoch */
		extra_acked_win_rtts:5,	/* age of extra_acked, in round trips */
		extra_acked_win_idx:1,	/* current index in extra_acked array */
		unused_c:6;
	//--------------------------------------------------------------------------
};

static inline void mptcp_qcc_reset(struct mptcp_qcc *qcc, struct sock *sk)
{
	// QCC ADD
	struct tcp_sock *tp = tcp_sk(sk);

	qcc->cnt = 0;
	qcc->last_max_cwnd = 0;
//	qcc->loss_cwnd = 0;
	qcc->last_cwnd = 0;
	qcc->last_time = 0;
	qcc->bic_origin_point = 0;
	qcc->bic_K = 0;
	qcc->delay_min = 0;
	qcc->epoch_start = 0;
	qcc->ack_cnt = 0;
	qcc->tcp_cwnd = 0;
	qcc->found = 0;

	//--------------------------------------------------------------------------
	// QCC ADD
	//--------------------------------------------------------------------------
	tp->qccqms.cntRTT = 0;
	tp->qccqms.cumRTT = 0;
	//--------------------------------------------------------------------------
}

static inline u32 mptcp_qcc_clock(void)
{
#if HZ < 1000
	return ktime_to_ms(ktime_get_real());
#else
	return jiffies_to_msecs(jiffies);
#endif
}


static inline void mptcp_qcc_hystart_reset(struct sock *sk)
{
	struct tcp_sock *tp = tcp_sk(sk);
	struct mptcp_qcc *qcc = inet_csk_ca(sk);

	qcc->qcc_round_start = qcc->last_ack = mptcp_qcc_clock();
	qcc->end_seq = tp->snd_nxt;
	qcc->curr_rtt = 0;
	qcc->sample_cnt = 0;
}

static void bbr_init_pacing_rate_from_rtt(struct sock *sk);
static void bbr_reset_lt_bw_sampling(struct sock *sk);
static void bbr_reset_startup_mode(struct sock *sk);

static void mptcp_qcc_init(struct sock *sk)
{
	struct mptcp_qcc *qcc = inet_csk_ca(sk);

	// QCC ADD
	struct tcp_sock *tp = tcp_sk(sk);

	// BBR ADD
	struct mptcp_qcc *bbr = qcc;

	mptcp_qcc_reset(qcc, sk);

	if (hystart)
		mptcp_qcc_hystart_reset(sk);

	if (!hystart && initial_ssthresh)
		tcp_sk(sk)->snd_ssthresh = initial_ssthresh;

	//--------------------------------------------------------------------------
	// QCC ADD
	//--------------------------------------------------------------------------
	tp->qccqms.slowone = 1;

	tp->qccqms.triRound = 30;			// the trigger for QoE, The initial value is 30
	tp->qccqms.trigger = 0;			// Triggered after three rounds (triRound) of congestion control

	tp->qccqms.minRTT = 0x7fffffff;
	tp->qccqms.baseRTT = 0x7fffffff;

	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;	//#define TCP_INFINITE_SSTHRESH	0x7fffffff
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	// BBR ADD	//static void bbr_init(struct sock *sk)
	//--------------------------------------------------------------------------
	//struct tcp_sock *tp = tcp_sk(sk);
//	struct bbr *bbr = inet_csk_ca(sk);
//	struct mptcp_qcc *bbr = qcc;

	bbr->prior_cwnd = 0;
	//tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
	bbr->rtt_cnt = 0;
	bbr->next_rtt_delivered = 0;
	bbr->prev_ca_state = TCP_CA_Open;
	bbr->packet_conservation = 0;

	bbr->probe_rtt_done_stamp = 0;
	bbr->probe_rtt_round_done = 0;
	bbr->min_rtt_us = tcp_min_rtt(tp);
	bbr->min_rtt_stamp = tcp_jiffies32;

	minmax_reset(&bbr->bw, bbr->rtt_cnt, 0);  /* init max bw to 0 */

	bbr->has_seen_rtt = 0;
	bbr_init_pacing_rate_from_rtt(sk);

	bbr->round_start = 0;
	bbr->idle_restart = 0;
	bbr->full_bw_reached = 0;
	bbr->full_bw = 0;
	bbr->full_bw_cnt = 0;
	bbr->cycle_mstamp = 0;
	bbr->cycle_idx = 0;
	bbr_reset_lt_bw_sampling(sk);
	bbr_reset_startup_mode(sk);

	bbr->ack_epoch_mstamp = tp->tcp_mstamp;
	bbr->ack_epoch_acked = 0;
	bbr->extra_acked_win_rtts = 0;
	bbr->extra_acked_win_idx = 0;
	bbr->extra_acked[0] = 0;
	bbr->extra_acked[1] = 0;

	cmpxchg(&sk->sk_pacing_status, SK_PACING_NONE, SK_PACING_NEEDED);
	//--------------------------------------------------------------------------
}

	//--------------------------------------------------------------------------
	// BBR ADD many functions
	//--------------------------------------------------------------------------
/* Do we estimate that STARTUP filled the pipe? */
static bool bbr_full_bw_reached(const struct sock *sk)
{
//	const struct bbr *bbr = inet_csk_ca(sk);
	const struct mptcp_qcc *bbr = inet_csk_ca(sk);

	return bbr->full_bw_reached;
}

/* Return the windowed max recent bandwidth sample, in pkts/uS << BW_SCALE. */
static u32 bbr_max_bw(const struct sock *sk)
{
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	return minmax_get(&bbr->bw);
}

/* Return the estimated bandwidth of the path, in pkts/uS << BW_SCALE. */
static u32 bbr_bw(const struct sock *sk)
{
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	return bbr->lt_use_bw ? bbr->lt_bw : bbr_max_bw(sk);
}

/* Return maximum extra acked in past k-2k round trips,
 * where k = bbr_extra_acked_win_rtts.
 */
static u16 bbr_extra_acked(const struct sock *sk)
{
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	return max(bbr->extra_acked[0], bbr->extra_acked[1]);
}

/* Return rate in bytes per second, optionally with a gain.
 * The order here is chosen carefully to avoid overflow of u64. This should
 * work for input rates of up to 2.9Tbit/sec and gain of 2.89x.
 */
static u64 bbr_rate_bytes_per_sec(struct sock *sk, u64 rate, int gain)
{
	unsigned int mss = tcp_sk(sk)->mss_cache;

	if (!tcp_needs_internal_pacing(sk))
		mss = tcp_mss_to_mtu(sk, mss);
	rate *= mss;
	rate *= gain;
	rate >>= BBR_SCALE;
	rate *= USEC_PER_SEC;
	return rate >> BW_SCALE;
}

/* Convert a BBR bw and gain factor to a pacing rate in bytes per second. */
static u32 bbr_bw_to_pacing_rate(struct sock *sk, u32 bw, int gain)
{
	u64 rate = bw;

	rate = bbr_rate_bytes_per_sec(sk, rate, gain);
	rate = min_t(u64, rate, sk->sk_max_pacing_rate);
	return rate;
}

/* Initialize pacing rate to: high_gain * init_cwnd / RTT. */
static void bbr_init_pacing_rate_from_rtt(struct sock *sk)
{
	struct tcp_sock *tp = tcp_sk(sk);
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	u64 bw;
	u32 rtt_us;

	if (tp->srtt_us) {		/* any RTT sample yet? */
		rtt_us = max(tp->srtt_us >> 3, 1U);
		bbr->has_seen_rtt = 1;
	} else {			 /* no RTT sample yet */
		rtt_us = USEC_PER_MSEC;	 /* use nominal default RTT */
	}
	bw = (u64)tp->snd_cwnd * BW_UNIT;
	do_div(bw, rtt_us);
	sk->sk_pacing_rate = bbr_bw_to_pacing_rate(sk, bw, bbr_high_gain);
}

/* Pace using current bw estimate and a gain factor. In order to help drive the
 * network toward lower queues while maintaining high utilization and low
 * latency, the average pacing rate aims to be slightly (~1%) lower than the
 * estimated bandwidth. This is an important aspect of the design. In this
 * implementation this slightly lower pacing rate is achieved implicitly by not
 * including link-layer headers in the packet size used for the pacing rate.
 */
static void bbr_set_pacing_rate(struct sock *sk, u32 bw, int gain)
{
	struct tcp_sock *tp = tcp_sk(sk);
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	u32 rate = bbr_bw_to_pacing_rate(sk, bw, gain);

	if (unlikely(!bbr->has_seen_rtt && tp->srtt_us))
		bbr_init_pacing_rate_from_rtt(sk);
	if (bbr_full_bw_reached(sk) || rate > sk->sk_pacing_rate)
		sk->sk_pacing_rate = rate;
}

/* override sysctl_tcp_min_tso_segs */
static u32 bbr_min_tso_segs(struct sock *sk)
{
	return sk->sk_pacing_rate < (bbr_min_tso_rate >> 3) ? 1 : 2;
}

static u32 bbr_tso_segs_goal(struct sock *sk)
{
	struct tcp_sock *tp = tcp_sk(sk);
	u32 segs, bytes;

	/* Sort of tcp_tso_autosize() but ignoring
	 * driver provided sk_gso_max_size.
	 */
	bytes = min_t(u32, sk->sk_pacing_rate >> sk->sk_pacing_shift,
		      GSO_MAX_SIZE - 1 - MAX_TCP_HEADER);
	segs = max_t(u32, bytes / tp->mss_cache, bbr_min_tso_segs(sk));

	return min(segs, 0x7FU);
}

/* Save "last known good" cwnd so we can restore it after losses or PROBE_RTT */
static void bbr_save_cwnd(struct sock *sk)
{
	struct tcp_sock *tp = tcp_sk(sk);
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	if (bbr->prev_ca_state < TCP_CA_Recovery && bbr->mode != BBR_PROBE_RTT)
		bbr->prior_cwnd = tp->snd_cwnd;  /* this cwnd is good enough */
	else  /* loss recovery or BBR_PROBE_RTT have temporarily cut cwnd */
		bbr->prior_cwnd = max(bbr->prior_cwnd, tp->snd_cwnd);
}


/* Calculate bdp based on min RTT and the estimated bottleneck bandwidth:
 *
 * bdp = bw * min_rtt * gain
 *
 * The key factor, gain, controls the amount of queue. While a small gain
 * builds a smaller queue, it becomes more vulnerable to noise in RTT
 * measurements (e.g., delayed ACKs or other ACK compression effects). This
 * noise may cause BBR to under-estimate the rate.
 */
static u32 bbr_bdp(struct sock *sk, u32 bw, int gain)
{
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	u32 bdp;
	u64 w;

	/* If we've never had a valid RTT sample, cap cwnd at the initial
	 * default. This should only happen when the connection is not using TCP
	 * timestamps and has retransmitted all of the SYN/SYNACK/data packets
	 * ACKed so far. In this case, an RTO can cut cwnd to 1, in which
	 * case we need to slow-start up toward something safe: TCP_INIT_CWND.
	 */
	if (unlikely(bbr->min_rtt_us == ~0U))	 /* no valid RTT samples yet? */
		return TCP_INIT_CWND;  /* be safe: cap at default initial cwnd*/

	w = (u64)bw * bbr->min_rtt_us;

	/* Apply a gain to the given value, then remove the BW_SCALE shift. */
	bdp = (((w * gain) >> BBR_SCALE) + BW_UNIT - 1) / BW_UNIT;

	return bdp;
}

/* To achieve full performance in high-speed paths, we budget enough cwnd to
 * fit full-sized skbs in-flight on both end hosts to fully utilize the path:
 *   - one skb in sending host Qdisc,
 *   - one skb in sending host TSO/GSO engine
 *   - one skb being received by receiver host LRO/GRO/delayed-ACK engine
 * Don't worry, at low rates (bbr_min_tso_rate) this won't bloat cwnd because
 * in such cases tso_segs_goal is 1. The minimum cwnd is 4 packets,
 * which allows 2 outstanding 2-packet sequences, to try to keep pipe
 * full even with ACK-every-other-packet delayed ACKs.
 */
static u32 bbr_quantization_budget(struct sock *sk, u32 cwnd, int gain)
{
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);


	/* Allow enough full-sized skbs in flight to utilize end systems. */
	cwnd += 3 * bbr_tso_segs_goal(sk);

	/* Reduce delayed ACKs by rounding up cwnd to the next even number. */
	cwnd = (cwnd + 1) & ~1U;

	/* Ensure gain cycling gets inflight above BDP even for small BDPs. */
	if (bbr->mode == BBR_PROBE_BW && gain > BBR_UNIT)
		cwnd += 2;

	return cwnd;
}

/* Find inflight based on min RTT and the estimated bottleneck bandwidth. */
static u32 bbr_inflight(struct sock *sk, u32 bw, int gain)
{
	u32 inflight;

	inflight = bbr_bdp(sk, bw, gain);
	inflight = bbr_quantization_budget(sk, inflight, gain);

	return inflight;
}

/* Find the cwnd increment based on estimate of ack aggregation */
static u32 bbr_ack_aggregation_cwnd(struct sock *sk)
{
	u32 max_aggr_cwnd, aggr_cwnd = 0;

	if (bbr_extra_acked_gain && bbr_full_bw_reached(sk)) {
		max_aggr_cwnd = ((u64)bbr_bw(sk) * bbr_extra_acked_max_us)
				/ BW_UNIT;
		aggr_cwnd = (bbr_extra_acked_gain * bbr_extra_acked(sk))
			     >> BBR_SCALE;
		aggr_cwnd = min(aggr_cwnd, max_aggr_cwnd);
	}

	return aggr_cwnd;
}

/* An optimization in BBR to reduce losses: On the first round of recovery, we
 * follow the packet conservation principle: send P packets per P packets acked.
 * After that, we slow-start and send at most 2*P packets per P packets acked.
 * After recovery finishes, or upon undo, we restore the cwnd we had when
 * recovery started (capped by the target cwnd based on estimated BDP).
 *
 * TODO(ycheng/ncardwell): implement a rate-based approach.
 */
static bool bbr_set_cwnd_to_recover_or_restore(
	struct sock *sk, const struct rate_sample *rs, u32 acked, u32 *new_cwnd)
{
	struct tcp_sock *tp = tcp_sk(sk);
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	u8 prev_state = bbr->prev_ca_state, state = inet_csk(sk)->icsk_ca_state;
	u32 cwnd = tp->snd_cwnd;

	/* An ACK for P pkts should release at most 2*P packets. We do this
	 * in two steps. First, here we deduct the number of lost packets.
	 * Then, in bbr_set_cwnd() we slow start up toward the target cwnd.
	 */
	if (rs->losses > 0)
		cwnd = max_t(s32, cwnd - rs->losses, 1);

	if (state == TCP_CA_Recovery && prev_state != TCP_CA_Recovery) {
		/* Starting 1st round of Recovery, so do packet conservation. */
		bbr->packet_conservation = 1;
		bbr->next_rtt_delivered = tp->delivered;  /* start round now */
		/* Cut unused cwnd from app behavior, TSQ, or TSO deferral: */
		cwnd = tcp_packets_in_flight(tp) + acked;
	} else if (prev_state >= TCP_CA_Recovery && state < TCP_CA_Recovery) {
		/* Exiting loss recovery; restore cwnd saved before recovery. */
		cwnd = max(cwnd, bbr->prior_cwnd);
		bbr->packet_conservation = 0;
	}
	bbr->prev_ca_state = state;

	if (bbr->packet_conservation) {
		*new_cwnd = max(cwnd, tcp_packets_in_flight(tp) + acked);
		return true;	/* yes, using packet conservation */
	}
	*new_cwnd = cwnd;
	return false;
}

/* Slow-start up toward target cwnd (if bw estimate is growing, or packet loss
 * has drawn us down below target), or snap down to target if we're above it.
 */
//static void bbr_set_cwnd(struct sock *sk, const struct rate_sample *rs,
static u32 bbr_set_cwnd(struct sock *sk, const struct rate_sample *rs,
			 u32 acked, u32 bw, int gain)
{
	struct tcp_sock *tp = tcp_sk(sk);
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	u32 cwnd = tp->snd_cwnd, target_cwnd = 0;

	//ztg add
	u32 bbr_cwnd;

	if (!acked)
		goto done;  /* no packet fully ACKed; just apply caps */

	if (bbr_set_cwnd_to_recover_or_restore(sk, rs, acked, &cwnd))
		goto done;

	target_cwnd = bbr_bdp(sk, bw, gain);

	/* Increment the cwnd to account for excess ACKed data that seems
	 * due to aggregation (of data and/or ACKs) visible in the ACK stream.
	 */
	target_cwnd += bbr_ack_aggregation_cwnd(sk);
	target_cwnd = bbr_quantization_budget(sk, target_cwnd, gain);

	/* If we're below target cwnd, slow start cwnd toward target cwnd. */
	if (bbr_full_bw_reached(sk))  /* only cut cwnd if we filled the pipe */
		cwnd = min(cwnd + acked, target_cwnd);
	else if (cwnd < target_cwnd || tp->delivered < TCP_INIT_CWND)
		cwnd = cwnd + acked;
	cwnd = max(cwnd, bbr_cwnd_min_target);

done:
//ztg
//	tp->snd_cwnd = min(cwnd, tp->snd_cwnd_clamp);	/* apply global cap */
	bbr_cwnd = min(cwnd, tp->snd_cwnd_clamp);		/* apply global cap */

	if (bbr->mode == BBR_PROBE_RTT)  			/* drain queue, refresh min_rtt */
//ztg
//		tp->snd_cwnd = min(tp->snd_cwnd, bbr_cwnd_min_target);
		bbr_cwnd = min(bbr_cwnd, bbr_cwnd_min_target);

	//ztg add
	return bbr_cwnd;
}

/* End cycle phase if it's time and/or we hit the phase's in-flight target. */
static bool bbr_is_next_cycle_phase(struct sock *sk,
				    const struct rate_sample *rs)
{
	struct tcp_sock *tp = tcp_sk(sk);
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	bool is_full_length =
		tcp_stamp_us_delta(tp->delivered_mstamp, bbr->cycle_mstamp) >
		bbr->min_rtt_us;
	u32 inflight, bw;

	/* The pacing_gain of 1.0 paces at the estimated bw to try to fully
	 * use the pipe without increasing the queue.
	 */
	if (bbr->pacing_gain == BBR_UNIT)
		return is_full_length;		/* just use wall clock time */

	inflight = rs->prior_in_flight;  /* what was in-flight before ACK? */
	bw = bbr_max_bw(sk);

	/* A pacing_gain > 1.0 probes for bw by trying to raise inflight to at
	 * least pacing_gain*BDP; this may take more than min_rtt if min_rtt is
	 * small (e.g. on a LAN). We do not persist if packets are lost, since
	 * a path with small buffers may not hold that much.
	 */
	if (bbr->pacing_gain > BBR_UNIT)
		return is_full_length &&
			(rs->losses ||  /* perhaps pacing_gain*BDP won't fit */
			 inflight >= bbr_inflight(sk, bw, bbr->pacing_gain));

	/* A pacing_gain < 1.0 tries to drain extra queue we added if bw
	 * probing didn't find more bw. If inflight falls to match BDP then we
	 * estimate queue is drained; persisting would underutilize the pipe.
	 */
	return is_full_length ||
		inflight <= bbr_inflight(sk, bw, BBR_UNIT);
}

static void bbr_advance_cycle_phase(struct sock *sk)
{
	struct tcp_sock *tp = tcp_sk(sk);
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	bbr->cycle_idx = (bbr->cycle_idx + 1) & (CYCLE_LEN - 1);
	bbr->cycle_mstamp = tp->delivered_mstamp;
	bbr->pacing_gain = bbr->lt_use_bw ? BBR_UNIT :
					    bbr_pacing_gain[bbr->cycle_idx];
}

/* Gain cycling: cycle pacing gain to converge to fair share of available bw. */
static void bbr_update_cycle_phase(struct sock *sk,
				   const struct rate_sample *rs)
{
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	if (bbr->mode == BBR_PROBE_BW && bbr_is_next_cycle_phase(sk, rs))
		bbr_advance_cycle_phase(sk);
}

static void bbr_reset_startup_mode(struct sock *sk)
{
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	bbr->mode = BBR_STARTUP;
	bbr->pacing_gain = bbr_high_gain;
	bbr->cwnd_gain	 = bbr_high_gain;
}

static void bbr_reset_probe_bw_mode(struct sock *sk)
{
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	bbr->mode = BBR_PROBE_BW;
	bbr->pacing_gain = BBR_UNIT;
	bbr->cwnd_gain = bbr_cwnd_gain;
	bbr->cycle_idx = CYCLE_LEN - 1 - prandom_u32_max(bbr_cycle_rand);
	bbr_advance_cycle_phase(sk);	/* flip to next phase of gain cycle */
}

static void bbr_reset_mode(struct sock *sk)
{
	if (!bbr_full_bw_reached(sk))
		bbr_reset_startup_mode(sk);
	else
		bbr_reset_probe_bw_mode(sk);
}

/* Start a new long-term sampling interval. */
static void bbr_reset_lt_bw_sampling_interval(struct sock *sk)
{
	struct tcp_sock *tp = tcp_sk(sk);
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	bbr->lt_last_stamp = div_u64(tp->delivered_mstamp, USEC_PER_MSEC);
	bbr->lt_last_delivered = tp->delivered;
	bbr->lt_last_lost = tp->lost;
	bbr->lt_rtt_cnt = 0;
}

/* Completely reset long-term bandwidth sampling. */
static void bbr_reset_lt_bw_sampling(struct sock *sk)
{
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	bbr->lt_bw = 0;
	bbr->lt_use_bw = 0;
	bbr->lt_is_sampling = false;
	bbr_reset_lt_bw_sampling_interval(sk);
}

/* Long-term bw sampling interval is done. Estimate whether we're policed. */
static void bbr_lt_bw_interval_done(struct sock *sk, u32 bw)
{
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	u32 diff;

	if (bbr->lt_bw) {  /* do we have bw from a previous interval? */
		/* Is new bw close to the lt_bw from the previous interval? */
		diff = abs(bw - bbr->lt_bw);
		if ((diff * BBR_UNIT <= bbr_lt_bw_ratio * bbr->lt_bw) ||
		    (bbr_rate_bytes_per_sec(sk, diff, BBR_UNIT) <=
		     bbr_lt_bw_diff)) {
			/* All criteria are met; estimate we're policed. */
			bbr->lt_bw = (bw + bbr->lt_bw) >> 1;  /* avg 2 intvls */
			bbr->lt_use_bw = 1;
			bbr->pacing_gain = BBR_UNIT;  /* try to avoid drops */
			bbr->lt_rtt_cnt = 0;
			return;
		}
	}
	bbr->lt_bw = bw;
	bbr_reset_lt_bw_sampling_interval(sk);
}

/* Token-bucket traffic policers are common (see "An Internet-Wide Analysis of
 * Traffic Policing", SIGCOMM 2016). BBR detects token-bucket policers and
 * explicitly models their policed rate, to reduce unnecessary losses. We
 * estimate that we're policed if we see 2 consecutive sampling intervals with
 * consistent throughput and high packet loss. If we think we're being policed,
 * set lt_bw to the "long-term" average delivery rate from those 2 intervals.
 */
static void bbr_lt_bw_sampling(struct sock *sk, const struct rate_sample *rs)
{
	struct tcp_sock *tp = tcp_sk(sk);
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	u32 lost, delivered;
	u64 bw;
	u32 t;

	if (bbr->lt_use_bw) {	/* already using long-term rate, lt_bw? */
		if (bbr->mode == BBR_PROBE_BW && bbr->round_start &&
		    ++bbr->lt_rtt_cnt >= bbr_lt_bw_max_rtts) {
			bbr_reset_lt_bw_sampling(sk);    /* stop using lt_bw */
			bbr_reset_probe_bw_mode(sk);  /* restart gain cycling */
		}
		return;
	}

	/* Wait for the first loss before sampling, to let the policer exhaust
	 * its tokens and estimate the steady-state rate allowed by the policer.
	 * Starting samples earlier includes bursts that over-estimate the bw.
	 */
	if (!bbr->lt_is_sampling) {
		if (!rs->losses)
			return;
		bbr_reset_lt_bw_sampling_interval(sk);
		bbr->lt_is_sampling = true;
	}

	/* To avoid underestimates, reset sampling if we run out of data. */
	if (rs->is_app_limited) {
		bbr_reset_lt_bw_sampling(sk);
		return;
	}

	if (bbr->round_start)
		bbr->lt_rtt_cnt++;	/* count round trips in this interval */
	if (bbr->lt_rtt_cnt < bbr_lt_intvl_min_rtts)
		return;		/* sampling interval needs to be longer */
	if (bbr->lt_rtt_cnt > 4 * bbr_lt_intvl_min_rtts) {
		bbr_reset_lt_bw_sampling(sk);  /* interval is too long */
		return;
	}

	/* End sampling interval when a packet is lost, so we estimate the
	 * policer tokens were exhausted. Stopping the sampling before the
	 * tokens are exhausted under-estimates the policed rate.
	 */
	if (!rs->losses)
		return;

	/* Calculate packets lost and delivered in sampling interval. */
	lost = tp->lost - bbr->lt_last_lost;
	delivered = tp->delivered - bbr->lt_last_delivered;
	/* Is loss rate (lost/delivered) >= lt_loss_thresh? If not, wait. */
	if (!delivered || (lost << BBR_SCALE) < bbr_lt_loss_thresh * delivered)
		return;

	/* Find average delivery rate in this sampling interval. */
	t = div_u64(tp->delivered_mstamp, USEC_PER_MSEC) - bbr->lt_last_stamp;
	if ((s32)t < 1)
		return;		/* interval is less than one ms, so wait */
	/* Check if can multiply without overflow */
	if (t >= ~0U / USEC_PER_MSEC) {
		bbr_reset_lt_bw_sampling(sk);  /* interval too long; reset */
		return;
	}
	t *= USEC_PER_MSEC;
	bw = (u64)delivered * BW_UNIT;
	do_div(bw, t);
	bbr_lt_bw_interval_done(sk, bw);
}

/* Estimate the bandwidth based on how fast packets are delivered */
static void bbr_update_bw(struct sock *sk, const struct rate_sample *rs)
{
	struct tcp_sock *tp = tcp_sk(sk);
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	u64 bw;

	bbr->round_start = 0;
	if (rs->delivered < 0 || rs->interval_us <= 0)
		return; /* Not a valid observation */

	/* See if we've reached the next RTT */
	if (!before(rs->prior_delivered, bbr->next_rtt_delivered)) {
		bbr->next_rtt_delivered = tp->delivered;
		bbr->rtt_cnt++;
		bbr->round_start = 1;
		bbr->packet_conservation = 0;
	}

	bbr_lt_bw_sampling(sk, rs);

	/* Divide delivered by the interval to find a (lower bound) bottleneck
	 * bandwidth sample. Delivered is in packets and interval_us in uS and
	 * ratio will be <<1 for most connections. So delivered is first scaled.
	 */
	bw = div64_long((u64)rs->delivered * BW_UNIT, rs->interval_us);

	/* If this sample is application-limited, it is likely to have a very
	 * low delivered count that represents application behavior rather than
	 * the available network rate. Such a sample could drag down estimated
	 * bw, causing needless slow-down. Thus, to continue to send at the
	 * last measured network rate, we filter out app-limited samples unless
	 * they describe the path bw at least as well as our bw model.
	 *
	 * So the goal during app-limited phase is to proceed with the best
	 * network rate no matter how long. We automatically leave this
	 * phase when app writes faster than the network can deliver :)
	 */
	if (!rs->is_app_limited || bw >= bbr_max_bw(sk)) {
		/* Incorporate new sample into our max bw filter. */
		minmax_running_max(&bbr->bw, bbr_bw_rtts, bbr->rtt_cnt, bw);
	}
}

/* Estimates the windowed max degree of ack aggregation.
 * This is used to provision extra in-flight data to keep sending during
 * inter-ACK silences.
 *
 * Degree of ack aggregation is estimated as extra data acked beyond expected.
 *
 * max_extra_acked = "maximum recent excess data ACKed beyond max_bw * interval"
 * cwnd += max_extra_acked
 *
 * Max extra_acked is clamped by cwnd and bw * bbr_extra_acked_max_us (100 ms).
 * Max filter is an approximate sliding window of 5-10 (packet timed) round
 * trips.
 */
static void bbr_update_ack_aggregation(struct sock *sk,
				       const struct rate_sample *rs)
{
	u32 epoch_us, expected_acked, extra_acked;
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	struct tcp_sock *tp = tcp_sk(sk);

	if (!bbr_extra_acked_gain || rs->acked_sacked <= 0 ||
	    rs->delivered < 0 || rs->interval_us <= 0)
		return;

	if (bbr->round_start) {
		bbr->extra_acked_win_rtts = min(0x1F,
						bbr->extra_acked_win_rtts + 1);
		if (bbr->extra_acked_win_rtts >= bbr_extra_acked_win_rtts) {
			bbr->extra_acked_win_rtts = 0;
			bbr->extra_acked_win_idx = bbr->extra_acked_win_idx ?
						   0 : 1;
			bbr->extra_acked[bbr->extra_acked_win_idx] = 0;
		}
	}

	/* Compute how many packets we expected to be delivered over epoch. */
	epoch_us = tcp_stamp_us_delta(tp->delivered_mstamp,
				      bbr->ack_epoch_mstamp);
	expected_acked = ((u64)bbr_bw(sk) * epoch_us) / BW_UNIT;

	/* Reset the aggregation epoch if ACK rate is below expected rate or
	 * significantly large no. of ack received since epoch (potentially
	 * quite old epoch).
	 */
	if (bbr->ack_epoch_acked <= expected_acked ||
	    (bbr->ack_epoch_acked + rs->acked_sacked >=
	     bbr_ack_epoch_acked_reset_thresh)) {
		bbr->ack_epoch_acked = 0;
		bbr->ack_epoch_mstamp = tp->delivered_mstamp;
		expected_acked = 0;
	}

	/* Compute excess data delivered, beyond what was expected. */
	bbr->ack_epoch_acked = min_t(u32, 0xFFFFF,
				     bbr->ack_epoch_acked + rs->acked_sacked);
	extra_acked = bbr->ack_epoch_acked - expected_acked;
	extra_acked = min(extra_acked, tp->snd_cwnd);
	if (extra_acked > bbr->extra_acked[bbr->extra_acked_win_idx])
		bbr->extra_acked[bbr->extra_acked_win_idx] = extra_acked;
}

/* Estimate when the pipe is full, using the change in delivery rate: BBR
 * estimates that STARTUP filled the pipe if the estimated bw hasn't changed by
 * at least bbr_full_bw_thresh (25%) after bbr_full_bw_cnt (3) non-app-limited
 * rounds. Why 3 rounds: 1: rwin autotuning grows the rwin, 2: we fill the
 * higher rwin, 3: we get higher delivery rate samples. Or transient
 * cross-traffic or radio noise can go away. CUBIC Hystart shares a similar
 * design goal, but uses delay and inter-ACK spacing instead of bandwidth.
 */
static void bbr_check_full_bw_reached(struct sock *sk,
				      const struct rate_sample *rs)
{
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	u32 bw_thresh;

	if (bbr_full_bw_reached(sk) || !bbr->round_start || rs->is_app_limited)
		return;

	bw_thresh = (u64)bbr->full_bw * bbr_full_bw_thresh >> BBR_SCALE;
	if (bbr_max_bw(sk) >= bw_thresh) {
		bbr->full_bw = bbr_max_bw(sk);
		bbr->full_bw_cnt = 0;
		return;
	}
	++bbr->full_bw_cnt;
	bbr->full_bw_reached = bbr->full_bw_cnt >= bbr_full_bw_cnt;
}

/* If pipe is probably full, drain the queue and then enter steady-state. */
static void bbr_check_drain(struct sock *sk, const struct rate_sample *rs)
{
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	if (bbr->mode == BBR_STARTUP && bbr_full_bw_reached(sk)) {
		bbr->mode = BBR_DRAIN;	/* drain queue we created */
		bbr->pacing_gain = bbr_drain_gain;	/* pace slow to drain */
		bbr->cwnd_gain = bbr_high_gain;	/* maintain cwnd */
		tcp_sk(sk)->snd_ssthresh =
				bbr_inflight(sk, bbr_max_bw(sk), BBR_UNIT);
	}	/* fall through to check if in-flight is already small: */
	if (bbr->mode == BBR_DRAIN &&
	    tcp_packets_in_flight(tcp_sk(sk)) <=
	    bbr_inflight(sk, bbr_max_bw(sk), BBR_UNIT))
		bbr_reset_probe_bw_mode(sk);  /* we estimate queue is drained */
}

static void bbr_check_probe_rtt_done(struct sock *sk)
{
	struct tcp_sock *tp = tcp_sk(sk);
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	if (!(bbr->probe_rtt_done_stamp &&
	      after(tcp_jiffies32, bbr->probe_rtt_done_stamp)))
		return;

	bbr->min_rtt_stamp = tcp_jiffies32;  /* wait a while until PROBE_RTT */
	tp->snd_cwnd = max(tp->snd_cwnd, bbr->prior_cwnd);
	bbr_reset_mode(sk);
}

/* The goal of PROBE_RTT mode is to have BBR flows cooperatively and
 * periodically drain the bottleneck queue, to converge to measure the true
 * min_rtt (unloaded propagation delay). This allows the flows to keep queues
 * small (reducing queuing delay and packet loss) and achieve fairness among
 * BBR flows.
 *
 * The min_rtt filter window is 10 seconds. When the min_rtt estimate expires,
 * we enter PROBE_RTT mode and cap the cwnd at bbr_cwnd_min_target=4 packets.
 * After at least bbr_probe_rtt_mode_ms=200ms and at least one packet-timed
 * round trip elapsed with that flight size <= 4, we leave PROBE_RTT mode and
 * re-enter the previous mode. BBR uses 200ms to approximately bound the
 * performance penalty of PROBE_RTT's cwnd capping to roughly 2% (200ms/10s).
 *
 * Note that flows need only pay 2% if they are busy sending over the last 10
 * seconds. Interactive applications (e.g., Web, RPCs, video chunks) often have
 * natural silences or low-rate periods within 10 seconds where the rate is low
 * enough for long enough to drain its queue in the bottleneck. We pick up
 * these min RTT measurements opportunistically with our min_rtt filter. :-)
 */
static void bbr_update_min_rtt(struct sock *sk, const struct rate_sample *rs)
{
	struct tcp_sock *tp = tcp_sk(sk);
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = inet_csk_ca(sk);

	bool filter_expired;

	/* Track min RTT seen in the min_rtt_win_sec filter window: */
	filter_expired = after(tcp_jiffies32,
			       bbr->min_rtt_stamp + bbr_min_rtt_win_sec * HZ);
	if (rs->rtt_us >= 0 &&
	    (rs->rtt_us < bbr->min_rtt_us ||
	     (filter_expired && !rs->is_ack_delayed))) {
		bbr->min_rtt_us = rs->rtt_us;
		bbr->min_rtt_stamp = tcp_jiffies32;
	}

	if (bbr_probe_rtt_mode_ms > 0 && filter_expired &&
	    !bbr->idle_restart && bbr->mode != BBR_PROBE_RTT) {
		bbr->mode = BBR_PROBE_RTT;  /* dip, drain queue */
		bbr->pacing_gain = BBR_UNIT;
		bbr->cwnd_gain = BBR_UNIT;
		bbr_save_cwnd(sk);  /* note cwnd so we can restore it */
		bbr->probe_rtt_done_stamp = 0;
	}

	if (bbr->mode == BBR_PROBE_RTT) {
		/* Ignore low rate samples during this mode. */
		tp->app_limited =
			(tp->delivered + tcp_packets_in_flight(tp)) ? : 1;
		/* Maintain min packets in flight for max(200 ms, 1 round). */
		if (!bbr->probe_rtt_done_stamp &&
		    tcp_packets_in_flight(tp) <= bbr_cwnd_min_target) {
			bbr->probe_rtt_done_stamp = tcp_jiffies32 +
				msecs_to_jiffies(bbr_probe_rtt_mode_ms);
			bbr->probe_rtt_round_done = 0;
			bbr->next_rtt_delivered = tp->delivered;
		} else if (bbr->probe_rtt_done_stamp) {
			if (bbr->round_start)
				bbr->probe_rtt_round_done = 1;
			if (bbr->probe_rtt_round_done)
				bbr_check_probe_rtt_done(sk);
		}
	}
	/* Restart after idle ends only once we process a new S/ACK for data */
	if (rs->delivered > 0)
		bbr->idle_restart = 0;
}

static void bbr_update_model(struct sock *sk, const struct rate_sample *rs)
{
	bbr_update_bw(sk, rs);
	bbr_update_ack_aggregation(sk, rs);
	bbr_update_cycle_phase(sk, rs);
	bbr_check_full_bw_reached(sk, rs);
	bbr_check_drain(sk, rs);
	bbr_update_min_rtt(sk, rs);
}

	//--------------------------------------------------------------------------


static void mptcp_qcc_cwnd_event(struct sock *sk, enum tcp_ca_event event)
{
	struct tcp_sock *tp = tcp_sk(sk);
	struct mptcp_qcc *qcc = inet_csk_ca(sk);

	//--------------------------------------------------------------------------
	// BBR ADD	static void bbr_cwnd_event(struct sock *sk, enum tcp_ca_event event)
	//--------------------------------------------------------------------------
	//struct tcp_sock *tp = tcp_sk(sk);
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = qcc;

	if (event == CA_EVENT_TX_START && tp->app_limited) {
		bbr->idle_restart = 1;
		bbr->ack_epoch_mstamp = tp->tcp_mstamp;
		bbr->ack_epoch_acked = 0;
		/* Avoid pointless buffer overflows: pace at est. bw if we don't
		 * need more speed (we're restarting from idle and app-limited).
		 */
		if (bbr->mode == BBR_PROBE_BW)
			bbr_set_pacing_rate(sk, bbr_bw(sk), BBR_UNIT);
		else if (bbr->mode == BBR_PROBE_RTT)
			bbr_check_probe_rtt_done(sk);
	}
	//--------------------------------------------------------------------------

	if (event == CA_EVENT_TX_START) {
//		struct mptcp_qcc *qcc = inet_csk_ca(sk);
//		u32 now = tcp_time_stamp;
		u32 now = tcp_time_stamp(tp);

		s32 delta;

//		delta = now - tcp_sk(sk)->lsndtime;
		delta = now - tp->lsndtime;

		/* We were application limited (idle) for a while.
		 * Shift epoch_start to keep cwnd growth to cubic curve.
		 */
		if (qcc->epoch_start && delta > 0) {
			qcc->epoch_start += delta;
			if (after(qcc->epoch_start, now))
				qcc->epoch_start = now;
		}
		return;
	}
}

/* calculate the cubic root of x using a table lookup followed by one
 * Newton-Raphson iteration.
 * Avg err ~= 0.195%
 */
static u32 cubic_root(u64 a)
{
	u32 x, b, shift;
	/*
	 * cbrt(x) MSB values for x MSB values in [0..63].
	 * Precomputed then refined by hand - Willy Tarreau
	 *
	 * For x in [0..63],
	 *   v = cbrt(x << 18) - 1
	 *   cbrt(x) = (v[x] + 10) >> 6
	 */
	static const u8 v[] = {
		/* 0x00 */    0,   54,   54,   54,  118,  118,  118,  118,
		/* 0x08 */  123,  129,  134,  138,  143,  147,  151,  156,
		/* 0x10 */  157,  161,  164,  168,  170,  173,  176,  179,
		/* 0x18 */  181,  185,  187,  190,  192,  194,  197,  199,
		/* 0x20 */  200,  202,  204,  206,  209,  211,  213,  215,
		/* 0x28 */  217,  219,  221,  222,  224,  225,  227,  229,
		/* 0x30 */  231,  232,  234,  236,  237,  239,  240,  242,
		/* 0x38 */  244,  245,  246,  248,  250,  251,  252,  254,
	};

	b = fls64(a);
	if (b < 7) {
		/* a in [0..63] */
		return ((u32)v[(u32)a] + 35) >> 6;
	}

	b = ((b * 84) >> 8) - 1;
	shift = (a >> (b * 3));

	x = ((u32)(((u32)v[shift] + 10) << b)) >> 6;

	/*
	 * Newton-Raphson iteration
	 *                         2
	 * x    = ( 2 * x  +  a / x  ) / 3
	 *  k+1          k         k
	 */
	x = (2 * x + (u32)div64_u64(a, (u64)x * (u64)(x - 1)));
	x = ((x * 341) >> 10);
	return x;
}


/*
 * Compute congestion window to use.
 */
static inline void mptcp_qcc_update(struct sock *sk, struct mptcp_qcc *qcc, u32 cwnd, u32 acked)
{
	// QCC ADD
	struct tcp_sock *tp = tcp_sk(sk);

	u32 delta, bic_target, max_cnt;	/* delta is the difference of cwnd, bic_target is the predicted value, t is the predicted time */
	u64 offs, t;				/* Time difference, offs = | t - K | */

	qcc->ack_cnt += acked;	/* count the number of ACKed packets */

	if (qcc->last_cwnd == cwnd &&
//	    (s32)(tcp_time_stamp - qcc->last_time) <= HZ / 32)
	    (s32)(tcp_time_stamp(tp) - qcc->last_time) <= HZ / 32)
		return;

	/* The CUBIC function can update qcc->cnt at most once per jiffy.
	 * On all cwnd reduction events, qcc->epoch_start is set to 0,
	 * which will force a recalculation of qcc->cnt.
	 */
//	if (qcc->epoch_start && tcp_time_stamp == qcc->last_time)
	if (qcc->epoch_start && tcp_time_stamp(tp) == qcc->last_time)
		goto tcp_friendliness;

	qcc->last_cwnd = cwnd;
//	qcc->last_time = tcp_time_stamp;
	qcc->last_time = tcp_time_stamp(tp);

	/* After packet loss, a new period */
	if (qcc->epoch_start == 0) {
//		qcc->epoch_start = tcp_time_stamp;	/* record the beginning of an epoch */
		qcc->epoch_start = tcp_time_stamp(tp);	/* record the beginning of an epoch */

		qcc->ack_cnt = acked;			/* start counting */
		qcc->tcp_cwnd = cwnd;			/* syn with cubic */

		if (qcc->last_max_cwnd <= cwnd) {
			qcc->bic_K = 0;
			qcc->bic_origin_point = cwnd;
		} else {
			/* Compute new K based on
			 * (wmax-cwnd) * (srtt>>3 / HZ) / c * 2^(3*mptcp_qcc_HZ)
			 */
					/* Compute new K 
					 * cube_factor = 2^40 / (41*10) = 2^30 / ( C*10) = 2^30 / 0.4
					 */
			qcc->bic_K = cubic_root(cube_factor
					       * (qcc->last_max_cwnd - cwnd));
			qcc->bic_origin_point = qcc->last_max_cwnd;
		}
	}


	/* cubic function - calc*/
	/* calculate c * time^3 / rtt,
	 *  while considering overflow in calculation of time^3
	 * (so time^3 is done by using 64 bit)
	 * and without the support of division of 64bit numbers
	 * (so all divisions are done by using 32 bit)
	 *  also NOTE the unit of those veriables
	 *	  time  = (t - K) / 2^mptcp_qcc_HZ
	 *	  c = bic_scale >> 10
	 * rtt  = (srtt >> 3) / HZ
	 * !!! The following code does not have overflow problems,
	 * if the cwnd < 1 million packets !!!
	 */

//	t = (s32)(tcp_time_stamp - qcc->epoch_start);
	t = (s32)(tcp_time_stamp(tp) - qcc->epoch_start);

	t += msecs_to_jiffies(qcc->delay_min >> 3);
	/* change the unit from HZ to mptcp_qcc_HZ */
	t <<= MPTCP_QCC_HZ;
	do_div(t, HZ);

	if (t < qcc->bic_K)		/* t - K */		/* Wmax has not been reached yet */
		offs = qcc->bic_K - t;
	else
		offs = t - qcc->bic_K;			/* Wmax has been exceeded at this time */

	/* c/rtt * (t-K)^3 */
	delta = (cube_rtt_scale * offs * offs * offs) >> (10+3*MPTCP_QCC_HZ);
	/* Calculate bic_target, that is, predict cwnd */
	if (t < qcc->bic_K)                            /* below origin*/
		bic_target = qcc->bic_origin_point - delta;
	else                                          /* above origin*/
		bic_target = qcc->bic_origin_point + delta;

	/* cubic function - calc mptcp_qcc_cnt*/
	if (bic_target > cwnd) {
		qcc->cnt = cwnd / (bic_target - cwnd);		/* The more the difference, the faster the growth, which is the origin of the function shape */
	} else {
		qcc->cnt = 100 * cwnd;              /* very small increment*/
	}

	/*
	 * The initial growth of cubic function may be too conservative
	 * when the available bandwidth is still unknown.
	 */
	if (qcc->last_max_cwnd == 0 && qcc->cnt > 20)
		qcc->cnt = 20;	/* increase cwnd 5% per RTT */

tcp_friendliness:
	/* TCP Friendly */
	if (tcp_friendliness) {
		u32 scale = beta_scale;

		delta = (cwnd * scale) >> 3;		/* delta represents how much ACK can make tcp_cwnd++ */
		while (qcc->ack_cnt > delta) {		/* update tcp_cwnd */
			qcc->ack_cnt -= delta;
			qcc->tcp_cwnd++;
		}

		if (qcc->tcp_cwnd > cwnd) {	/* if bic is slower than tcp */
			delta = qcc->tcp_cwnd - cwnd;
			max_cnt = cwnd / delta;

	// QCC ADD
//			if (qcc->cnt > max_cnt) qcc->cnt = max_cnt;
			//--------------------------------------------------------------------------
			// QCC ADD
			//--------------------------------------------------------------------------
//			if (tp->qccqms.trigger && ( (!!(tp->qccqms.qoe & QCC_WIFI) && !!(tp->qccqms.qoe & QCC_CELLULAR) && !(tp->qccqms.qoe & ~3U)) || (!!(tp->qccqms.qoe & QCC_BIGFILE) && !(tp->qccqms.qoe & QCC_REALTIME)) ) ) {
			if (tp->qccqms.trigger && (tp->qccqms.qoe==3 || tp->qccqms.qoe==7) ) {
				if (qcc->cnt < max_cnt) qcc->cnt = max_cnt;				// let qcc faster
			} else {
				if (qcc->cnt > max_cnt) qcc->cnt = max_cnt;
			}

		}
	}

	/* The maximum rate of cwnd increase CUBIC allows is 1 packet per
	 * 2 packets ACKed, meaning cwnd grows at 1.5x per RTT.
	 */
	qcc->cnt = max(qcc->cnt, 2U);
}


/* In theory this is tp->snd_cwnd += 1 / tp->snd_cwnd (or alternative w),
 * for every packet that was ACKed.
 */
//void tcp_cong_avoid_ai(struct tcp_sock *tp, u32 w, u32 acked)				// come from tcp_cong.c
//static inline void mptcp_qcc_avoid_ai(struct tcp_sock *tp, u32 w, u32 acked)		// come from tcp_cong.c
static inline void mptcp_qcc_avoid_ai(struct sock *sk, struct tcp_sock *tp, u32 w, u32 acked, const struct rate_sample *rs)		// come from tcp_cong.c
{
	//ztg add
	u32 bbr_cwnd;

	// QCC ADD
	u32 rtt;

	// BBR ADD
	struct mptcp_qcc *bbr = inet_csk_ca(sk);
	u32 bw;

	/* If credits accumulated at a higher w, apply them gently now. */
	if (tp->snd_cwnd_cnt >= w) {
		tp->snd_cwnd_cnt = 0;
		tp->snd_cwnd++;
	}

	tp->snd_cwnd_cnt += acked;
	if (tp->snd_cwnd_cnt >= w) {
		u32 delta = tp->snd_cwnd_cnt / w;

		tp->snd_cwnd_cnt -= delta * w;
		tp->snd_cwnd += delta;
	}
	tp->snd_cwnd = min(tp->snd_cwnd, tp->snd_cwnd_clamp);


	//--------------------------------------------------------------------------
	// BBR ADD	static void bbr_main(struct sock *sk, const struct rate_sample *rs)
	//--------------------------------------------------------------------------
//	struct bbr *bbr = inet_csk_ca(sk);
//	struct mptcp_qcc *bbr = qcc;
//	struct mptcp_qcc *bbr = inet_csk_ca(sk);

//	u32 bw;

	bbr_update_model(sk, rs);	

	bw = bbr_bw(sk);
	bbr_set_pacing_rate(sk, bw, bbr->pacing_gain);
	//bbr_set_cwnd(sk, rs, rs->acked_sacked, bw, bbr->cwnd_gain);
	bbr_cwnd = bbr_set_cwnd(sk, rs, rs->acked_sacked, bw, bbr->cwnd_gain);
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	// QCC & BBR ADD
	//--------------------------------------------------------------------------
	tp->snd_cwnd = min(tp->snd_cwnd, bbr_cwnd);
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	// QCC ADD
	//--------------------------------------------------------------------------
//	u32 rtt;

	if (tp->qccqms.trigger == 1 && tp->qccqms.cntRTT) {
		rtt = tp->qccqms.cumRTT / tp->qccqms.cntRTT;		// average RTT measured within last RTT (in usec) on a subflow
		tp->qccqms.aver_rtt = rtt;					// used by QMS	// QCC ADD
	}
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	// QCC ADD
	//--------------------------------------------------------------------------
//*
	if (tp->qccqms.trigger == 1) { 		// after three rounds of congestion control, sort aver_rtt & snd_cwnd & bdp, which used by QMS

		// get the subflow that has min rrt, get the subflow that has max cwnd
		u32 min_rrt = 0xffffffff;
		u8  min_rrt_subfid = 0xff;
		u32 max_cwnd = 0;
		u8  max_cwnd_subfid = 0xff;
		u32 max_bdp = 0;
		u8  max_bdp_subfid = 0xff;
		struct mptcp_tcp_sock *mptcp;

//		struct sock *sub_sk;
		mptcp_for_each_sub(tp->mpcb, mptcp) {
			struct sock *sub_sk = mptcp_to_sock(mptcp);
//		mptcp_for_each_sk(tp->mpcb, sub_sk) {
			struct tcp_sock *sub_tp = tcp_sk(sub_sk);
			if(min_rrt > sub_tp->qccqms.aver_rtt) {
				min_rrt = sub_tp->qccqms.aver_rtt;
				min_rrt_subfid = sub_tp->mptcp->path_index;
			}
			if(max_cwnd < sub_tp->snd_cwnd) {
				max_cwnd = sub_tp->snd_cwnd;
				max_cwnd_subfid = sub_tp->mptcp->path_index;
			}
			if(max_bdp < sub_tp->qccqms.bdp) {
				max_bdp = sub_tp->qccqms.bdp;
				max_bdp_subfid = sub_tp->mptcp->path_index;
			}
		}

		// Sort the RTT & CWND & BDP of multiple subflows in order to influence the sender’s QMS
		mptcp_for_each_sub(tp->mpcb, mptcp) {
			struct sock *sub_sk = mptcp_to_sock(mptcp);
			struct tcp_sock *sub_tp = tcp_sk(sub_sk);
			if (sub_tp->mptcp->path_index == min_rrt_subfid) sub_tp->qccqms.sort_rtt = 1;		// get the subflow that has min rrt
			else sub_tp->qccqms.sort_rtt = 2;
			if (sub_tp->mptcp->path_index == max_cwnd_subfid) sub_tp->qccqms.sort_cwnd = 1;	// get the subflow that has max cwnd
			else sub_tp->qccqms.sort_cwnd = 2;
			if (sub_tp->mptcp->path_index == max_bdp_subfid) sub_tp->qccqms.sort_bdp = 1;		// get the subflow that has max bdp
			else sub_tp->qccqms.sort_bdp = 2;
		}

		if (tp->qccqms.qoe==3 || tp->qccqms.qoe==7) tp->qccqms.slowone = 1;
	}

	// Wipe the slate clean for the next cong_avoid.
	tp->qccqms.cntRTT = 0;
	tp->qccqms.cumRTT = 0;
	tp->qccqms.minRTT = 0x7fffffff;
	//--------------------------------------------------------------------------
}

static void mptcp_qcc_cong_avoid(struct sock *sk, u32 ack, u32 acked, const struct rate_sample *rs)
{
	struct tcp_sock *tp = tcp_sk(sk);
	struct mptcp_qcc *qcc = inet_csk_ca(sk);

	if (!tcp_is_cwnd_limited(sk))
		return;

	if (tcp_in_slow_start(tp)) {
		if (hystart && after(ack, qcc->end_seq))
			mptcp_qcc_hystart_reset(sk);
		acked = tcp_slow_start(tp, acked);

		if (!acked)
			return;
	}
	mptcp_qcc_update(sk, qcc, tp->snd_cwnd, acked);
	mptcp_qcc_avoid_ai(sk, tp, qcc->cnt, acked, rs);

	// QCC ADD
	tp->qccqms.cnt = qcc->cnt;
}

static u32 mptcp_qcc_ssthresh(struct sock *sk)
{
//	const struct tcp_sock *tp = tcp_sk(sk);
	struct tcp_sock *tp = tcp_sk(sk);
	struct mptcp_qcc *qcc = inet_csk_ca(sk);

	qcc->epoch_start = 0;	/* end of epoch */


	/* Wmax and fast convergence */
	if (tp->snd_cwnd < qcc->last_max_cwnd && fast_convergence)
		qcc->last_max_cwnd = (tp->snd_cwnd * (MPTCP_QCC_BETA_SCALE + beta))
			/ (2 * MPTCP_QCC_BETA_SCALE);
	else
		qcc->last_max_cwnd = tp->snd_cwnd;

//	qcc->loss_cwnd = tp->snd_cwnd;

	//--------------------------------------------------------------------------
	// BBR ADD	static u32 bbr_ssthresh(struct sock *sk)	/* Entering loss recovery, so save cwnd for when we exit or undo recovery. */
	//--------------------------------------------------------------------------
	bbr_save_cwnd(sk);
	//return tcp_sk(sk)->snd_ssthresh;
	//--------------------------------------------------------------------------


//	return max((tp->snd_cwnd * beta) / MPTCP_QCC_BETA_SCALE, 2U);
	//--------------------------------------------------------------------------
	// QCC ADD
	//--------------------------------------------------------------------------
//	if (tp->qccqms.trigger && ( (!!(tp->qccqms.qoe & QCC_WIFI) && !!(tp->qccqms.qoe & QCC_CELLULAR) && !(tp->qccqms.qoe & ~3U)) || (!!(tp->qccqms.qoe & QCC_BIGFILE) && !(tp->qccqms.qoe & QCC_REALTIME)) ) )
	if (tp->qccqms.trigger && (tp->qccqms.qoe==3 || tp->qccqms.qoe==7) )
		return max((tp->snd_cwnd * 922) / 1024, 2U);					//Modify snd_ssthresh, that is, max(0.9*snd_cwnd, 2)
	else
		return max((tp->snd_cwnd * beta) / MPTCP_QCC_BETA_SCALE, 2U);		//Modify snd_ssthresh, that is, max(0.7*snd_cwnd, 2)
}

static u32 mptcp_qcc_undo_cwnd(struct sock *sk)
{
	struct mptcp_qcc *qcc = inet_csk_ca(sk);

	//--------------------------------------------------------------------------
	// BBR ADD	static u32 bbr_undo_cwnd(struct sock *sk)	/* In theory BBR does not need to undo the cwnd since it does not always reduce cwnd on losses (see bbr_main()). Keep it for now. */
	//--------------------------------------------------------------------------
//	struct bbr *bbr = inet_csk_ca(sk);
	struct mptcp_qcc *bbr = qcc;

	bbr->full_bw = 0;   /* spurious slow-down; reset full pipe detection */
	bbr->full_bw_cnt = 0;
	bbr_reset_lt_bw_sampling(sk);
	//return tcp_sk(sk)->snd_cwnd;
	//--------------------------------------------------------------------------

//	return max(tcp_sk(sk)->snd_cwnd, qcc->loss_cwnd);
	return max(tcp_sk(sk)->snd_cwnd, qcc->last_max_cwnd);
}

static void mptcp_qcc_state(struct sock *sk, u8 new_state)
{
	struct mptcp_qcc *qcc = inet_csk_ca(sk);

	// BBR ADD
	struct mptcp_qcc *bbr = qcc;
	struct rate_sample rs;


	if (new_state == TCP_CA_Loss) {
		mptcp_qcc_reset(inet_csk_ca(sk), sk);
		mptcp_qcc_hystart_reset(sk);

	//--------------------------------------------------------------------------
	// BBR ADD	static void bbr_set_state(struct sock *sk, u8 new_state)
	//--------------------------------------------------------------------------
//	struct bbr *bbr = inet_csk_ca(sk);
//	struct mptcp_qcc *bbr = qcc;

	//if (new_state == TCP_CA_Loss) {
//		struct rate_sample rs = { .losses = 1 };
		rs.losses = 1;

		bbr->prev_ca_state = TCP_CA_Loss;
		bbr->full_bw = 0;
		bbr->round_start = 1;	/* treat RTO like end of a round */
		bbr_lt_bw_sampling(sk, &rs);
	//}
	//--------------------------------------------------------------------------
	}
}


static void hystart_update(struct sock *sk, u32 delay)
{
	struct tcp_sock *tp = tcp_sk(sk);
	struct mptcp_qcc *qcc = inet_csk_ca(sk);

	if (qcc->found & hystart_detect)
		return;

	if (hystart_detect & HYSTART_ACK_TRAIN) {
		u32 now = mptcp_qcc_clock();

		/* first detection parameter - ack-train detection */
		if ((s32)(now - qcc->last_ack) <= hystart_ack_delta) {
			qcc->last_ack = now;
			if ((s32)(now - qcc->qcc_round_start) > qcc->delay_min >> 4) {
				qcc->found |= HYSTART_ACK_TRAIN;
				NET_INC_STATS(sock_net(sk),
					      LINUX_MIB_TCPHYSTARTTRAINDETECT);
				NET_ADD_STATS(sock_net(sk),
					      LINUX_MIB_TCPHYSTARTTRAINCWND,
					      tp->snd_cwnd);

				//tp->snd_ssthresh = tp->snd_cwnd;
				//--------------------------------------------------------------------------
				// QCC ADD, for Mi-Android-arm
				//--------------------------------------------------------------------------
//				if (tp->qccqms.trigger && ( (!!(tp->qccqms.qoe & QCC_WIFI) && !!(tp->qccqms.qoe & QCC_CELLULAR) && !(tp->qccqms.qoe & ~3U)) || (!!(tp->qccqms.qoe & QCC_BIGFILE) && !(tp->qccqms.qoe & QCC_REALTIME)) ) )
				if (tp->qccqms.trigger && tp->qccqms.slowone && (tp->qccqms.qoe==3 || tp->qccqms.qoe==7) ) {
//					tp->snd_ssthresh =  max(tp->snd_ssthresh, tp->snd_cwnd);				// forever: ssthresh:2147483647
					tp->snd_ssthresh =  tp->snd_cwnd + (tp->snd_cwnd >> 3);
					tp->qccqms.slowone = 0;
				} else
					tp->snd_ssthresh =  tp->snd_cwnd;
			}
		}
	}

	if (hystart_detect & HYSTART_DELAY) {
		/* obtain the minimum delay of more than sampling packets */
		if (qcc->curr_rtt > delay)
			qcc->curr_rtt = delay;

		// HYSTART delay obtain the minimum delay of more than sampling packets
		if (qcc->sample_cnt < HYSTART_MIN_SAMPLES) {
			if (qcc->curr_rtt == 0 || qcc->curr_rtt > delay)
				qcc->curr_rtt = delay;

			qcc->sample_cnt++;
		} else {
			if (qcc->curr_rtt > qcc->delay_min +
			    HYSTART_DELAY_THRESH(qcc->delay_min >> 3)) {
				qcc->found |= HYSTART_DELAY;
				NET_INC_STATS(sock_net(sk),
					      LINUX_MIB_TCPHYSTARTDELAYDETECT);
				NET_ADD_STATS(sock_net(sk),
					      LINUX_MIB_TCPHYSTARTDELAYCWND,
					      tp->snd_cwnd);

				//tp->snd_ssthresh = tp->snd_cwnd;
				//--------------------------------------------------------------------------
				// QCC ADD, for Mi-Android-arm
				//--------------------------------------------------------------------------
//				if (tp->qccqms.trigger && ( (!!(tp->qccqms.qoe & QCC_WIFI) && !!(tp->qccqms.qoe & QCC_CELLULAR) && !(qoe & ~3U)) || (!!(tp->qccqms.qoe & QCC_BIGFILE) && !(tp->qccqms.qoe & QCC_REALTIME)) ) )
				if (tp->qccqms.trigger && tp->qccqms.slowone && (tp->qccqms.qoe==3 || tp->qccqms.qoe==7) ) {
//					tp->snd_ssthresh =  max(tp->snd_ssthresh, tp->snd_cwnd);				// forever: ssthresh:2147483647
					tp->snd_ssthresh =  tp->snd_cwnd + (tp->snd_cwnd >> 3);
					tp->qccqms.slowone = 0;
				} else
					tp->snd_ssthresh =  tp->snd_cwnd;
			}
		}
	}
}



/* Track delayed acknowledgment ratio using sliding window
 * ratio = (15*ratio + sample) / 16
 */
static void mptcp_qcc_acked(struct sock *sk, const struct ack_sample *sample)
{
	// QCC ADD
	//const struct tcp_sock *tp = tcp_sk(sk);
	struct tcp_sock *tp = tcp_sk(sk);

	struct mptcp_qcc *qcc = inet_csk_ca(sk);
	u32 delay;

	// QCC ADD
	u32 vrtt;

	/* Some calls are for duplicates without timetamps */
	if (sample->rtt_us < 0)
		return;

	/* Discard delay samples right after fast recovery */
	if (qcc->epoch_start && (s32)(tcp_time_stamp(tp) - qcc->epoch_start) < HZ)	// No sampling within 1s after fast recovery
		return;

	delay = (sample->rtt_us << 3) / USEC_PER_MSEC;	// rtt_us here is expanded by 8 times, and it will be reduced by 8 when calculating
	if (delay == 0)
		delay = 1;

	/* first time call or link delay decreases */
	if (qcc->delay_min == 0 || qcc->delay_min > delay)
		qcc->delay_min = delay;		// note: delay_min == baseRTT

	//--------------------------------------------------------------------------
	// QCC ADD
	//--------------------------------------------------------------------------
	/* Never allow zero rtt or baseRTT */
	vrtt = sample->rtt_us?sample->rtt_us:1;

	/* Filter to find propagation delay: */
	if (vrtt < tp->qccqms.baseRTT)
		tp->qccqms.baseRTT = vrtt;

	/* Find the min RTT during the last RTT to find
	 * the current prop. delay + queuing delay:
	 */
	tp->qccqms.minRTT = min(tp->qccqms.minRTT, vrtt);
	tp->qccqms.cumRTT += vrtt;
	tp->qccqms.cntRTT++;

	delay = (tp->qccqms.minRTT << 3) / USEC_PER_MSEC;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	// QCC ADD
	//--------------------------------------------------------------------------
	if (!tp->qccqms.trigger && !tp->qccqms.triRound) tp->qccqms.trigger = 1; 	// Triggered after 30 ack
	if (!tp->qccqms.trigger) tp->qccqms.triRound--;
	//--------------------------------------------------------------------------

	/* hystart triggers when cwnd is larger than some threshold */
	if (hystart && tcp_in_slow_start(tp) &&
	    tp->snd_cwnd >= hystart_low_window)
		hystart_update(sk, delay);
}


	//--------------------------------------------------------------------------
	// BBR ADD many functions
	//--------------------------------------------------------------------------

static size_t bbr_get_info(struct sock *sk, u32 ext, int *attr,
			   union tcp_cc_info *info)
{
	if (ext & (1 << (INET_DIAG_BBRINFO - 1)) ||
	    ext & (1 << (INET_DIAG_VEGASINFO - 1))) {
		struct tcp_sock *tp = tcp_sk(sk);
//		struct bbr *bbr = inet_csk_ca(sk);
		struct mptcp_qcc *bbr = inet_csk_ca(sk);

		u64 bw = bbr_bw(sk);

		bw = bw * tp->mss_cache * USEC_PER_SEC >> BW_SCALE;
		memset(&info->bbr, 0, sizeof(info->bbr));
		info->bbr.bbr_bw_lo		= (u32)bw;
		info->bbr.bbr_bw_hi		= (u32)(bw >> 32);
		info->bbr.bbr_min_rtt	= bbr->min_rtt_us;
		info->bbr.bbr_pacing_gain	= bbr->pacing_gain;
		info->bbr.bbr_cwnd_gain	= bbr->cwnd_gain;
		*attr = INET_DIAG_BBRINFO;
		return sizeof(info->bbr);
	}
	return 0;
}

static u32 bbr_sndbuf_expand(struct sock *sk)
{
	/* Provision 3 * cwnd since BBR may slow-start even during recovery. */
	return 3;
}
	//--------------------------------------------------------------------------


static struct tcp_congestion_ops mptcpqcc __read_mostly = {
	.owner		= THIS_MODULE,
	.name		= "qcc",

	.init		= mptcp_qcc_init,
	.ssthresh	= mptcp_qcc_ssthresh,
//	.cong_avoid	= mptcp_qcc_cong_avoid,
	.qcc_cong_avoid = mptcp_qcc_cong_avoid,
	.set_state	= mptcp_qcc_state,
	.undo_cwnd	= mptcp_qcc_undo_cwnd,
	.cwnd_event	= mptcp_qcc_cwnd_event,
	.pkts_acked	= mptcp_qcc_acked,

	//--------------------------------------------------------------------------
	// BBR ADD
	//--------------------------------------------------------------------------
	//.cong_control	= bbr_main,
	.min_tso_segs	= bbr_min_tso_segs,
	.get_info	= bbr_get_info,
	.sndbuf_expand	= bbr_sndbuf_expand,
	//--------------------------------------------------------------------------
};


static int __init mptcp_qcc_register(void)
{
	BUILD_BUG_ON(sizeof(struct mptcp_qcc) > ICSK_CA_PRIV_SIZE);			// #define ICSK_CA_PRIV_SIZE      (11 * sizeof(u64))

	/* Precompute a bunch of the scaling factors that are used per-packet
	 * based on SRTT of 100ms
	 */
	beta_scale = 8*(MPTCP_QCC_BETA_SCALE+beta) / 3
		/ (MPTCP_QCC_BETA_SCALE - beta);

	cube_rtt_scale = (bic_scale * 10);	/* 1024*c/rtt */

	/* calculate the "K" for (wmax-cwnd) = c/rtt * K^3
	 *  so K = cubic_root( (wmax-cwnd)*rtt/c )
	 * the unit of K is mptcp_qcc_HZ=2^10, not HZ
	 *
	 *  c = bic_scale >> 10
	 *  rtt = 100ms
	 *
	 * the following code has been designed and tested for
	 * cwnd < 1 million packets
	 * RTT < 100 seconds
	 * HZ < 1,000,00  (corresponding to 10 nano-second)
	 */

	/* 1/c * 2^2*mptcp_qcc_HZ * srtt */
	cube_factor = 1ull << (10+3*MPTCP_QCC_HZ); /* 2^40 */

	/* divide by bic_scale and by constant Srtt (100ms) */
	do_div(cube_factor, bic_scale * 10);

	return tcp_register_congestion_control(&mptcpqcc);
}

static void __exit mptcp_qcc_unregister(void)
{
	tcp_unregister_congestion_control(&mptcpqcc);
}

module_init(mptcp_qcc_register);
module_exit(mptcp_qcc_unregister);

MODULE_AUTHOR("Tongguang Zhang");
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("MPTCP QoE-Driven Congestion Controller (QCC)");		// MODULE_DESCRIPTION("MPTCP QCC");
MODULE_VERSION("0.1");
