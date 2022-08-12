# QccQms4MPTCP-V2
Applying MPTCP to Real Wireless Edge Networks

We are the first to propose a novel QoE-driven framework for using Android kernel MPTCP in the real world, 
which mainly includes a QoE-driven congestion controller (QCC) and a QoE-driven MPTCP scheduler (QMS).



All experiments are performed between OnePlus 8T with Android 11 and the aliyun server.

We do the following four rounds of experiments when QoE is equal to 1, 2, 3, 7 and 11 respectively. 

(1) using iperf3 to send 160 MB of data to the aliyun server; 

(2) using scp to send 160 MB of data (folder drivers) to the aliyun server; 

(3) using iperf3 to send 160 MB of data to the aliyun server at different packet loss rates;

(4) using scp to send 160 MB of data (folder drivers) to the aliyun server at different packet loss rates.

Because the files captured by tcpdump are relatively large and cannot be uploaded to GitHub, the download link is given.

# Download

link: https://pan.baidu.com/s/1UvfzEiilTJLIzi93_7ab9w

Extraction code: pnb9

## data
    All raw data files of test are listed in 'resultspaper2---original--test--data---20210729---OK'

    drivers.zip is the compressed file of folder 'drivers'

## client (smartphone)
    Flash package lineage-18.1-20210724-UNOFFICIAL-kebab.zip for OnePlus 8T

## server
    Fedora32-MPTCP.vdi for the aliyun server
