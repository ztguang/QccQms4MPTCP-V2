
static int __dev_queue_xmit(struct sk_buff *skb, void *accel_priv,
			    bool skb_list)
{
	struct net_device *dev = skb->dev;
	struct netdev_queue *txq;
	struct Qdisc *q;
	int rc = -ENOMEM;

	//----------------------------------------	QCC & QMS
	struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
	struct tcp_sock *tp = tcp_sk(skb->sk);
	struct tcphdr *th = (struct tcphdr *)skb->data;

	struct mptcp_tcp_sock *mpsock;
	struct sock *sub_sk;
	struct tcp_sock *sub_tp;

	if (skb->sk && tcb && tp && th && likely(!(tcb->tcp_flags & TCPHDR_SYN))) {
//		if (!strcmp(skb->dev->name, "eth1")) {tp->qccqms.nif = 1;}		// in VB-Android-x86, eth1 in VB is actually wired
//		else if (!strcmp(skb->dev->name, "eth2")) {tp->qccqms.nif = 2;}		// in VB-Android-x86, eth2 in VB is actually wireless WIFI
		if (!strncmp(skb->dev->name, "rmnet_data", 10)) {tp->qccqms.nif = 1;}	// in oneplus8t-Android-arm, 4G
		else if (!strcmp(skb->dev->name, "wlan0")) {tp->qccqms.nif = 2;}	// in oneplus8t-Android-arm, WIFI

		tp->qccqms.nif_sends++;					// 20210719

		// Due to the two-way transmission of data, the client does not want to send data through this link, 
		// so it also wants to restrict the server side of the same link to send data, so through rwnd = 0 to control the server side to send data
		if(tp->qccqms.qoe==1 && tp->qccqms.nif == 1 && mptcp(tp)) {		// only use WIFI
			mptcp_for_each_sub(tp->mpcb, mpsock) {
				sub_sk = mptcp_to_sock(mpsock);
				sub_tp = tcp_sk(sub_sk);
				if(sub_tp != tp && sub_tp->qccqms.nif_sends > 10)
					th->window = 0;	// Turn off 4G or eth. If 4G or eth (tp) is the main substream, you need to determine the number 
								// of WIFI (sub_tp) sent packets. nif_sends> 4 is optimistic, nif_sends> 10 is more secure
			}
		}
		else if(tp->qccqms.qoe==2 && tp->qccqms.nif == 2 && mptcp(tp)) {	// only use 4G or eth
			mptcp_for_each_sub(tp->mpcb, mpsock) {
				sub_sk = mptcp_to_sock(mpsock);
				sub_tp = tcp_sk(sub_sk);
				if(sub_tp != tp && sub_tp->qccqms.nif_sends > 10)
					th->window = 0;	// Turn off WIFI. If WIFI (tp) is the main sub-stream, you need to determine the number of 4G 
								// or eth (sub_tp) sent packets. nif_sends> 4 is optimistic, nif_sends> 10 is more secure
			}
		}

//		if (tp->qccqms.cap_inter_o-- == 6 && tp->qccqms.qoe!=0 && tp->qccqms.qoe!=255)
		if (tp->qccqms.cap_inter_o-- == 6 && (tp->qccqms.qoe==0 || tp->qccqms.qoe==1 || tp->qccqms.qoe==2 || tp->qccqms.qoe==3 || tp->qccqms.qoe==7 || tp->qccqms.qoe==11))
			printk(KERN_INFO "QOE_send: name:%s: nif:%d: nif:%d: trigger:%d: qoe:%d: window:%d: wscale:%d: sort_bdp:%d: sort_rtt:%d: sort_cwnd:%d: rtt:%d: ssthresh:%d: cwnd:%d: delivered:%d: lost:%d: retrans:%d\n", skb->dev->name, tp->qccqms.nif, tp->qccqms.nif, tp->qccqms.trigger, tp->qccqms.qoe, th->window, tp->rx_opt.rcv_wscale, tp->qccqms.sort_bdp, tp->qccqms.sort_rtt, tp->qccqms.sort_cwnd, tp->srtt_us >> 3, tp->snd_ssthresh, tp->snd_cwnd, tp->delivered, tp->lost, tp->total_retrans);
		else if (tp->qccqms.cap_inter_o == 0)	// In order to get the data required for the analysis of the paper results, output every 6 packets sent
			tp->qccqms.cap_inter_o = 6;
	}
	//----------------------------------------	QCC & QMS

	skb_reset_mac_header(skb);

	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
		__skb_tstamp_tx(skb, NULL, skb->sk, SCM_TSTAMP_SCHED);

	/* Disable soft irqs for various locks below. Also
	 * stops preemption for RCU.
	 */
	rcu_read_lock_bh();

	skb_update_prio(skb);

	qdisc_pkt_len_init(skb);
#ifdef CONFIG_NET_CLS_ACT
	skb->tc_verd = SET_TC_AT(skb->tc_verd, AT_EGRESS);
# ifdef CONFIG_NET_EGRESS
	if (static_key_false(&egress_needed)) {
		skb = sch_handle_egress(skb, &rc, dev);
		if (!skb)
			goto out;
	}
# endif
#endif
	/* If device/qdisc don't need skb->dst, release it right now while
	 * its hot in this cpu cache.
	 */
	if (dev->priv_flags & IFF_XMIT_DST_RELEASE)
		skb_dst_drop(skb);
	else
		skb_dst_force(skb);

	txq = netdev_pick_tx(dev, skb, accel_priv);
	q = rcu_dereference_bh(txq->qdisc);

	trace_net_dev_queue(skb);
	if (q->enqueue) {
		rc = __dev_xmit_skb(skb, q, dev, txq);
		goto out;
	}

	/* The device has no queue. Common case for software devices:
	   loopback, all the sorts of tunnels...

	   Really, it is unlikely that netif_tx_lock protection is necessary
	   here.  (f.e. loopback and IP tunnels are clean ignoring statistics
	   counters.)
	   However, it is possible, that they rely on protection
	   made by us here.

	   Check this and shot the lock. It is not prone from deadlocks.
	   Either shot noqueue qdisc, it is even simpler 8)
	 */
	if (dev->flags & IFF_UP) {
		int cpu = smp_processor_id(); /* ok because BHs are off */

		if (txq->xmit_lock_owner != cpu) {
			if (unlikely(__this_cpu_read(xmit_recursion) >
				     XMIT_RECURSION_LIMIT))
				goto recursion_alert;

			skb = validate_xmit_skb(skb, dev);
			if (!skb)
				goto out;

			HARD_TX_LOCK(dev, txq, cpu);

			if (!netif_xmit_stopped(txq)) {
				__this_cpu_inc(xmit_recursion);
				if (likely(!skb_list))
					skb = dev_hard_start_xmit(skb, dev,
								  txq, &rc);
				else
					skb = dev_hard_start_xmit_list(skb,
								       dev,
								       txq,
								       &rc);
				__this_cpu_dec(xmit_recursion);
				if (dev_xmit_complete(rc)) {
					HARD_TX_UNLOCK(dev, txq);
					goto out;
				}
			}
			HARD_TX_UNLOCK(dev, txq);
			net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
					     dev->name);
		} else {
			/* Recursion is detected! It is possible,
			 * unfortunately
			 */
recursion_alert:
			net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
					     dev->name);
		}
	}

	rc = -ENETDOWN;
	rcu_read_unlock_bh();

	atomic_long_inc(&dev->tx_dropped);
	kfree_skb_list(skb);
	return rc;
out:
	rcu_read_unlock_bh();
	return rc;
}

