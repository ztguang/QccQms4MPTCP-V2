
##################################################
#
# Complete test between oneplus-8t-arm <---> 5.4.0-2.MPTCP.fc32.x86_64 in Internet (Alibaba Cloud Server)		20210722
#
##################################################


#----------------------------------------------------------------------------------------------------------------------------------------------------
	# experiment---01---compare def-cubic, def-olia and qms-qcc	runs scp in oneplus-8t-arm to send drivers (160 MB, 4749 files) using all QoE
#----------------------------------------------------------------------------------------------------------------------------------------------------

# Enable def-cubic

	# Server side, packet capture
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-01-def-cubic-qoe01.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 1 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    5m37.73s real     0m06.70s user     0m19.80s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-01-def-cubic-qoe01.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-01-def-cubic-qoe01.txt


	# Server side, packet capture
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-01-def-cubic-qoe02.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 2 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    7m55.03s real     0m06.72s user     0m23.74s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-01-def-cubic-qoe02.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-01-def-cubic-qoe02.txt


	# Server side, packet capture
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-01-def-cubic-qoe03.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    5m54.85s real     0m06.76s user     0m15.86s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-01-def-cubic-qoe03.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-01-def-cubic-qoe03.txt


	# Server side, packet capture
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-01-def-cubic-qoe07.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 7 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    5m18.04s real     0m06.07s user     0m13.01s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-01-def-cubic-qoe07.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-01-def-cubic-qoe07.txt


	# Server side, packet capture
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-01-def-cubic-qoe11.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 11 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    5m32.62s real     0m06.77s user     0m22.02s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-01-def-cubic-qoe11.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-01-def-cubic-qoe11.txt





# Enable def-olia

	# Server side, packet capture
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-01-def-olia-qoe01.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 1 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    5m54.16s real     0m07.01s user     0m14.07s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-01-def-olia-qoe01.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-01-def-olia-qoe01.txt


	# Server side, packet capture
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-01-def-olia-qoe02.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 2 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    8m11.94s real     0m06.06s user     0m12.67s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-01-def-olia-qoe02.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-01-def-olia-qoe02.txt


	# Server side, packet capture
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-01-def-olia-qoe03.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    6m16.66s real     0m05.32s user     0m16.84s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-01-def-olia-qoe03.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-01-def-olia-qoe03.txt


	# Server side, packet capture
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-01-def-olia-qoe07.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 7 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    6m19.96s real     0m06.50s user     0m19.99s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-01-def-olia-qoe07.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-01-def-olia-qoe07.txt


	# Server side, packet capture
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-01-def-olia-qoe11.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 11 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    6m26.59s real     0m07.06s user     0m21.65s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-01-def-olia-qoe11.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-01-def-olia-qoe11.txt



# Enable qms-qcc

	# Server side, packet capture
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-01-qms-qcc-qoe01.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 1 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    4m42.55s real     0m06.13s user     0m20.71s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-01-qms-qcc-qoe01.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-01-qms-qcc-qoe01.txt


	# Server side, packet capture
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-01-qms-qcc-qoe02.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 2 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    7m07.86s real     0m03.84s user     0m08.64s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-01-qms-qcc-qoe02.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-01-qms-qcc-qoe02.txt


	# Server side, packet capture
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-01-qms-qcc-qoe03.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    4m22.61s real     0m05.71s user     0m19.02s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-01-qms-qcc-qoe03.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-01-qms-qcc-qoe03.txt


	# Server side, packet capture
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-01-qms-qcc-qoe07.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 7 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    4m36.72s real     0m05.72s user     0m18.66s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-01-qms-qcc-qoe07.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-01-qms-qcc-qoe07.txt


	# Server side, packet capture
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-01-qms-qcc-qoe11.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 11 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    4m27.06s real     0m05.97s user     0m20.42s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-01-qms-qcc-qoe11.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-01-qms-qcc-qoe11.txt
	#------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------------------------------------


#----------------------------------------------------------------------------------------------------------------------------------------------------
	# experiment---02---compare def-cubic, def-olia and qms-qcc	runs scp in oneplus-8t-arm to send drivers (160 MB, 4749 files), QoE = 3, packet loss rate = 0.10, 0.20, 0.30, 0.40, 0.50, 0.60
#----------------------------------------------------------------------------------------------------------------------------------------------------

	#------------------------------------------------------------------------------
	#------------------------------------------------------------------------------ Packet loss rate: 0.10%
	adb shell
	tc qdisc replace dev rmnet_data0 root netem loss 0.10%
	tc qdisc replace dev rmnet_data1 root netem loss 0.10%
	tc qdisc replace dev rmnet_data2 root netem loss 0.10%
	tc qdisc replace dev rmnet_data3 root netem loss 0.10%
	tc qdisc replace dev wlan0 root netem loss 0.10%
	tc qdisc
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-def-cubic-qoe03-0.10.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    6m48.71s real     0m06.80s user     0m15.79s system
	adb root
	adb pull /data/1.txt test-02-def-cubic-qoe03-0.10.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-def-cubic-qoe03-0.10.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-def-olia-qoe03-0.10.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    7m15.74s real     0m06.94s user     0m14.58s system
	adb root
	adb pull /data/1.txt test-02-def-olia-qoe03-0.10.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-def-olia-qoe03-0.10.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-qms-qcc-qoe03-0.10.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    5m34.18s real     0m05.79s user     0m20.77s system
	adb root
	adb pull /data/1.txt test-02-qms-qcc-qoe03-0.10.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-qms-qcc-qoe03-0.10.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-qms-qcc-qoe07-0.10.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 7 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    5m42.74s real     0m06.19s user     0m21.23s system
	adb root
	adb pull /data/1.txt test-02-qms-qcc-qoe07-0.10.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-qms-qcc-qoe07-0.10.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-qms-qcc-qoe11-0.10.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 11 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    5m25.00s real     0m05.82s user     0m20.86s system
	adb root
	adb pull /data/1.txt test-02-qms-qcc-qoe11-0.10.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-qms-qcc-qoe11-0.10.txt
	#------------------------------------------------------------------------------
	#------------------------------------------------------------------------------ Packet loss rate: 0.20%
	adb shell
	tc qdisc replace dev rmnet_data0 root netem loss 0.20%
	tc qdisc replace dev rmnet_data1 root netem loss 0.20%
	tc qdisc replace dev rmnet_data2 root netem loss 0.20%
	tc qdisc replace dev rmnet_data3 root netem loss 0.20%
	tc qdisc replace dev wlan0 root netem loss 0.20%
	tc qdisc
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-def-cubic-qoe03-0.20.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    8m05.74s real     0m04.39s user     0m07.07s system
	adb root
	adb pull /data/1.txt test-02-def-cubic-qoe03-0.20.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-def-cubic-qoe03-0.20.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-def-olia-qoe03-0.20.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    9m31.86s real     0m06.96s user     0m13.66s system
	adb root
	adb pull /data/1.txt test-02-def-olia-qoe03-0.20.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-def-olia-qoe03-0.20.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-qms-qcc-qoe03-0.20.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    6m38.96s real     0m05.88s user     0m12.44s system
	adb root
	adb pull /data/1.txt test-02-qms-qcc-qoe03-0.20.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-qms-qcc-qoe03-0.20.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-qms-qcc-qoe07-0.20.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 7 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    6m31.81s real     0m06.37s user     0m11.76s system
	adb root
	adb pull /data/1.txt test-02-qms-qcc-qoe07-0.20.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-qms-qcc-qoe07-0.20.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-qms-qcc-qoe11-0.20.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 11 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    6m33.68s real     0m06.69s user     0m11.94s system
	adb root
	adb pull /data/1.txt test-02-qms-qcc-qoe11-0.20.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-qms-qcc-qoe11-0.20.txt
	#------------------------------------------------------------------------------
	#------------------------------------------------------------------------------ Packet loss rate: 0.30%
	adb shell
	tc qdisc replace dev rmnet_data0 root netem loss 0.30%
	tc qdisc replace dev rmnet_data1 root netem loss 0.30%
	tc qdisc replace dev rmnet_data2 root netem loss 0.30%
	tc qdisc replace dev rmnet_data3 root netem loss 0.30%
	tc qdisc replace dev wlan0 root netem loss 0.30%
	tc qdisc
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-def-cubic-qoe03-0.30.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    9m41.88s real     0m06.91s user     0m15.89s system
	adb root
	adb pull /data/1.txt test-02-def-cubic-qoe03-0.30.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-def-cubic-qoe03-0.30.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-def-olia-qoe03-0.30.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    11m27.71s real     0m06.53s user     0m13.19s system
	adb root
	adb pull /data/1.txt test-02-def-olia-qoe03-0.30.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-def-olia-qoe03-0.30.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-qms-qcc-qoe03-0.30.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    7m32.23s real     0m05.55s user     0m11.89s system
	adb root
	adb pull /data/1.txt test-02-qms-qcc-qoe03-0.30.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-qms-qcc-qoe03-0.30.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-qms-qcc-qoe07-0.30.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 7 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    7m34.19s real     0m06.79s user     0m13.84s system
	adb root
	adb pull /data/1.txt test-02-qms-qcc-qoe07-0.30.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-qms-qcc-qoe07-0.30.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-qms-qcc-qoe11-0.30.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 11 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    7m16.15s real     0m05.89s user     0m11.64s system
	adb root
	adb pull /data/1.txt test-02-qms-qcc-qoe11-0.30.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-qms-qcc-qoe11-0.30.txt
	#------------------------------------------------------------------------------
	#------------------------------------------------------------------------------ Packet loss rate: 0.40%
	adb shell
	tc qdisc replace dev rmnet_data0 root netem loss 0.40%
	tc qdisc replace dev rmnet_data1 root netem loss 0.40%
	tc qdisc replace dev rmnet_data2 root netem loss 0.40%
	tc qdisc replace dev rmnet_data3 root netem loss 0.40%
	tc qdisc replace dev wlan0 root netem loss 0.40%
	tc qdisc
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-def-cubic-qoe03-0.40.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    10m44.59s real     0m07.29s user     0m13.97s system
	adb root
	adb pull /data/1.txt test-02-def-cubic-qoe03-0.40.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-def-cubic-qoe03-0.40.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-def-olia-qoe03-0.40.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    13m25.04s real     0m07.04s user     0m13.18s system
	adb root
	adb pull /data/1.txt test-02-def-olia-qoe03-0.40.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-def-olia-qoe03-0.40.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-qms-qcc-qoe03-0.40.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    8m28.54s real     0m05.73s user     0m11.16s system
	adb root
	adb pull /data/1.txt test-02-qms-qcc-qoe03-0.40.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-qms-qcc-qoe03-0.40.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-qms-qcc-qoe07-0.40.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 7 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    8m17.62s real     0m05.19s user     0m08.11s system
	adb root
	adb pull /data/1.txt test-02-qms-qcc-qoe07-0.40.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-qms-qcc-qoe07-0.40.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-qms-qcc-qoe11-0.40.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 11 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    8m09.13s real     0m05.85s user     0m10.37s system
	adb root
	adb pull /data/1.txt test-02-qms-qcc-qoe11-0.40.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-qms-qcc-qoe11-0.40.txt
	#------------------------------------------------------------------------------
	#------------------------------------------------------------------------------ Packet loss rate: 0.50%
	adb shell
	tc qdisc replace dev rmnet_data0 root netem loss 0.50%
	tc qdisc replace dev rmnet_data1 root netem loss 0.50%
	tc qdisc replace dev rmnet_data2 root netem loss 0.50%
	tc qdisc replace dev rmnet_data3 root netem loss 0.50%
	tc qdisc replace dev wlan0 root netem loss 0.50%
	tc qdisc
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-def-cubic-qoe03-0.50.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    12m02.22s real     0m06.48s user     0m13.86s system
	adb root
	adb pull /data/1.txt test-02-def-cubic-qoe03-0.50.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-def-cubic-qoe03-0.50.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-def-olia-qoe03-0.50.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    16m49.05s real     0m06.26s user     0m12.55s system
	adb root
	adb pull /data/1.txt test-02-def-olia-qoe03-0.50.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-def-olia-qoe03-0.50.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-qms-qcc-qoe03-0.50.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    9m52.39s real     0m06.29s user     0m12.12s system
	adb root
	adb pull /data/1.txt test-02-qms-qcc-qoe03-0.50.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-qms-qcc-qoe03-0.50.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-qms-qcc-qoe07-0.50.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 7 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    9m42.27s real     0m07.13s user     0m13.34s system
	adb root
	adb pull /data/1.txt test-02-qms-qcc-qoe07-0.50.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-qms-qcc-qoe07-0.50.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-qms-qcc-qoe11-0.50.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 11 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    9m01.02s real     0m06.06s user     0m11.67s system
	adb root
	adb pull /data/1.txt test-02-qms-qcc-qoe11-0.50.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-qms-qcc-qoe11-0.50.txt
	#------------------------------------------------------------------------------
	#------------------------------------------------------------------------------ Packet loss rate: 0.60%
	adb shell
	tc qdisc replace dev rmnet_data0 root netem loss 0.60%
	tc qdisc replace dev rmnet_data1 root netem loss 0.60%
	tc qdisc replace dev rmnet_data2 root netem loss 0.60%
	tc qdisc replace dev rmnet_data3 root netem loss 0.60%
	tc qdisc replace dev wlan0 root netem loss 0.60%
	tc qdisc
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-def-cubic-qoe03-0.60.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    13m39.19s real     0m06.10s user     0m13.01s system
	adb root
	adb pull /data/1.txt test-02-def-cubic-qoe03-0.60.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-def-cubic-qoe03-0.60.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-def-olia-qoe03-0.60.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    21m32.21s real     0m06.48s user     0m12.69s system
	adb root
	adb pull /data/1.txt test-02-def-olia-qoe03-0.60.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-def-olia-qoe03-0.60.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-qms-qcc-qoe03-0.60.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 3 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    10m33.61s real     0m05.13s user     0m08.61s system
	adb root
	adb pull /data/1.txt test-02-qms-qcc-qoe03-0.60.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-qms-qcc-qoe03-0.60.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-qms-qcc-qoe07-0.60.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 7 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    10m14.11s real     0m06.53s user     0m11.66s system
	adb root
	adb pull /data/1.txt test-02-qms-qcc-qoe07-0.60.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-qms-qcc-qoe07-0.60.txt
	#…………………………………………
	# Server side, packet capture
	cd /root/tcpdump---paper2-test
	rm /root/drivers/ -rf && tcpdump -vv -n -i ens5 > tcpdump---test-02-qms-qcc-qoe11-0.60.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time sshpass -p 123456 scp -rQ 11 /data/drivers 8.140.122.222:/root/ > /data/scp.txt && dmesg > /data/1.txt'"
										#    
										#    9m56.42s real     0m06.72s user     0m11.33s system
	adb root
	adb pull /data/1.txt test-02-qms-qcc-qoe11-0.60.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill scp'"
										adb pull /data/scp.txt scp---test-02-qms-qcc-qoe11-0.60.txt
	#------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------------------------------------




#----------------------------------------------------------------------------------------------------------------------------------------------------
	# experiment---03---compare def-cubic, def-olia and qms-qcc	runs iperf3qoe in oneplus-8t-arm to send 160 MB of data using all QoE
#----------------------------------------------------------------------------------------------------------------------------------------------------

# Enable def-cubic

	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-03-def-cubic-qoe01.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 1 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    0m38.91s real     0m00.04s user     0m10.16s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-03-def-cubic-qoe01.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/scp.txt iperf3qoe---test-03-def-cubic-qoe01.txt


	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-03-def-cubic-qoe02.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 2 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    1m19.59s real     0m00.06s user     0m09.21s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-03-def-cubic-qoe02.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/scp.txt iperf3qoe---test-03-def-cubic-qoe02.txt


	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-03-def-cubic-qoe03.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    0m39.74s real     0m00.07s user     0m10.19s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-03-def-cubic-qoe03.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/scp.txt iperf3qoe---test-03-def-cubic-qoe03.txt

	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-03-def-cubic-qoe07.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 7 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    0m38.92s real     0m00.04s user     0m10.10s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-03-def-cubic-qoe07.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/scp.txt iperf3qoe---test-03-def-cubic-qoe07.txt


	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-03-def-cubic-qoe11.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 11 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    0m39.73s real     0m00.04s user     0m09.73s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-03-def-cubic-qoe11.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/scp.txt iperf3qoe---test-03-def-cubic-qoe11.txt





# Enable def-olia

	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-03-def-olia-qoe01.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 1 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    0m48.88s real     0m00.22s user     0m10.56s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-03-def-olia-qoe01.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/scp.txt iperf3qoe---test-03-def-olia-qoe01.txt


	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-03-def-olia-qoe02.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 2 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    1m18.15s real     0m00.13s user     0m09.30s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-03-def-olia-qoe02.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/scp.txt iperf3qoe---test-03-def-olia-qoe02.txt


	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-03-def-olia-qoe03.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    0m53.02s real     0m00.04s user     0m10.36s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-03-def-olia-qoe03.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/scp.txt iperf3qoe---test-03-def-olia-qoe03.txt


	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-03-def-olia-qoe07.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 7 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    0m47.39s real     0m00.03s user     0m09.63s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-03-def-olia-qoe07.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/scp.txt iperf3qoe---test-03-def-olia-qoe07.txt


	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-03-def-olia-qoe11.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 11 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    0m53.88s real     0m00.04s user     0m09.75s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-03-def-olia-qoe11.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/scp.txt iperf3qoe---test-03-def-olia-qoe11.txt





# Enable qms-qcc

	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-03-qms-qcc-qoe01.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 1 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    0m31.22s real     0m00.05s user     0m09.94s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-03-qms-qcc-qoe01.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/scp.txt iperf3qoe---test-03-qms-qcc-qoe01.txt


	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-03-qms-qcc-qoe02.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 2 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    0m58.83s real     0m00.04s user     0m07.92s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-03-qms-qcc-qoe02.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/scp.txt iperf3qoe---test-03-qms-qcc-qoe02.txt


	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-03-qms-qcc-qoe03.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#
										#    0m25.04s real     0m00.02s user     0m06.95s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-03-qms-qcc-qoe03.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/scp.txt iperf3qoe---test-03-qms-qcc-qoe03.txt


	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-03-qms-qcc-qoe07.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 7 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    0m28.20s real     0m00.04s user     0m05.88s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-03-qms-qcc-qoe07.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/scp.txt iperf3qoe---test-03-qms-qcc-qoe07.txt


	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-03-qms-qcc-qoe11.txt
	# OnePlus 8T
	adb kill-server
	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 11 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    0m28.15s real     0m00.05s user     0m06.44s system
	cd /root/paper-2---testing---results
	adb pull /data/1.txt test-03-qms-qcc-qoe11.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/scp.txt iperf3qoe---test-03-qms-qcc-qoe11.txt
	#------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------------------------------------




#----------------------------------------------------------------------------------------------------------------------------------------------------
	# experiment---04---compare def-cubic, def-olia and qms-qcc	runs iperf3qoe in oneplus-8t-arm to send 160 MB of data, QoE = 3, packet loss rate = 0.10, 0.20, 0.30, 0.40, 0.50, 0.60
#----------------------------------------------------------------------------------------------------------------------------------------------------

	#------------------------------------------------------------------------------
	#------------------------------------------------------------------------------ Packet loss rate: 0.10%
	adb shell
	tc qdisc replace dev rmnet_data0 root netem loss 0.10%
	tc qdisc replace dev rmnet_data1 root netem loss 0.10%
	tc qdisc replace dev rmnet_data2 root netem loss 0.10%
	tc qdisc replace dev rmnet_data3 root netem loss 0.10%
	tc qdisc replace dev wlan0 root netem loss 0.10%
	tc qdisc
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-def-cubic-qoe03-0.10.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    1m03.22s real     0m00.05s user     0m01.99s system
	adb root
	adb pull /data/1.txt test-04-def-cubic-qoe03-0.10.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe-def-cubic-qoe03-0.10.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-def-olia-qoe03-0.10.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    2m01.90s real     0m00.08s user     0m01.41s system
	adb root
	adb pull /data/1.txt test-04-def-olia-qoe03-0.10.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe-def-olia-qoe03-0.10.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-qms-qcc-qoe03-0.10.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    0m51.66s real     0m00.02s user     0m01.44s system
	adb root
	adb pull /data/1.txt test-04-qms-qcc-qoe03-0.10.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe03-0.10.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-qms-qcc-qoe07-0.10.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 7 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    0m52.78s real     0m00.03s user     0m01.48s system
	adb root
	adb pull /data/1.txt test-04-qms-qcc-qoe07-0.10.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe07-0.10.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-qms-qcc-qoe11-0.10.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 11 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    0m52.68s real     0m00.06s user     0m01.29s system
	adb root
	adb pull /data/1.txt test-04-qms-qcc-qoe11-0.10.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe11-0.10.txt
	#------------------------------------------------------------------------------
	#------------------------------------------------------------------------------ Packet loss rate: 0.20%
	adb shell
	tc qdisc replace dev rmnet_data0 root netem loss 0.20%
	tc qdisc replace dev rmnet_data1 root netem loss 0.20%
	tc qdisc replace dev rmnet_data2 root netem loss 0.20%
	tc qdisc replace dev rmnet_data3 root netem loss 0.20%
	tc qdisc replace dev wlan0 root netem loss 0.20%
	tc qdisc
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-def-cubic-qoe03-0.20.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    1m34.12s real     0m00.06s user     0m01.60s system
	adb root
	adb pull /data/1.txt test-04-def-cubic-qoe03-0.20.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe-def-cubic-qoe03-0.20.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-def-olia-qoe03-0.20.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    2m49.65s real     0m00.11s user     0m01.43s system
	adb root
	adb pull /data/1.txt test-04-def-olia-qoe03-0.20.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe-def-olia-qoe03-0.20.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-qms-qcc-qoe03-0.20.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    1m02.60s real     0m00.02s user     0m01.16s system
	adb root
	adb pull /data/1.txt test-04-qms-qcc-qoe03-0.20.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe03-0.20.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-qms-qcc-qoe07-0.20.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 7 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    1m12.83s real     0m00.05s user     0m01.11s system
	adb root
	adb pull /data/1.txt test-04-qms-qcc-qoe07-0.20.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe07-0.20.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-qms-qcc-qoe11-0.20.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 11 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    1m09.95s real     0m00.04s user     0m00.96s system
	adb root
	adb pull /data/1.txt test-04-qms-qcc-qoe11-0.20.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe11-0.20.txt
	#------------------------------------------------------------------------------
	#------------------------------------------------------------------------------ Packet loss rate: 0.30%
	adb shell
	tc qdisc replace dev rmnet_data0 root netem loss 0.30%
	tc qdisc replace dev rmnet_data1 root netem loss 0.30%
	tc qdisc replace dev rmnet_data2 root netem loss 0.30%
	tc qdisc replace dev rmnet_data3 root netem loss 0.30%
	tc qdisc replace dev wlan0 root netem loss 0.30%
	tc qdisc
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-def-cubic-qoe03-0.30.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    1m52.87s real     0m00.05s user     0m01.19s system
	adb root
	adb pull /data/1.txt test-04-def-cubic-qoe03-0.30.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe-def-cubic-qoe03-0.30.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-def-olia-qoe03-0.30.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    3m42.35s real     0m00.21s user     0m00.97s system
	adb root
	adb pull /data/1.txt test-04-def-olia-qoe03-0.30.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe-def-olia-qoe03-0.30.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-qms-qcc-qoe03-0.30.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    1m11.62s real     0m00.03s user     0m00.99s system
	adb root
	adb pull /data/1.txt test-04-qms-qcc-qoe03-0.30.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe03-0.30.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-qms-qcc-qoe07-0.30.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 7 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    1m11.78s real     0m00.02s user     0m01.11s system
	adb root
	adb pull /data/1.txt test-04-qms-qcc-qoe07-0.30.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe07-0.30.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-qms-qcc-qoe11-0.30.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 11 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    1m32.91s real     0m00.01s user     0m00.99s system
	adb root
	adb pull /data/1.txt test-04-qms-qcc-qoe11-0.30.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe11-0.30.txt
	#------------------------------------------------------------------------------
	#------------------------------------------------------------------------------ Packet loss rate: 0.40%
	adb shell
	tc qdisc replace dev rmnet_data0 root netem loss 0.40%
	tc qdisc replace dev rmnet_data1 root netem loss 0.40%
	tc qdisc replace dev rmnet_data2 root netem loss 0.40%
	tc qdisc replace dev rmnet_data3 root netem loss 0.40%
	tc qdisc replace dev wlan0 root netem loss 0.40%
	tc qdisc
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-def-cubic-qoe03-0.40.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    2m02.91s real     0m00.09s user     0m01.25s system
	adb root
	adb pull /data/1.txt test-04-def-cubic-qoe03-0.40.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe-def-cubic-qoe03-0.40.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-def-olia-qoe03-0.40.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    4m18.60s real     0m00.05s user     0m01.20s system
	adb root
	adb pull /data/1.txt test-04-def-olia-qoe03-0.40.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe-def-olia-qoe03-0.40.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-qms-qcc-qoe03-0.40.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    1m27.33s real     0m00.01s user     0m01.01s system
	adb root
	adb pull /data/1.txt test-04-qms-qcc-qoe03-0.40.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe03-0.40.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-qms-qcc-qoe07-0.40.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 7 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    1m37.45s real     0m00.01s user     0m00.94s system
	adb root
	adb pull /data/1.txt test-04-qms-qcc-qoe07-0.40.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe07-0.40.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-qms-qcc-qoe11-0.40.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 11 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    1m31.24s real     0m00.05s user     0m00.83s system
	adb root
	adb pull /data/1.txt test-04-qms-qcc-qoe11-0.40.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe11-0.40.txt
	#------------------------------------------------------------------------------
	#------------------------------------------------------------------------------ Packet loss rate: 0.50%
	adb shell
	tc qdisc replace dev rmnet_data0 root netem loss 0.50%
	tc qdisc replace dev rmnet_data1 root netem loss 0.50%
	tc qdisc replace dev rmnet_data2 root netem loss 0.50%
	tc qdisc replace dev rmnet_data3 root netem loss 0.50%
	tc qdisc replace dev wlan0 root netem loss 0.50%
	tc qdisc
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-def-cubic-qoe03-0.50.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    2m19.15s real     0m00.05s user     0m01.22s system
	adb root
	adb pull /data/1.txt test-04-def-cubic-qoe03-0.50.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe-def-cubic-qoe03-0.50.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-def-olia-qoe03-0.50.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    4m25.23s real     0m00.03s user     0m01.15s system
	adb root
	adb pull /data/1.txt test-04-def-olia-qoe03-0.50.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe-def-olia-qoe03-0.50.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-qms-qcc-qoe03-0.50.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    1m37.48s real     0m00.02s user     0m00.93s system
	adb root
	adb pull /data/1.txt test-04-qms-qcc-qoe03-0.50.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe03-0.50.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-qms-qcc-qoe07-0.50.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 7 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    1m33.68s real     0m00.02s user     0m00.94s system
	adb root
	adb pull /data/1.txt test-04-qms-qcc-qoe07-0.50.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe07-0.50.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-qms-qcc-qoe11-0.50.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 11 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    1m40.02s real     0m00.03s user     0m00.95s system
	adb root
	adb pull /data/1.txt test-04-qms-qcc-qoe11-0.50.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe11-0.50.txt
	#------------------------------------------------------------------------------
	#------------------------------------------------------------------------------ Packet loss rate: 0.60%
	adb shell
	tc qdisc replace dev rmnet_data0 root netem loss 0.60%
	tc qdisc replace dev rmnet_data1 root netem loss 0.60%
	tc qdisc replace dev rmnet_data2 root netem loss 0.60%
	tc qdisc replace dev rmnet_data3 root netem loss 0.60%
	tc qdisc replace dev wlan0 root netem loss 0.60%
	tc qdisc
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-def-cubic-qoe03-0.60.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=cubic'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    2m37.91s real     0m00.04s user     0m01.20s system
	adb root
	adb pull /data/1.txt test-04-def-cubic-qoe03-0.60.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe-def-cubic-qoe03-0.60.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-def-olia-qoe03-0.60.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=default && sysctl net.ipv4.tcp_congestion_control=olia'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    4m51.65s real     0m00.09s user     0m01.16s system
	adb root
	adb pull /data/1.txt test-04-def-olia-qoe03-0.60.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe-def-olia-qoe03-0.60.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-qms-qcc-qoe03-0.60.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 3 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    2m01.28s real     0m00.02s user     0m00.88s system
	adb root
	adb pull /data/1.txt test-04-qms-qcc-qoe03-0.60.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe03-0.60.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-qms-qcc-qoe07-0.60.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 7 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    2m01.75s real     0m00.03s user     0m00.93s system
	adb root
	adb pull /data/1.txt test-04-qms-qcc-qoe07-0.60.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe07-0.60.txt
	#…………………………………………
	# Server side, packet capture
	tcpdump -vv -n -i ens5 > tcpdump---test-04-qms-qcc-qoe11-0.60.txt

	adb shell "su -c 'sysctl net.mptcp.mptcp_scheduler=qms && sysctl net.ipv4.tcp_congestion_control=qcc'"
	adb shell "su -c 'ip tcp_metrics flush && dmesg -c > /dev/null && time iperf3qoe --qoe 11 -c 8.140.122.222 -f K -n 160M > /data/iperf3qoe.txt && dmesg > /data/1.txt'"
										#    
										#    2m09.86s real     0m00.16s user     0m00.76s system
	adb root
	adb pull /data/1.txt test-04-qms-qcc-qoe11-0.60.txt
										/bin/mv /root/tcpdump---paper2-test/* /root/tcpdump---paper2-test/
										adb root && adb shell "su -c 'mount -o remount,rw /'"
										adb reboot
										adb shell "su -c 'pkill iperf3qoe'"
										adb pull /data/iperf3qoe.txt iperf3qoe---test-04-qms-qcc-qoe11-0.60.txt
	#------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------------------------------------




##################################################
#
# Processing raw data: execute grep "QOE_send: name:wlan0" and grep "QOE_send: name:rmnet_data" commands to process the test-0*.txt file, 
# mainly to obtain ssthresh and cwnd
#
##################################################


#----------------------------------------------------------
# Obtain the benchmark time of each test-*.txt file
#----------------------------------------------------------

# General method: the first step, the second step, the third step
# Step 1: Add a space after [in [32093.979089]. In order to process all files together, add a space after [ in [952.351487]
cd /root/paper2---original--test--data---20210729---OK
sed -i 's/^\[/\[ /g' *

# Step 2: Test
sed -n "1,1p" test-01-def-cubic-qoe02.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'

# Step 3: Obtain the benchmark time of each test-*.txt file

sed -n "1,1p" test-01-def-cubic-qoe01.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-01-def-cubic-qoe02.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-01-def-cubic-qoe03.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-01-def-cubic-qoe07.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-01-def-cubic-qoe11.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-01-def-olia-qoe01.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-01-def-olia-qoe02.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-01-def-olia-qoe03.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-01-def-olia-qoe07.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-01-def-olia-qoe11.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-01-qms-qcc-qoe01.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-01-qms-qcc-qoe02.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-01-qms-qcc-qoe03.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-01-qms-qcc-qoe07.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-01-qms-qcc-qoe11.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-def-cubic-qoe03-0.10.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-def-cubic-qoe03-0.20.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-def-cubic-qoe03-0.30.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-def-cubic-qoe03-0.40.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-def-cubic-qoe03-0.50.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-def-cubic-qoe03-0.60.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-def-olia-qoe03-0.10.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-def-olia-qoe03-0.20.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-def-olia-qoe03-0.30.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-def-olia-qoe03-0.40.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-def-olia-qoe03-0.50.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-def-olia-qoe03-0.60.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-qms-qcc-qoe03-0.10.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-qms-qcc-qoe03-0.20.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-qms-qcc-qoe03-0.30.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-qms-qcc-qoe03-0.40.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-qms-qcc-qoe03-0.50.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-qms-qcc-qoe03-0.60.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-qms-qcc-qoe07-0.10.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-qms-qcc-qoe07-0.20.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-qms-qcc-qoe07-0.30.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-qms-qcc-qoe07-0.40.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-qms-qcc-qoe07-0.50.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-qms-qcc-qoe07-0.60.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-qms-qcc-qoe11-0.10.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-qms-qcc-qoe11-0.20.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-qms-qcc-qoe11-0.30.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-qms-qcc-qoe11-0.40.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-qms-qcc-qoe11-0.50.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-02-qms-qcc-qoe11-0.60.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-03-def-cubic-qoe01.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-03-def-cubic-qoe02.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-03-def-cubic-qoe03.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-03-def-cubic-qoe07.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-03-def-cubic-qoe11.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-03-def-olia-qoe01.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-03-def-olia-qoe02.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-03-def-olia-qoe03.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-03-def-olia-qoe07.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-03-def-olia-qoe11.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-03-qms-qcc-qoe01.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-03-qms-qcc-qoe02.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-03-qms-qcc-qoe03.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-03-qms-qcc-qoe07.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-03-qms-qcc-qoe11.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-def-cubic-qoe03-0.10.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-def-cubic-qoe03-0.20.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-def-cubic-qoe03-0.30.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-def-cubic-qoe03-0.40.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-def-cubic-qoe03-0.50.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-def-cubic-qoe03-0.60.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-def-olia-qoe03-0.10.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-def-olia-qoe03-0.20.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-def-olia-qoe03-0.30.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-def-olia-qoe03-0.40.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-def-olia-qoe03-0.50.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-def-olia-qoe03-0.60.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-qms-qcc-qoe03-0.10.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-qms-qcc-qoe03-0.20.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-qms-qcc-qoe03-0.30.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-qms-qcc-qoe03-0.40.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-qms-qcc-qoe03-0.50.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-qms-qcc-qoe03-0.60.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-qms-qcc-qoe07-0.10.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-qms-qcc-qoe07-0.20.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-qms-qcc-qoe07-0.30.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-qms-qcc-qoe07-0.40.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-qms-qcc-qoe07-0.50.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-qms-qcc-qoe07-0.60.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-qms-qcc-qoe11-0.10.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-qms-qcc-qoe11-0.20.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-qms-qcc-qoe11-0.30.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-qms-qcc-qoe11-0.40.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-qms-qcc-qoe11-0.50.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
sed -n "1,1p" test-04-qms-qcc-qoe11-0.60.txt | cut -c 1-15 | awk -F[ '{printf("%.6f\n",$2)}'
#----------------------------------------------------------



#----------------------------------------------------------
# Before obtaining the data files (ssthresh, cwnd), need to modify the test-*.txt file
#----------------------------------------------------------

# For example, the following line exists
'
[  6039.030652] QOE_send: name:wlan0: nif:2: nif:2: trigger:1: qoe:7: window:8261: wscale:9: sort_bdp:2: sort_rtt:1: sort_cwnd:1: rtt:25130: ssthresh:31: cwnd:32: delivered:84421: lost:104: retrans:138
'
# However, the correct format is as follows
'
[  6039.083246] [20210727_17:51:15.219510]@1 QOE_send: name:wlan0: nif:2: nif:2: trigger:1: qoe:7: window:8261: wscale:9: sort_bdp:2: sort_rtt:1: sort_cwnd:1: rtt:24822: ssthresh:31: cwnd:32: delivered:84434: lost:104: retrans:138
'


# Therefore, you need to check the test-*.txt file
] QOE_send
# Replace with
] [20210727_17:51:15.219510]@1 QOE_send


cd /root/paper2---original--test--data---20210729---OK
gedit test-01*.txt
gedit test-02*.txt
gedit test-03*.txt
gedit test-04*.txt


#----------------------------------------------------------
# The following 180 commands generate data files for drawing (ssthresh, cwnd)
#----------------------------------------------------------

# Execute the following 180 commands to generate data files for drawing (ssthresh, cwnd)

grep "QOE_send: name:wlan0" test-01-def-cubic-qoe01.txt | awk '{printf("%.6f: %s %s\n",$2-32527.010570,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-cubic-qoe01.txt---wlan0
grep "QOE_send: name:wlan0" test-01-def-cubic-qoe02.txt | awk '{printf("%.6f: %s %s\n",$2-952.351487,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-cubic-qoe02.txt---wlan0
grep "QOE_send: name:wlan0" test-01-def-cubic-qoe03.txt | awk '{printf("%.6f: %s %s\n",$2-1830.520973,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-cubic-qoe03.txt---wlan0
grep "QOE_send: name:wlan0" test-01-def-cubic-qoe07.txt | awk '{printf("%.6f: %s %s\n",$2-2243.070910,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-cubic-qoe07.txt---wlan0
grep "QOE_send: name:wlan0" test-01-def-cubic-qoe11.txt | awk '{printf("%.6f: %s %s\n",$2-69.030813,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-cubic-qoe11.txt---wlan0
grep "QOE_send: name:wlan0" test-01-def-olia-qoe01.txt | awk '{printf("%.6f: %s %s\n",$2-5126.995869,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-olia-qoe01.txt---wlan0
grep "QOE_send: name:wlan0" test-01-def-olia-qoe02.txt | awk '{printf("%.6f: %s %s\n",$2-6463.966319,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-olia-qoe02.txt---wlan0
grep "QOE_send: name:wlan0" test-01-def-olia-qoe03.txt | awk '{printf("%.6f: %s %s\n",$2-3171.222401,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-olia-qoe03.txt---wlan0
grep "QOE_send: name:wlan0" test-01-def-olia-qoe07.txt | awk '{printf("%.6f: %s %s\n",$2-2700.561291,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-olia-qoe07.txt---wlan0
grep "QOE_send: name:wlan0" test-01-def-olia-qoe11.txt | awk '{printf("%.6f: %s %s\n",$2-2174.564854,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-olia-qoe11.txt---wlan0
grep "QOE_send: name:wlan0" test-01-qms-qcc-qoe01.txt | awk '{printf("%.6f: %s %s\n",$2-1497.266213,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-qms-qcc-qoe01.txt---wlan0
grep "QOE_send: name:wlan0" test-01-qms-qcc-qoe02.txt | awk '{printf("%.6f: %s %s\n",$2-973.891936,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-qms-qcc-qoe02.txt---wlan0
grep "QOE_send: name:wlan0" test-01-qms-qcc-qoe03.txt | awk '{printf("%.6f: %s %s\n",$2-3035.331152,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-qms-qcc-qoe03.txt---wlan0
grep "QOE_send: name:wlan0" test-01-qms-qcc-qoe07.txt | awk '{printf("%.6f: %s %s\n",$2-2640.772601,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-qms-qcc-qoe07.txt---wlan0
grep "QOE_send: name:wlan0" test-01-qms-qcc-qoe11.txt | awk '{printf("%.6f: %s %s\n",$2-3342.079928,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-qms-qcc-qoe11.txt---wlan0
grep "QOE_send: name:wlan0" test-02-def-cubic-qoe03-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-6613.377963,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-cubic-qoe03-0.10.txt---wlan0
grep "QOE_send: name:wlan0" test-02-def-cubic-qoe03-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-4742.952395,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-cubic-qoe03-0.20.txt---wlan0
grep "QOE_send: name:wlan0" test-02-def-cubic-qoe03-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-106.331638,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-cubic-qoe03-0.30.txt---wlan0
grep "QOE_send: name:wlan0" test-02-def-cubic-qoe03-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-14939.332985,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-cubic-qoe03-0.40.txt---wlan0
grep "QOE_send: name:wlan0" test-02-def-cubic-qoe03-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-16704.473975,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-cubic-qoe03-0.50.txt---wlan0
grep "QOE_send: name:wlan0" test-02-def-cubic-qoe03-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-20642.318769,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-cubic-qoe03-0.60.txt---wlan0
grep "QOE_send: name:wlan0" test-02-def-olia-qoe03-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-7084.690102,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-olia-qoe03-0.10.txt---wlan0
grep "QOE_send: name:wlan0" test-02-def-olia-qoe03-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-3131.406841,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-olia-qoe03-0.20.txt---wlan0
grep "QOE_send: name:wlan0" test-02-def-olia-qoe03-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-28710.092985,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-olia-qoe03-0.30.txt---wlan0
grep "QOE_send: name:wlan0" test-02-def-olia-qoe03-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-15660.072470,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-olia-qoe03-0.40.txt---wlan0
grep "QOE_send: name:wlan0" test-02-def-olia-qoe03-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-24876.737482,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-olia-qoe03-0.50.txt---wlan0
grep "QOE_send: name:wlan0" test-02-def-olia-qoe03-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-18624.054906,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-olia-qoe03-0.60.txt---wlan0
grep "QOE_send: name:wlan0" test-02-qms-qcc-qoe03-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-2833.490186,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe03-0.10.txt---wlan0
grep "QOE_send: name:wlan0" test-02-qms-qcc-qoe03-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-5219.266532,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe03-0.20.txt---wlan0
grep "QOE_send: name:wlan0" test-02-qms-qcc-qoe03-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-3682.946776,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe03-0.30.txt---wlan0
grep "QOE_send: name:wlan0" test-02-qms-qcc-qoe03-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-6484.852319,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe03-0.40.txt---wlan0
grep "QOE_send: name:wlan0" test-02-qms-qcc-qoe03-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-27843.192466,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe03-0.50.txt---wlan0
grep "QOE_send: name:wlan0" test-02-qms-qcc-qoe03-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-30328.707081,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe03-0.60.txt---wlan0
grep "QOE_send: name:wlan0" test-02-qms-qcc-qoe07-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-2399.680557,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe07-0.10.txt---wlan0
grep "QOE_send: name:wlan0" test-02-qms-qcc-qoe07-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-5662.150473,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe07-0.20.txt---wlan0
grep "QOE_send: name:wlan0" test-02-qms-qcc-qoe07-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-8163.830222,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe07-0.30.txt---wlan0
grep "QOE_send: name:wlan0" test-02-qms-qcc-qoe07-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-7066.072991,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe07-0.40.txt---wlan0
grep "QOE_send: name:wlan0" test-02-qms-qcc-qoe07-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-7622.431144,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe07-0.50.txt---wlan0
grep "QOE_send: name:wlan0" test-02-qms-qcc-qoe07-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-2040.160769,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe07-0.60.txt---wlan0
grep "QOE_send: name:wlan0" test-02-qms-qcc-qoe11-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-3291.829077,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe11-0.10.txt---wlan0
grep "QOE_send: name:wlan0" test-02-qms-qcc-qoe11-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-6098.429801,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe11-0.20.txt---wlan0
grep "QOE_send: name:wlan0" test-02-qms-qcc-qoe11-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-4197.205701,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe11-0.30.txt---wlan0
grep "QOE_send: name:wlan0" test-02-qms-qcc-qoe11-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-8942.332816,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe11-0.40.txt---wlan0
grep "QOE_send: name:wlan0" test-02-qms-qcc-qoe11-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-727.474717,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe11-0.50.txt---wlan0
grep "QOE_send: name:wlan0" test-02-qms-qcc-qoe11-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-6823.917635,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe11-0.60.txt---wlan0
grep "QOE_send: name:wlan0" test-03-def-cubic-qoe01.txt | awk '{printf("%.6f: %s %s\n",$2-340.989910,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-cubic-qoe01.txt---wlan0
grep "QOE_send: name:wlan0" test-03-def-cubic-qoe02.txt | awk '{printf("%.6f: %s %s\n",$2-972.631611,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-cubic-qoe02.txt---wlan0
grep "QOE_send: name:wlan0" test-03-def-cubic-qoe03.txt | awk '{printf("%.6f: %s %s\n",$2-419.671376,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-cubic-qoe03.txt---wlan0
grep "QOE_send: name:wlan0" test-03-def-cubic-qoe07.txt | awk '{printf("%.6f: %s %s\n",$2-63.228505,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-cubic-qoe07.txt---wlan0
grep "QOE_send: name:wlan0" test-03-def-cubic-qoe11.txt | awk '{printf("%.6f: %s %s\n",$2-117.532087,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-cubic-qoe11.txt---wlan0
grep "QOE_send: name:wlan0" test-03-def-olia-qoe01.txt | awk '{printf("%.6f: %s %s\n",$2-57.988606,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-olia-qoe01.txt---wlan0
grep "QOE_send: name:wlan0" test-03-def-olia-qoe02.txt | awk '{printf("%.6f: %s %s\n",$2-42.947730,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-olia-qoe02.txt---wlan0
grep "QOE_send: name:wlan0" test-03-def-olia-qoe03.txt | awk '{printf("%.6f: %s %s\n",$2-146.571112,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-olia-qoe03.txt---wlan0
grep "QOE_send: name:wlan0" test-03-def-olia-qoe07.txt | awk '{printf("%.6f: %s %s\n",$2-174.470544,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-olia-qoe07.txt---wlan0
grep "QOE_send: name:wlan0" test-03-def-olia-qoe11.txt | awk '{printf("%.6f: %s %s\n",$2-93.650236,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-olia-qoe11.txt---wlan0
grep "QOE_send: name:wlan0" test-03-qms-qcc-qoe01.txt | awk '{printf("%.6f: %s %s\n",$2-8986.651580,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-qms-qcc-qoe01.txt---wlan0
grep "QOE_send: name:wlan0" test-03-qms-qcc-qoe02.txt | awk '{printf("%.6f: %s %s\n",$2-8899.652312,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-qms-qcc-qoe02.txt---wlan0
grep "QOE_send: name:wlan0" test-03-qms-qcc-qoe03.txt | awk '{printf("%.6f: %s %s\n",$2-8842.272604,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-qms-qcc-qoe03.txt---wlan0
grep "QOE_send: name:wlan0" test-03-qms-qcc-qoe07.txt | awk '{printf("%.6f: %s %s\n",$2-8783.753561,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-qms-qcc-qoe07.txt---wlan0
grep "QOE_send: name:wlan0" test-03-qms-qcc-qoe11.txt | awk '{printf("%.6f: %s %s\n",$2-8726.350890,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-qms-qcc-qoe11.txt---wlan0
grep "QOE_send: name:wlan0" test-04-def-cubic-qoe03-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-364.095402,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-cubic-qoe03-0.10.txt---wlan0
grep "QOE_send: name:wlan0" test-04-def-cubic-qoe03-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-8912.247521,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-cubic-qoe03-0.20.txt---wlan0
grep "QOE_send: name:wlan0" test-04-def-cubic-qoe03-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-151.138253,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-cubic-qoe03-0.30.txt---wlan0
grep "QOE_send: name:wlan0" test-04-def-cubic-qoe03-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-340.153267,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-cubic-qoe03-0.40.txt---wlan0
grep "QOE_send: name:wlan0" test-04-def-cubic-qoe03-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-607.633146,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-cubic-qoe03-0.50.txt---wlan0
grep "QOE_send: name:wlan0" test-04-def-cubic-qoe03-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-844.654591,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-cubic-qoe03-0.60.txt---wlan0
grep "QOE_send: name:wlan0" test-04-def-olia-qoe03-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-489.471976,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-olia-qoe03-0.10.txt---wlan0
grep "QOE_send: name:wlan0" test-04-def-olia-qoe03-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-9996.792408,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-olia-qoe03-0.20.txt---wlan0
grep "QOE_send: name:wlan0" test-04-def-olia-qoe03-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-13056.290255,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-olia-qoe03-0.30.txt---wlan0
grep "QOE_send: name:wlan0" test-04-def-olia-qoe03-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-22890.172652,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-olia-qoe03-0.40.txt---wlan0
grep "QOE_send: name:wlan0" test-04-def-olia-qoe03-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-22501.728709,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-olia-qoe03-0.50.txt---wlan0
grep "QOE_send: name:wlan0" test-04-def-olia-qoe03-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-18121.908478,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-olia-qoe03-0.60.txt---wlan0
grep "QOE_send: name:wlan0" test-04-qms-qcc-qoe03-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-248.006696,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe03-0.10.txt---wlan0
grep "QOE_send: name:wlan0" test-04-qms-qcc-qoe03-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-802.051703,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe03-0.20.txt---wlan0
grep "QOE_send: name:wlan0" test-04-qms-qcc-qoe03-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-13433.554547,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe03-0.30.txt---wlan0
grep "QOE_send: name:wlan0" test-04-qms-qcc-qoe03-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-15190.230483,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe03-0.40.txt---wlan0
grep "QOE_send: name:wlan0" test-04-qms-qcc-qoe03-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-17098.618761,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe03-0.50.txt---wlan0
grep "QOE_send: name:wlan0" test-04-qms-qcc-qoe03-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-22110.707691,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe03-0.60.txt---wlan0
grep "QOE_send: name:wlan0" test-04-qms-qcc-qoe07-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-608.993044,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe07-0.10.txt---wlan0
grep "QOE_send: name:wlan0" test-04-qms-qcc-qoe07-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-10462.447347,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe07-0.20.txt---wlan0
grep "QOE_send: name:wlan0" test-04-qms-qcc-qoe07-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-13558.694040,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe07-0.30.txt---wlan0
grep "QOE_send: name:wlan0" test-04-qms-qcc-qoe07-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-15319.067944,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe07-0.40.txt---wlan0
grep "QOE_send: name:wlan0" test-04-qms-qcc-qoe07-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-17352.906200,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe07-0.50.txt---wlan0
grep "QOE_send: name:wlan0" test-04-qms-qcc-qoe07-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-21940.287904,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe07-0.60.txt---wlan0
grep "QOE_send: name:wlan0" test-04-qms-qcc-qoe11-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-11444.209467,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe11-0.10.txt---wlan0
grep "QOE_send: name:wlan0" test-04-qms-qcc-qoe11-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-10573.249084,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe11-0.20.txt---wlan0
grep "QOE_send: name:wlan0" test-04-qms-qcc-qoe11-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-5823.431107,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe11-0.30.txt---wlan0
grep "QOE_send: name:wlan0" test-04-qms-qcc-qoe11-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-15465.150136,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe11-0.40.txt---wlan0
grep "QOE_send: name:wlan0" test-04-qms-qcc-qoe11-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-83.431537,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe11-0.50.txt---wlan0
grep "QOE_send: name:wlan0" test-04-qms-qcc-qoe11-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-21760.636571,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe11-0.60.txt---wlan0

grep "QOE_send: name:rmnet_data" test-01-def-cubic-qoe01.txt | awk '{printf("%.6f: %s %s\n",$2-32527.010570,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-cubic-qoe01.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-01-def-cubic-qoe02.txt | awk '{printf("%.6f: %s %s\n",$2-952.351487,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-cubic-qoe02.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-01-def-cubic-qoe03.txt | awk '{printf("%.6f: %s %s\n",$2-1830.520973,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-cubic-qoe03.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-01-def-cubic-qoe07.txt | awk '{printf("%.6f: %s %s\n",$2-2243.070910,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-cubic-qoe07.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-01-def-cubic-qoe11.txt | awk '{printf("%.6f: %s %s\n",$2-69.030813,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-cubic-qoe11.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-01-def-olia-qoe01.txt | awk '{printf("%.6f: %s %s\n",$2-5126.995869,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-olia-qoe01.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-01-def-olia-qoe02.txt | awk '{printf("%.6f: %s %s\n",$2-6463.966319,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-olia-qoe02.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-01-def-olia-qoe03.txt | awk '{printf("%.6f: %s %s\n",$2-3171.222401,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-olia-qoe03.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-01-def-olia-qoe07.txt | awk '{printf("%.6f: %s %s\n",$2-2700.561291,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-olia-qoe07.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-01-def-olia-qoe11.txt | awk '{printf("%.6f: %s %s\n",$2-2174.564854,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-def-olia-qoe11.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-01-qms-qcc-qoe01.txt | awk '{printf("%.6f: %s %s\n",$2-1497.266213,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-qms-qcc-qoe01.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-01-qms-qcc-qoe02.txt | awk '{printf("%.6f: %s %s\n",$2-973.891936,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-qms-qcc-qoe02.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-01-qms-qcc-qoe03.txt | awk '{printf("%.6f: %s %s\n",$2-3035.331152,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-qms-qcc-qoe03.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-01-qms-qcc-qoe07.txt | awk '{printf("%.6f: %s %s\n",$2-2640.772601,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-qms-qcc-qoe07.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-01-qms-qcc-qoe11.txt | awk '{printf("%.6f: %s %s\n",$2-3342.079928,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-01-qms-qcc-qoe11.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-def-cubic-qoe03-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-6613.377963,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-cubic-qoe03-0.10.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-def-cubic-qoe03-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-4742.952395,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-cubic-qoe03-0.20.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-def-cubic-qoe03-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-106.331638,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-cubic-qoe03-0.30.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-def-cubic-qoe03-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-14939.332985,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-cubic-qoe03-0.40.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-def-cubic-qoe03-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-16704.473975,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-cubic-qoe03-0.50.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-def-cubic-qoe03-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-20642.318769,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-cubic-qoe03-0.60.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-def-olia-qoe03-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-7084.690102,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-olia-qoe03-0.10.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-def-olia-qoe03-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-3131.406841,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-olia-qoe03-0.20.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-def-olia-qoe03-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-28710.092985,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-olia-qoe03-0.30.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-def-olia-qoe03-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-15660.072470,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-olia-qoe03-0.40.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-def-olia-qoe03-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-24876.737482,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-olia-qoe03-0.50.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-def-olia-qoe03-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-18624.054906,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-def-olia-qoe03-0.60.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-qms-qcc-qoe03-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-2833.490186,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe03-0.10.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-qms-qcc-qoe03-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-5219.266532,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe03-0.20.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-qms-qcc-qoe03-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-3682.946776,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe03-0.30.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-qms-qcc-qoe03-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-6484.852319,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe03-0.40.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-qms-qcc-qoe03-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-27843.192466,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe03-0.50.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-qms-qcc-qoe03-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-30328.707081,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe03-0.60.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-qms-qcc-qoe07-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-2399.680557,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe07-0.10.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-qms-qcc-qoe07-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-5662.150473,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe07-0.20.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-qms-qcc-qoe07-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-8163.830222,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe07-0.30.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-qms-qcc-qoe07-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-7066.072991,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe07-0.40.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-qms-qcc-qoe07-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-7622.431144,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe07-0.50.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-qms-qcc-qoe07-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-2040.160769,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe07-0.60.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-qms-qcc-qoe11-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-3291.829077,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe11-0.10.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-qms-qcc-qoe11-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-6098.429801,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe11-0.20.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-qms-qcc-qoe11-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-4197.205701,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe11-0.30.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-qms-qcc-qoe11-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-8942.332816,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe11-0.40.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-qms-qcc-qoe11-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-727.474717,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe11-0.50.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-02-qms-qcc-qoe11-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-6823.917635,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-02-qms-qcc-qoe11-0.60.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-03-def-cubic-qoe01.txt | awk '{printf("%.6f: %s %s\n",$2-340.989910,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-cubic-qoe01.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-03-def-cubic-qoe02.txt | awk '{printf("%.6f: %s %s\n",$2-972.631611,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-cubic-qoe02.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-03-def-cubic-qoe03.txt | awk '{printf("%.6f: %s %s\n",$2-419.671376,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-cubic-qoe03.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-03-def-cubic-qoe07.txt | awk '{printf("%.6f: %s %s\n",$2-63.228505,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-cubic-qoe07.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-03-def-cubic-qoe11.txt | awk '{printf("%.6f: %s %s\n",$2-117.532087,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-cubic-qoe11.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-03-def-olia-qoe01.txt | awk '{printf("%.6f: %s %s\n",$2-57.988606,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-olia-qoe01.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-03-def-olia-qoe02.txt | awk '{printf("%.6f: %s %s\n",$2-42.947730,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-olia-qoe02.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-03-def-olia-qoe03.txt | awk '{printf("%.6f: %s %s\n",$2-146.571112,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-olia-qoe03.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-03-def-olia-qoe07.txt | awk '{printf("%.6f: %s %s\n",$2-174.470544,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-olia-qoe07.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-03-def-olia-qoe11.txt | awk '{printf("%.6f: %s %s\n",$2-93.650236,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-def-olia-qoe11.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-03-qms-qcc-qoe01.txt | awk '{printf("%.6f: %s %s\n",$2-8986.651580,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-qms-qcc-qoe01.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-03-qms-qcc-qoe02.txt | awk '{printf("%.6f: %s %s\n",$2-8899.652312,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-qms-qcc-qoe02.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-03-qms-qcc-qoe03.txt | awk '{printf("%.6f: %s %s\n",$2-8842.272604,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-qms-qcc-qoe03.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-03-qms-qcc-qoe07.txt | awk '{printf("%.6f: %s %s\n",$2-8783.753561,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-qms-qcc-qoe07.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-03-qms-qcc-qoe11.txt | awk '{printf("%.6f: %s %s\n",$2-8726.350890,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-03-qms-qcc-qoe11.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-def-cubic-qoe03-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-364.095402,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-cubic-qoe03-0.10.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-def-cubic-qoe03-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-8912.247521,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-cubic-qoe03-0.20.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-def-cubic-qoe03-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-151.138253,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-cubic-qoe03-0.30.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-def-cubic-qoe03-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-340.153267,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-cubic-qoe03-0.40.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-def-cubic-qoe03-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-607.633146,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-cubic-qoe03-0.50.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-def-cubic-qoe03-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-844.654591,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-cubic-qoe03-0.60.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-def-olia-qoe03-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-489.471976,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-olia-qoe03-0.10.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-def-olia-qoe03-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-9996.792408,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-olia-qoe03-0.20.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-def-olia-qoe03-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-13056.290255,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-olia-qoe03-0.30.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-def-olia-qoe03-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-22890.172652,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-olia-qoe03-0.40.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-def-olia-qoe03-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-22501.728709,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-olia-qoe03-0.50.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-def-olia-qoe03-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-18121.908478,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-def-olia-qoe03-0.60.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-qms-qcc-qoe03-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-248.006696,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe03-0.10.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-qms-qcc-qoe03-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-802.051703,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe03-0.20.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-qms-qcc-qoe03-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-13433.554547,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe03-0.30.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-qms-qcc-qoe03-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-15190.230483,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe03-0.40.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-qms-qcc-qoe03-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-17098.618761,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe03-0.50.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-qms-qcc-qoe03-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-22110.707691,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe03-0.60.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-qms-qcc-qoe07-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-608.993044,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe07-0.10.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-qms-qcc-qoe07-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-10462.447347,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe07-0.20.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-qms-qcc-qoe07-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-13558.694040,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe07-0.30.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-qms-qcc-qoe07-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-15319.067944,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe07-0.40.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-qms-qcc-qoe07-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-17352.906200,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe07-0.50.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-qms-qcc-qoe07-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-21940.287904,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe07-0.60.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-qms-qcc-qoe11-0.10.txt | awk '{printf("%.6f: %s %s\n",$2-11444.209467,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe11-0.10.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-qms-qcc-qoe11-0.20.txt | awk '{printf("%.6f: %s %s\n",$2-10573.249084,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe11-0.20.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-qms-qcc-qoe11-0.30.txt | awk '{printf("%.6f: %s %s\n",$2-5823.431107,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe11-0.30.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-qms-qcc-qoe11-0.40.txt | awk '{printf("%.6f: %s %s\n",$2-15465.150136,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe11-0.40.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-qms-qcc-qoe11-0.50.txt | awk '{printf("%.6f: %s %s\n",$2-83.431537,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe11-0.50.txt---rmnet_data
grep "QOE_send: name:rmnet_data" test-04-qms-qcc-qoe11-0.60.txt | awk '{printf("%.6f: %s %s\n",$2-21760.636571,$16,$17)}' | awk -F: '{printf("%.6f %s %s\n",$1,$3,$5)}' > test-04-qms-qcc-qoe11-0.60.txt---rmnet_data
#----------------------------------------------------------


#----------------------------------------------------------
# The following 180 commands get the data used for drawing (time, namely: transmission time)
#----------------------------------------------------------

# Execute the following 180 commands 

tail -n 1 test-01-def-cubic-qoe01.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-def-cubic-qoe02.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-def-cubic-qoe03.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-def-cubic-qoe07.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-def-cubic-qoe11.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-def-olia-qoe01.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-def-olia-qoe02.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-def-olia-qoe03.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-def-olia-qoe07.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-def-olia-qoe11.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-qms-qcc-qoe01.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-qms-qcc-qoe02.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-qms-qcc-qoe03.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-qms-qcc-qoe07.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-qms-qcc-qoe11.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-cubic-qoe03-0.10.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-cubic-qoe03-0.20.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-cubic-qoe03-0.30.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-cubic-qoe03-0.40.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-cubic-qoe03-0.50.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-cubic-qoe03-0.60.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-olia-qoe03-0.10.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-olia-qoe03-0.20.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-olia-qoe03-0.30.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-olia-qoe03-0.40.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-olia-qoe03-0.50.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-olia-qoe03-0.60.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe03-0.10.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe03-0.20.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe03-0.30.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe03-0.40.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe03-0.50.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe03-0.60.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe07-0.10.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe07-0.20.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe07-0.30.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe07-0.40.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe07-0.50.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe07-0.60.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe11-0.10.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe11-0.20.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe11-0.30.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe11-0.40.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe11-0.50.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe11-0.60.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-cubic-qoe01.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-cubic-qoe02.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-cubic-qoe03.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-cubic-qoe07.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-cubic-qoe11.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-olia-qoe01.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-olia-qoe02.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-olia-qoe03.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-olia-qoe07.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-olia-qoe11.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-qms-qcc-qoe01.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-qms-qcc-qoe02.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-qms-qcc-qoe03.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-qms-qcc-qoe07.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-qms-qcc-qoe11.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-cubic-qoe03-0.10.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-cubic-qoe03-0.20.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-cubic-qoe03-0.30.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-cubic-qoe03-0.40.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-cubic-qoe03-0.50.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-cubic-qoe03-0.60.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-olia-qoe03-0.10.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-olia-qoe03-0.20.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-olia-qoe03-0.30.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-olia-qoe03-0.40.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-olia-qoe03-0.50.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-olia-qoe03-0.60.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe03-0.10.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe03-0.20.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe03-0.30.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe03-0.40.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe03-0.50.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe03-0.60.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe07-0.10.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe07-0.20.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe07-0.30.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe07-0.40.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe07-0.50.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe07-0.60.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe11-0.10.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe11-0.20.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe11-0.30.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe11-0.40.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe11-0.50.txt---wlan0 | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe11-0.60.txt---wlan0 | awk '{printf("%s\n",$1)}'

tail -n 1 test-01-def-cubic-qoe01.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-def-cubic-qoe02.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-def-cubic-qoe03.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-def-cubic-qoe07.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-def-cubic-qoe11.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-def-olia-qoe01.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-def-olia-qoe02.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-def-olia-qoe03.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-def-olia-qoe07.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-def-olia-qoe11.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-qms-qcc-qoe01.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-qms-qcc-qoe02.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-qms-qcc-qoe03.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-qms-qcc-qoe07.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-01-qms-qcc-qoe11.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-cubic-qoe03-0.10.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-cubic-qoe03-0.20.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-cubic-qoe03-0.30.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-cubic-qoe03-0.40.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-cubic-qoe03-0.50.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-cubic-qoe03-0.60.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-olia-qoe03-0.10.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-olia-qoe03-0.20.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-olia-qoe03-0.30.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-olia-qoe03-0.40.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-olia-qoe03-0.50.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-def-olia-qoe03-0.60.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe03-0.10.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe03-0.20.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe03-0.30.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe03-0.40.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe03-0.50.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe03-0.60.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe07-0.10.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe07-0.20.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe07-0.30.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe07-0.40.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe07-0.50.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe07-0.60.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe11-0.10.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe11-0.20.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe11-0.30.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe11-0.40.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe11-0.50.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-02-qms-qcc-qoe11-0.60.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-cubic-qoe01.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-cubic-qoe02.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-cubic-qoe03.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-cubic-qoe07.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-cubic-qoe11.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-olia-qoe01.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-olia-qoe02.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-olia-qoe03.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-olia-qoe07.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-def-olia-qoe11.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-qms-qcc-qoe01.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-qms-qcc-qoe02.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-qms-qcc-qoe03.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-qms-qcc-qoe07.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-03-qms-qcc-qoe11.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-cubic-qoe03-0.10.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-cubic-qoe03-0.20.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-cubic-qoe03-0.30.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-cubic-qoe03-0.40.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-cubic-qoe03-0.50.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-cubic-qoe03-0.60.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-olia-qoe03-0.10.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-olia-qoe03-0.20.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-olia-qoe03-0.30.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-olia-qoe03-0.40.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-olia-qoe03-0.50.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-def-olia-qoe03-0.60.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe03-0.10.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe03-0.20.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe03-0.30.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe03-0.40.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe03-0.50.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe03-0.60.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe07-0.10.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe07-0.20.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe07-0.30.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe07-0.40.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe07-0.50.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe07-0.60.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe11-0.10.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe11-0.20.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe11-0.30.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe11-0.40.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe11-0.50.txt---rmnet_data | awk '{printf("%s\n",$1)}'
tail -n 1 test-04-qms-qcc-qoe11-0.60.txt---rmnet_data | awk '{printf("%s\n",$1)}'

# 获得 作图用 数据 (time, 即：传输时间)

test-01-def-cubic-qoe01.txt---wlan0		337.704775
test-01-def-cubic-qoe02.txt---wlan0		1.413061
test-01-def-cubic-qoe03.txt---wlan0		354.783434
test-01-def-cubic-qoe07.txt---wlan0		317.989985
test-01-def-cubic-qoe11.txt---wlan0		332.674780
test-01-def-olia-qoe01.txt---wlan0		354.140469
test-01-def-olia-qoe02.txt---wlan0		1.400981
test-01-def-olia-qoe03.txt---wlan0		376.553177
test-01-def-olia-qoe07.txt---wlan0		379.922086
test-01-def-olia-qoe11.txt---wlan0		386.521133
test-01-qms-qcc-qoe01.txt---wlan0		282.521784
test-01-qms-qcc-qoe02.txt---wlan0		1.649363
test-01-qms-qcc-qoe03.txt---wlan0		262.552756
test-01-qms-qcc-qoe07.txt---wlan0		276.668866
test-01-qms-qcc-qoe11.txt---wlan0		267.042209
test-02-def-cubic-qoe03-0.10.txt---wlan0		408.670322
test-02-def-cubic-qoe03-0.20.txt---wlan0		485.434248
test-02-def-cubic-qoe03-0.30.txt---wlan0		581.869309
test-02-def-cubic-qoe03-0.40.txt---wlan0		644.565641
test-02-def-cubic-qoe03-0.50.txt---wlan0		722.189982
test-02-def-cubic-qoe03-0.60.txt---wlan0		818.890561
test-02-def-olia-qoe03-0.10.txt---wlan0		435.684766
test-02-def-olia-qoe03-0.20.txt---wlan0		571.822552
test-02-def-olia-qoe03-0.30.txt---wlan0		687.652746
test-02-def-olia-qoe03-0.40.txt---wlan0		805.012315
test-02-def-olia-qoe03-0.50.txt---wlan0		1008.690637
test-02-def-olia-qoe03-0.60.txt---wlan0		1292.133057
test-02-qms-qcc-qoe03-0.10.txt---wlan0		334.122397
test-02-qms-qcc-qoe03-0.20.txt---wlan0		398.941819
test-02-qms-qcc-qoe03-0.30.txt---wlan0		452.193748
test-02-qms-qcc-qoe03-0.40.txt---wlan0		508.235904
test-02-qms-qcc-qoe03-0.50.txt---wlan0		592.318124
test-02-qms-qcc-qoe03-0.60.txt---wlan0		633.419268
test-02-qms-qcc-qoe07-0.10.txt---wlan0		342.723969
test-02-qms-qcc-qoe07-0.20.txt---wlan0		391.759456
test-02-qms-qcc-qoe07-0.30.txt---wlan0		454.134187
test-02-qms-qcc-qoe07-0.40.txt---wlan0		497.586801
test-02-qms-qcc-qoe07-0.50.txt---wlan0		581.959150
test-02-qms-qcc-qoe07-0.60.txt---wlan0		613.878753
test-02-qms-qcc-qoe11-0.10.txt---wlan0		324.968195
test-02-qms-qcc-qoe11-0.20.txt---wlan0		393.669462
test-02-qms-qcc-qoe11-0.30.txt---wlan0		436.176339
test-02-qms-qcc-qoe11-0.40.txt---wlan0		489.080190
test-02-qms-qcc-qoe11-0.50.txt---wlan0		540.962250
test-02-qms-qcc-qoe11-0.60.txt---wlan0		596.352601
test-03-def-cubic-qoe01.txt---wlan0		38.908650
test-03-def-cubic-qoe02.txt---wlan0		2.684202
test-03-def-cubic-qoe03.txt---wlan0		39.741682
test-03-def-cubic-qoe07.txt---wlan0		38.937466
test-03-def-cubic-qoe11.txt---wlan0		39.731484
test-03-def-olia-qoe01.txt---wlan0		48.896790
test-03-def-olia-qoe02.txt---wlan0		0.604357
test-03-def-olia-qoe03.txt---wlan0		53.018218
test-03-def-olia-qoe07.txt---wlan0		47.390487
test-03-def-olia-qoe11.txt---wlan0		53.895364
test-03-qms-qcc-qoe01.txt---wlan0		31.217957
test-03-qms-qcc-qoe02.txt---wlan0		0.573039
test-03-qms-qcc-qoe03.txt---wlan0		25.038942
test-03-qms-qcc-qoe07.txt---wlan0		28.211363
test-03-qms-qcc-qoe11.txt---wlan0		28.151761
test-04-def-cubic-qoe03-0.10.txt---wlan0		63.213469
test-04-def-cubic-qoe03-0.20.txt---wlan0		94.122301
test-04-def-cubic-qoe03-0.30.txt---wlan0		112.878822
test-04-def-cubic-qoe03-0.40.txt---wlan0		122.824660
test-04-def-cubic-qoe03-0.50.txt---wlan0		139.155534
test-04-def-cubic-qoe03-0.60.txt---wlan0		157.954220
test-04-def-olia-qoe03-0.10.txt---wlan0		121.901565
test-04-def-olia-qoe03-0.20.txt---wlan0		169.648608
test-04-def-olia-qoe03-0.30.txt---wlan0		222.350333
test-04-def-olia-qoe03-0.40.txt---wlan0		258.599691
test-04-def-olia-qoe03-0.50.txt---wlan0		265.232434
test-04-def-olia-qoe03-0.60.txt---wlan0		291.647730
test-04-qms-qcc-qoe03-0.10.txt---wlan0		51.657032
test-04-qms-qcc-qoe03-0.20.txt---wlan0		62.598908
test-04-qms-qcc-qoe03-0.30.txt---wlan0		71.650945
test-04-qms-qcc-qoe03-0.40.txt---wlan0		87.333616
test-04-qms-qcc-qoe03-0.50.txt---wlan0		97.482335
test-04-qms-qcc-qoe03-0.60.txt---wlan0		121.282823
test-04-qms-qcc-qoe07-0.10.txt---wlan0		52.782262
test-04-qms-qcc-qoe07-0.20.txt---wlan0		72.828695
test-04-qms-qcc-qoe07-0.30.txt---wlan0		71.778051
test-04-qms-qcc-qoe07-0.40.txt---wlan0		97.456588
test-04-qms-qcc-qoe07-0.50.txt---wlan0		93.682915
test-04-qms-qcc-qoe07-0.60.txt---wlan0		121.735123
test-04-qms-qcc-qoe11-0.10.txt---wlan0		52.681857
test-04-qms-qcc-qoe11-0.20.txt---wlan0		69.841362
test-04-qms-qcc-qoe11-0.30.txt---wlan0		92.908024
test-04-qms-qcc-qoe11-0.40.txt---wlan0		91.239326
test-04-qms-qcc-qoe11-0.50.txt---wlan0		100.036924
test-04-qms-qcc-qoe11-0.60.txt---wlan0		129.865225

test-01-def-cubic-qoe01.txt---rmnet_data		1.492032
test-01-def-cubic-qoe02.txt---rmnet_data		474.965124
test-01-def-cubic-qoe03.txt---rmnet_data		354.511672
test-01-def-cubic-qoe07.txt---rmnet_data		317.758200
test-01-def-cubic-qoe11.txt---rmnet_data		332.650146
test-01-def-olia-qoe01.txt---rmnet_data		0.771159
test-01-def-olia-qoe02.txt---rmnet_data		491.882590
test-01-def-olia-qoe03.txt---rmnet_data		376.618821
test-01-def-olia-qoe07.txt---rmnet_data		379.922305
test-01-def-olia-qoe11.txt---rmnet_data		321.159693
test-01-qms-qcc-qoe01.txt---rmnet_data		1.424398
test-01-qms-qcc-qoe02.txt---rmnet_data		427.790590
test-01-qms-qcc-qoe03.txt---rmnet_data		120.875606
test-01-qms-qcc-qoe07.txt---rmnet_data		180.977960
test-01-qms-qcc-qoe11.txt---rmnet_data		132.768153
test-02-def-cubic-qoe03-0.10.txt---rmnet_data		408.772418
test-02-def-cubic-qoe03-0.20.txt---rmnet_data		485.765619
test-02-def-cubic-qoe03-0.30.txt---rmnet_data		581.561022
test-02-def-cubic-qoe03-0.40.txt---rmnet_data		644.040484
test-02-def-cubic-qoe03-0.50.txt---rmnet_data		722.154958
test-02-def-cubic-qoe03-0.60.txt---rmnet_data		819.118034
test-02-def-olia-qoe03-0.10.txt---rmnet_data		433.712034
test-02-def-olia-qoe03-0.20.txt---rmnet_data		571.408869
test-02-def-olia-qoe03-0.30.txt---rmnet_data		687.452439
test-02-def-olia-qoe03-0.40.txt---rmnet_data		804.776099
test-02-def-olia-qoe03-0.50.txt---rmnet_data		1008.984713
test-02-def-olia-qoe03-0.60.txt---rmnet_data		1292.209821
test-02-qms-qcc-qoe03-0.10.txt---rmnet_data		334.143884
test-02-qms-qcc-qoe03-0.20.txt---rmnet_data		396.135091
test-02-qms-qcc-qoe03-0.30.txt---rmnet_data		452.026434
test-02-qms-qcc-qoe03-0.40.txt---rmnet_data		508.519824
test-02-qms-qcc-qoe03-0.50.txt---rmnet_data		591.995212
test-02-qms-qcc-qoe03-0.60.txt---rmnet_data		633.545052
test-02-qms-qcc-qoe07-0.10.txt---rmnet_data		342.723696
test-02-qms-qcc-qoe07-0.20.txt---rmnet_data		391.489547
test-02-qms-qcc-qoe07-0.30.txt---rmnet_data		453.873968
test-02-qms-qcc-qoe07-0.40.txt---rmnet_data		497.593288
test-02-qms-qcc-qoe07-0.50.txt---rmnet_data		582.252541
test-02-qms-qcc-qoe07-0.60.txt---rmnet_data		614.023608
test-02-qms-qcc-qoe11-0.10.txt---rmnet_data		283.399181
test-02-qms-qcc-qoe11-0.20.txt---rmnet_data		393.391584
test-02-qms-qcc-qoe11-0.30.txt---rmnet_data		436.087514
test-02-qms-qcc-qoe11-0.40.txt---rmnet_data		489.148073
test-02-qms-qcc-qoe11-0.50.txt---rmnet_data		540.987712
test-02-qms-qcc-qoe11-0.60.txt---rmnet_data		595.951398
test-03-def-cubic-qoe01.txt---rmnet_data		0.164630
test-03-def-cubic-qoe02.txt---rmnet_data		79.416245
test-03-def-cubic-qoe03.txt---rmnet_data		5.305366
test-03-def-cubic-qoe07.txt---rmnet_data		5.149086
test-03-def-cubic-qoe11.txt---rmnet_data		39.793937
test-03-def-olia-qoe01.txt---rmnet_data		0.333073
test-03-def-olia-qoe02.txt---rmnet_data		78.205992
test-03-def-olia-qoe03.txt---rmnet_data		17.634738
test-03-def-olia-qoe07.txt---rmnet_data		47.418006
test-03-def-olia-qoe11.txt---rmnet_data		43.657038
test-03-qms-qcc-qoe01.txt---rmnet_data		0.161820
test-03-qms-qcc-qoe02.txt---rmnet_data		58.852550
test-03-qms-qcc-qoe03.txt---rmnet_data		25.099437
test-03-qms-qcc-qoe07.txt---rmnet_data		28.266852
test-03-qms-qcc-qoe11.txt---rmnet_data		27.891181
test-04-def-cubic-qoe03-0.10.txt---rmnet_data		63.298483
test-04-def-cubic-qoe03-0.20.txt---rmnet_data		94.172110
test-04-def-cubic-qoe03-0.30.txt---rmnet_data		112.940659
test-04-def-cubic-qoe03-0.40.txt---rmnet_data		122.788764
test-04-def-cubic-qoe03-0.50.txt---rmnet_data		138.962013
test-04-def-cubic-qoe03-0.60.txt---rmnet_data		157.925385
test-04-def-olia-qoe03-0.10.txt---rmnet_data		121.739407
test-04-def-olia-qoe03-0.20.txt---rmnet_data		169.721161
test-04-def-olia-qoe03-0.30.txt---rmnet_data		222.424743
test-04-def-olia-qoe03-0.40.txt---rmnet_data		258.679619
test-04-def-olia-qoe03-0.50.txt---rmnet_data		264.130100
test-04-def-olia-qoe03-0.60.txt---rmnet_data		256.513741
test-04-qms-qcc-qoe03-0.10.txt---rmnet_data		51.696875
test-04-qms-qcc-qoe03-0.20.txt---rmnet_data		62.656830
test-04-qms-qcc-qoe03-0.30.txt---rmnet_data		71.440443
test-04-qms-qcc-qoe03-0.40.txt---rmnet_data		87.408521
test-04-qms-qcc-qoe03-0.50.txt---rmnet_data		97.562183
test-04-qms-qcc-qoe03-0.60.txt---rmnet_data		121.368184
test-04-qms-qcc-qoe07-0.10.txt---rmnet_data		52.866042
test-04-qms-qcc-qoe07-0.20.txt---rmnet_data		31.490770
test-04-qms-qcc-qoe07-0.30.txt---rmnet_data		71.592877
test-04-qms-qcc-qoe07-0.40.txt---rmnet_data		97.534331
test-04-qms-qcc-qoe07-0.50.txt---rmnet_data		93.566708
test-04-qms-qcc-qoe07-0.60.txt---rmnet_data		121.759146
test-04-qms-qcc-qoe11-0.10.txt---rmnet_data		52.454292
test-04-qms-qcc-qoe11-0.20.txt---rmnet_data		69.670787
test-04-qms-qcc-qoe11-0.30.txt---rmnet_data		92.978801
test-04-qms-qcc-qoe11-0.40.txt---rmnet_data		91.299030
test-04-qms-qcc-qoe11-0.50.txt---rmnet_data		100.109529
test-04-qms-qcc-qoe11-0.60.txt---rmnet_data		129.937873
#----------------------------------------------------------
# 整理 作图用 数据 (time, 即：传输时间) 为 dat 文件，用于 plot

test-01-def-cubic-qoe01.txt---wlan0		337.704775	1.492032
test-01-def-olia-qoe01.txt---wlan0		354.140469	0.771159
test-01-qms-qcc-qoe01.txt---wlan0		282.521784	1.424398

test-01-def-cubic-qoe02.txt---wlan0		1.413061	474.965124
test-01-def-olia-qoe02.txt---wlan0		1.400981	491.882590
test-01-qms-qcc-qoe02.txt---wlan0		1.649363	427.790590

test-01-def-cubic-qoe03.txt---wlan0		354.783434	354.511672
test-01-def-olia-qoe03.txt---wlan0		376.553177	376.618821
test-01-qms-qcc-qoe03.txt---wlan0		262.552756	120.875606

test-01-def-cubic-qoe07.txt---wlan0		317.989985	317.758200
test-01-def-olia-qoe07.txt---wlan0		379.922086	379.922305
test-01-qms-qcc-qoe07.txt---wlan0		276.668866	180.977960

test-01-def-cubic-qoe11.txt---wlan0		332.674780	332.650146
test-01-def-olia-qoe11.txt---wlan0		386.521133	321.159693
test-01-qms-qcc-qoe11.txt---wlan0		267.042209	132.768153



test-02-def-cubic-qoe03-0.10.txt---wlan0		408.670322	408.772418
test-02-def-olia-qoe03-0.10.txt---wlan0		435.684766	433.712034
test-02-qms-qcc-qoe03-0.10.txt---wlan0		334.122397	334.143884
test-02-qms-qcc-qoe07-0.10.txt---wlan0		342.723969	342.723696
test-02-qms-qcc-qoe11-0.10.txt---wlan0		324.968195	283.399181

test-02-def-cubic-qoe03-0.20.txt---wlan0		485.434248	485.765619
test-02-def-olia-qoe03-0.20.txt---wlan0		571.822552	571.408869
test-02-qms-qcc-qoe03-0.20.txt---wlan0		398.941819	396.135091
test-02-qms-qcc-qoe07-0.20.txt---wlan0		391.759456	391.489547
test-02-qms-qcc-qoe11-0.20.txt---wlan0		393.669462	393.391584

test-02-def-cubic-qoe03-0.30.txt---wlan0		581.869309	581.561022
test-02-def-olia-qoe03-0.30.txt---wlan0		687.652746	687.452439
test-02-qms-qcc-qoe03-0.30.txt---wlan0		452.193748	452.026434
test-02-qms-qcc-qoe07-0.30.txt---wlan0		454.134187	453.873968
test-02-qms-qcc-qoe11-0.30.txt---wlan0		436.176339	436.087514

test-02-def-cubic-qoe03-0.40.txt---wlan0		644.565641	644.040484
test-02-def-olia-qoe03-0.40.txt---wlan0		805.012315	804.776099
test-02-qms-qcc-qoe03-0.40.txt---wlan0		508.235904	508.519824
test-02-qms-qcc-qoe07-0.40.txt---wlan0		497.586801	497.593288
test-02-qms-qcc-qoe11-0.40.txt---wlan0		489.080190	489.148073

test-02-def-cubic-qoe03-0.50.txt---wlan0		722.189982	722.154958
test-02-def-olia-qoe03-0.50.txt---wlan0		1008.690637	1008.984713
test-02-qms-qcc-qoe03-0.50.txt---wlan0		592.318124	591.995212
test-02-qms-qcc-qoe07-0.50.txt---wlan0		581.959150	582.252541
test-02-qms-qcc-qoe11-0.50.txt---wlan0		540.962250	540.987712

test-02-def-cubic-qoe03-0.60.txt---wlan0		818.890561	819.118034
test-02-def-olia-qoe03-0.60.txt---wlan0		1292.133057	1292.209821
test-02-qms-qcc-qoe03-0.60.txt---wlan0		633.419268	633.545052
test-02-qms-qcc-qoe07-0.60.txt---wlan0		613.878753	614.023608
test-02-qms-qcc-qoe11-0.60.txt---wlan0		596.352601	595.951398



test-03-def-cubic-qoe01.txt---wlan0		38.908650	0.164630
test-03-def-olia-qoe01.txt---wlan0		48.896790	0.333073
test-03-qms-qcc-qoe01.txt---wlan0		31.217957	0.161820

test-03-def-cubic-qoe02.txt---wlan0		2.684202	79.416245
test-03-def-olia-qoe02.txt---wlan0		0.604357	78.205992
test-03-qms-qcc-qoe02.txt---wlan0		0.573039	58.852550

test-03-def-cubic-qoe03.txt---wlan0		39.741682	5.305366
test-03-def-olia-qoe03.txt---wlan0		53.018218	17.634738
test-03-qms-qcc-qoe03.txt---wlan0		25.038942	25.099437

test-03-def-cubic-qoe07.txt---wlan0		38.937466	5.149086
test-03-def-olia-qoe07.txt---wlan0		47.390487	47.418006
test-03-qms-qcc-qoe07.txt---wlan0		28.211363	28.266852

test-03-def-cubic-qoe11.txt---wlan0		39.731484	39.793937
test-03-def-olia-qoe11.txt---wlan0		53.895364	43.657038
test-03-qms-qcc-qoe11.txt---wlan0		28.151761	27.891181



test-04-def-cubic-qoe03-0.10.txt---wlan0		63.213469	63.298483
test-04-def-olia-qoe03-0.10.txt---wlan0		121.901565	121.739407
test-04-qms-qcc-qoe03-0.10.txt---wlan0		51.657032	51.696875
test-04-qms-qcc-qoe07-0.10.txt---wlan0		52.782262	52.866042
test-04-qms-qcc-qoe11-0.10.txt---wlan0		52.681857	52.454292

test-04-def-cubic-qoe03-0.20.txt---wlan0		94.122301	94.172110
test-04-def-olia-qoe03-0.20.txt---wlan0		169.648608	169.721161
test-04-qms-qcc-qoe03-0.20.txt---wlan0		62.598908	62.656830
test-04-qms-qcc-qoe07-0.20.txt---wlan0		72.828695	31.490770
test-04-qms-qcc-qoe11-0.20.txt---wlan0		69.841362	69.670787

test-04-def-cubic-qoe03-0.30.txt---wlan0		112.878822	112.940659
test-04-def-olia-qoe03-0.30.txt---wlan0		222.350333	222.424743
test-04-qms-qcc-qoe03-0.30.txt---wlan0		71.650945	71.440443
test-04-qms-qcc-qoe07-0.30.txt---wlan0		71.778051	71.592877
test-04-qms-qcc-qoe11-0.30.txt---wlan0		92.908024	92.978801

test-04-def-cubic-qoe03-0.40.txt---wlan0		122.824660	122.788764
test-04-def-olia-qoe03-0.40.txt---wlan0		258.599691	258.679619
test-04-qms-qcc-qoe03-0.40.txt---wlan0		87.333616	87.408521
test-04-qms-qcc-qoe07-0.40.txt---wlan0		97.456588	97.534331
test-04-qms-qcc-qoe11-0.40.txt---wlan0		91.239326	91.299030

test-04-def-cubic-qoe03-0.50.txt---wlan0		139.155534	138.962013
test-04-def-olia-qoe03-0.50.txt---wlan0		265.232434	264.130100
test-04-qms-qcc-qoe03-0.50.txt---wlan0		97.482335	97.562183
test-04-qms-qcc-qoe07-0.50.txt---wlan0		93.682915	93.566708
test-04-qms-qcc-qoe11-0.50.txt---wlan0		100.036924	100.109529

test-04-def-cubic-qoe03-0.60.txt---wlan0		157.954220	157.925385
test-04-def-olia-qoe03-0.60.txt---wlan0		291.647730	256.513741
test-04-qms-qcc-qoe03-0.60.txt---wlan0		121.282823	121.368184
test-04-qms-qcc-qoe07-0.60.txt---wlan0		121.735123	121.759146
test-04-qms-qcc-qoe11-0.60.txt---wlan0		129.865225	129.937873
#----------------------------------------------------------



##################################################
#
# Processing raw data: count the number of drivers, their size, and the number of files in a certain range. For table
#
##################################################


cd /root/paper2-send-data/
find drivers -type f | wc -l					# 4749 files
find drivers -type f -exec ls -l {} \; > files.txt
sort -n -k 5 files.txt						# Sort by size
sort -n -k 5 files.txt | cut -d' ' -f5 > files2.txt

<=1000			471		(0, 1000]
<=2000			670		(1000, 2000]
<=3000			423		(2000, 3000]
<=4000			369		(3000, 4000]
<=5000			258		(4000, 5000]
<=6000			234		(5000, 6000]
<=7000			172		(6000, 7000]
<=8000			178		(7000, 8000]
<=9000			141		(8000, 9000]
<=10000			125		(9000, 10000]
<=15000			494		(10000, 15000]
<=20000			277		(15000, 20000]
<=25000			187		(20000, 25000]
<=30000			159		(25000, 30000]
<=50000			244		(30000, 50000]
<=100000		197		(50000, 100000]
<=1000000		129		(100000, 1000000]
<=2000000		12		(1000000, 2000000]
<=3000000		2		(2000000, 3000000]
<=4000000		3		(3000000, 4000000]
5751106			1		(, ]
6831048			1		(, ]
12745358		1		(, ]
14151474		1		(, ]


