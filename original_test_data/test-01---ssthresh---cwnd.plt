# dnf install gnuplot

# /bin/cp /opt/note/paper/xxu/paper/paper-2/gnuplot/test-01---ssthresh---cwnd.plt /root/文档/paper2---original--test--data---20210729---OK/
# /bin/cp /opt/note/paper/xxu/paper/paper-2/gnuplot/test-01---ssthresh---cwnd.plt /mnt/hdd/data/新乡学院/paper/paper-2---testing---results---20210729/paper2---original--test--data---20210729---OK

# cd /root/文档/paper2---original--test--data---20210729---OK/
# cd /mnt/hdd/data/新乡学院/paper/paper-2---testing---results---20210729/paper2---original--test--data---20210729---OK

# gnuplot < test-01---ssthresh---cwnd.plt  > test-01---ssthresh---cwnd.png
# eog     test-01---ssthresh---cwnd.png &
# display test-01---ssthresh---cwnd.png &

reset
set terminal png font "times new roman" size 600,1000

# set tmargin 2
# set bmargin 2
# set lmargin 1
# set rmargin 1

if (!exists("MP_LEFT"))   MP_LEFT = .08
if (!exists("MP_RIGHT"))  MP_RIGHT = .99
if (!exists("MP_TOP"))    MP_TOP = .98
if (!exists("MP_BOTTOM")) MP_BOTTOM = .04
if (!exists("MP_GAP"))    MP_GAP = 0.03

# set multiplot layout 6,3
# set multiplot layout 6,3 rowsfirst title "{/:Bold=12 Multiplot with explicit page margins}"
set multiplot layout 6,1 rowsfirst margins screen MP_LEFT, MP_RIGHT, MP_BOTTOM, MP_TOP spacing screen MP_GAP

# set label 1 at  2,1.2  'e-ssthresh'
# set arrow from 1,0.211261 to 186,0.211261  nohead front ls 10 lt 0 lc "green"


set xrange [0:420]
set xtics 0,60,420
set mxtics 5
# set xtics ('' 0, '' 60, '' 120, '' 180, '' 240, '' 300, '' 360, '' 420)
set yrange [0:1000]
set ytics 0,100,1000
set mytics 4
# set title "def-cubic-qoe00"
set label 1 at 5,70 "def-cubic-qoe00"
plot \
     "test-01-def-cubic-qoe00.txt---wlan0" using 1:2 with lines lw 1 lt 3 lc "dark-cyan" title '', \
     "test-01-def-cubic-qoe00.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "cyan" title '', \
\
     "test-01-def-cubic-qoe00.txt---rmnet_data" using 1:2 with lines lw 1 lt 3 lc "dark-yellow" title '', \
     "test-01-def-cubic-qoe00.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "yellow" title '', \
\
     "test-01-def-olia-qoe00.txt---wlan0" using 1:2 with lines lw 1 lt 3 lc "dark-green" title '', \
     "test-01-def-olia-qoe00.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-01-def-olia-qoe00.txt---rmnet_data" using 1:2 with lines lw 1 lt 3 lc "dark-goldenrod" title '', \
     "test-01-def-olia-qoe00.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "goldenrod" title '', \
\
     "test-01-qms-qcc-qoe00.txt---wlan0" using 1:2 with lines lw 1 lt 3 lc "dark-red" title '', \
     "test-01-qms-qcc-qoe00.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-01-qms-qcc-qoe00.txt---rmnet_data" using 1:2 with lines lw 1 lt 3 lc "dark-blue" title '', \
     "test-01-qms-qcc-qoe00.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "blue" title ''


set xrange [0:360]
set xtics 0,60,360
set mxtics 5
# set xtics ('' 0, '' 60, '' 120, '' 180, '' 240, '' 300, '' 360)
set yrange [0:800]
set ytics 0,100,800
set mytics 4
# set title "def-cubic-qoe01"
set label 1 at 5,70 "def-cubic-qoe01"
plot \
     "test-01-def-cubic-qoe01.txt---wlan0" using 1:2 with lines lw 1 lt 3 lc "dark-cyan" title '', \
     "test-01-def-cubic-qoe01.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "cyan" title '', \
\
     "test-01-def-cubic-qoe01.txt---rmnet_data" using 1:2 with lines lw 1 lt 3 lc "dark-yellow" title '', \
     "test-01-def-cubic-qoe01.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "yellow" title '', \
\
     "test-01-def-olia-qoe01.txt---wlan0" using 1:2 with lines lw 1 lt 3 lc "dark-green" title '', \
     "test-01-def-olia-qoe01.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-01-def-olia-qoe01.txt---rmnet_data" using 1:2 with lines lw 1 lt 3 lc "dark-goldenrod" title '', \
     "test-01-def-olia-qoe01.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "goldenrod" title '', \
\
     "test-01-qms-qcc-qoe01.txt---wlan0" using 1:2 with lines lw 1 lt 3 lc "dark-red" title '', \
     "test-01-qms-qcc-qoe01.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-01-qms-qcc-qoe01.txt---rmnet_data" using 1:2 with lines lw 1 lt 3 lc "dark-blue" title '', \
     "test-01-qms-qcc-qoe01.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "blue" title ''


set xrange [0:500]
set xtics 0,60,500
set mxtics 5
# set xtics ('' 0, '' 60, '' 120, '' 180, '' 240, '' 300, '' 360)
set yrange [0:800]
set ytics 0,100,800
set mytics 4
# set title "def-cubic-qoe02"
set label 1 at 5,70 "def-cubic-qoe02"
plot \
     "test-01-def-cubic-qoe02.txt---wlan0" using 1:2 with lines lw 1 lt 3 lc "dark-cyan" title '', \
     "test-01-def-cubic-qoe02.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "cyan" title '', \
\
     "test-01-def-cubic-qoe02.txt---rmnet_data" using 1:2 with lines lw 1 lt 3 lc "dark-yellow" title '', \
     "test-01-def-cubic-qoe02.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "yellow" title '', \
\
     "test-01-def-olia-qoe02.txt---wlan0" using 1:2 with lines lw 1 lt 3 lc "dark-green" title '', \
     "test-01-def-olia-qoe02.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-01-def-olia-qoe02.txt---rmnet_data" using 1:2 with lines lw 1 lt 3 lc "dark-goldenrod" title '', \
     "test-01-def-olia-qoe02.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "goldenrod" title '', \
\
     "test-01-qms-qcc-qoe02.txt---wlan0" using 1:2 with lines lw 1 lt 3 lc "dark-red" title '', \
     "test-01-qms-qcc-qoe02.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-01-qms-qcc-qoe02.txt---rmnet_data" using 1:2 with lines lw 1 lt 3 lc "dark-blue" title '', \
     "test-01-qms-qcc-qoe02.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "blue" title ''


set xrange [0:380]
set xtics 0,60,380
set mxtics 5
# set xtics ('' 0, '' 60, '' 120, '' 180, '' 240, '' 300, '' 360)
set yrange [0:820]
set ytics 0,100,820
set mytics 4
# set title "def-cubic-qoe03"
set label 1 at 5,70 "def-cubic-qoe03"
plot \
     "test-01-def-cubic-qoe03.txt---wlan0" using 1:2 with lines lw 1 lt 3 lc "dark-cyan" title '', \
     "test-01-def-cubic-qoe03.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "cyan" title '', \
\
     "test-01-def-cubic-qoe03.txt---rmnet_data" using 1:2 with lines lw 1 lt 3 lc "dark-yellow" title '', \
     "test-01-def-cubic-qoe03.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "yellow" title '', \
\
     "test-01-def-olia-qoe03.txt---wlan0" using 1:2 with lines lw 1 lt 3 lc "dark-green" title '', \
     "test-01-def-olia-qoe03.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-01-def-olia-qoe03.txt---rmnet_data" using 1:2 with lines lw 1 lt 3 lc "dark-goldenrod" title '', \
     "test-01-def-olia-qoe03.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "goldenrod" title '', \
\
     "test-01-qms-qcc-qoe03.txt---wlan0" using 1:2 with lines lw 1 lt 3 lc "dark-red" title '', \
     "test-01-qms-qcc-qoe03.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-01-qms-qcc-qoe03.txt---rmnet_data" using 1:2 with lines lw 1 lt 3 lc "dark-blue" title '', \
     "test-01-qms-qcc-qoe03.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "blue" title ''


set xrange [0:380]
set xtics 0,60,380
set mxtics 5
# set xtics ('' 0, '' 60, '' 120, '' 180, '' 240, '' 300, '' 360)
set yrange [0:820]
set ytics 0,100,820
set mytics 4
# set title "def-cubic-qoe07"
set label 1 at 5,70 "def-cubic-qoe07"
plot \
     "test-01-def-cubic-qoe07.txt---wlan0" using 1:2 with lines lw 1 lt 3 lc "dark-cyan" title '', \
     "test-01-def-cubic-qoe07.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "cyan" title '', \
\
     "test-01-def-cubic-qoe07.txt---rmnet_data" using 1:2 with lines lw 1 lt 3 lc "dark-yellow" title '', \
     "test-01-def-cubic-qoe07.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "yellow" title '', \
\
     "test-01-def-olia-qoe07.txt---wlan0" using 1:2 with lines lw 1 lt 3 lc "dark-green" title '', \
     "test-01-def-olia-qoe07.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-01-def-olia-qoe07.txt---rmnet_data" using 1:2 with lines lw 1 lt 3 lc "dark-goldenrod" title '', \
     "test-01-def-olia-qoe07.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "goldenrod" title '', \
\
     "test-01-qms-qcc-qoe07.txt---wlan0" using 1:2 with lines lw 1 lt 3 lc "dark-red" title '', \
     "test-01-qms-qcc-qoe07.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-01-qms-qcc-qoe07.txt---rmnet_data" using 1:2 with lines lw 1 lt 3 lc "dark-blue" title '', \
     "test-01-qms-qcc-qoe07.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "blue" title ''


set xrange [0:390]
set xtics 0,60,390
set mxtics 5
# set xtics ('' 0, '' 60, '' 120, '' 180, '' 240, '' 300, '' 360)
set yrange [0:880]
set ytics 0,100,880
set mytics 4
# set title "def-cubic-qoe11"
set label 1 at 5,70 "def-cubic-qoe11"
plot \
     "test-01-def-cubic-qoe11.txt---wlan0" using 1:2 with lines lw 1 lt 3 lc "dark-cyan" title '', \
     "test-01-def-cubic-qoe11.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "cyan" title '', \
\
     "test-01-def-cubic-qoe11.txt---rmnet_data" using 1:2 with lines lw 1 lt 3 lc "dark-yellow" title '', \
     "test-01-def-cubic-qoe11.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "yellow" title '', \
\
     "test-01-def-olia-qoe11.txt---wlan0" using 1:2 with lines lw 1 lt 3 lc "dark-green" title '', \
     "test-01-def-olia-qoe11.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-01-def-olia-qoe11.txt---rmnet_data" using 1:2 with lines lw 1 lt 3 lc "dark-goldenrod" title '', \
     "test-01-def-olia-qoe11.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "goldenrod" title '', \
\
     "test-01-qms-qcc-qoe11.txt---wlan0" using 1:2 with lines lw 1 lt 3 lc "dark-red" title '', \
     "test-01-qms-qcc-qoe11.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-01-qms-qcc-qoe11.txt---rmnet_data" using 1:2 with lines lw 1 lt 3 lc "dark-blue" title '', \
     "test-01-qms-qcc-qoe11.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "blue" title ''


# using 1:2 with lines lw 1 lt 3 lc "blue" title 'hosta'
# linestyle   连线风格（包括linetype，linewidth等）
# linetype     连线种类
# linewidth   连线粗细
# linecolor   连线颜色
# pointtype   点的种类
# pointsize   点的大小


