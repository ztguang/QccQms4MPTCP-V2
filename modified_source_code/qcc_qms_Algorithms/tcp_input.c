
//ztg
//static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb, int hdrlen, bool *fragstolen)
int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb, int hdrlen, bool *fragstolen)
{
//ztg paper-2
//---------------------------------
//	struct tcp_sock *tp = tcp_sk(skb->sk);
	struct tcp_sock *tp = tcp_sk(sk);

//	struct tcphdr *th = (struct tcphdr *)skb->data;
	struct tcphdr *th = tcp_hdr(skb);
//---------------------------------

	int eaten;
	struct sk_buff *tail = skb_peek_tail(&sk->sk_receive_queue);

	__skb_pull(skb, hdrlen);
	eaten = (tail &&
		 tcp_try_coalesce(sk, tail, skb, fragstolen)) ? 1 : 0;
	tcp_rcv_nxt_update(tcp_sk(sk), TCP_SKB_CB(skb)->end_seq);
	if (!eaten) {
		__skb_queue_tail(&sk->sk_receive_queue, skb);
		skb_set_owner_r(skb, sk);
	}
//ztg paper-2
//---------------------------------
		if (tp->qccqms.cap_inter_i-- == 6 && (tp->qccqms.qoe==0 || tp->qccqms.qoe==1 || tp->qccqms.qoe==2 || tp->qccqms.qoe==3 || tp->qccqms.qoe==7 || tp->qccqms.qoe==11))
			printk(KERN_INFO "QOE_receive: name:%s: nif:%d: nif:%d: trigger:%d: qoe:%d: window:%d: wscale:%d: sort_bdp:%d: sort_rtt:%d: sort_cwnd:%d: rtt:%d: ssthresh:%d: cwnd:%d: delivered:%d: lost:%d: retrans:%d\n", skb->dev->name, tp->qccqms.nif, tp->qccqms.nif, tp->qccqms.trigger, tp->qccqms.qoe, th->window, tp->rx_opt.rcv_wscale, tp->qccqms.sort_bdp, tp->qccqms.sort_rtt, tp->qccqms.sort_cwnd, tp->srtt_us >> 3, tp->snd_ssthresh, tp->snd_cwnd, tp->delivered, tp->lost, tp->total_retrans);
		if (tp->qccqms.cap_inter_i == 0)
			tp->qccqms.cap_inter_i = 6;
//---------------------------------

	return eaten;
}

