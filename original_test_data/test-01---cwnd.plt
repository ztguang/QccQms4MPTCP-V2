# dnf install gnuplot

# /bin/cp /opt/note/paper/xxu/paper/paper-2/gnuplot/test-01---cwnd.plt /root/文档/paper2---original--test--data---20210729---OK/
# /bin/cp /opt/note/paper/xxu/paper/paper-2/gnuplot/test-01---cwnd.plt /mnt/hdd/data/新乡学院/paper/paper-2---testing---results---20210729/paper2---original--test--data---20210729---OK

# cd /root/文档/paper2---original--test--data---20210729---OK/
# cd /mnt/hdd/data/新乡学院/paper/paper-2---testing---results---20210729/paper2---original--test--data---20210729---OK

# gnuplot < test-01---cwnd.plt  > test-01---cwnd.png
# eog     test-01---cwnd.png &
# display test-01---cwnd.png &

# /bin/cp test-0*cwnd.png /opt/note/paper/xxu/paper/paper-2/gnuplot && /bin/cp test-0*cwnd.png /root/图片

reset
set terminal png font "times new roman" size 600,800

# set tmargin 2
# set bmargin 2
# set lmargin 1
# set rmargin 1

if (!exists("MP_LEFT"))   MP_LEFT = .11
if (!exists("MP_RIGHT"))  MP_RIGHT = .99
if (!exists("MP_TOP"))    MP_TOP = .99
if (!exists("MP_BOTTOM")) MP_BOTTOM = .058
if (!exists("MP_GAP"))    MP_GAP = 0.026

# set multiplot layout 6,3
# set multiplot layout 6,3 rowsfirst title "{/:Bold=12 Multiplot with explicit page margins}"
set multiplot layout 5,1 rowsfirst margins screen MP_LEFT, MP_RIGHT, MP_BOTTOM, MP_TOP spacing screen MP_GAP

# set label 1 at  2,1.2  'e-ssthresh'
# set arrow from 1,0.211261 to 186,0.211261  nohead front ls 10 lt 0 lc "green"



set xrange [0:359]
set xtics 0,60,359
set mxtics 6
# set xtics ('' 0, '' 60, '' 120, '' 180, '' 240, '' 300, '' 360)
set yrange [0:800]
set ytics 0,200,800
set mytics 5
# set title "def-cubic-qoe01"
set label 1 at 20,680 "qoe=1" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 337.704775,450 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 1.492032,10 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 354.140469,32 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 0.771159,10 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 282.521784,436 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 1.424398,10 point pt 7 ps 1.5 lc rgb "dark-green"
plot \
     "test-01-def-cubic-qoe01.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-01-def-cubic-qoe01.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-red" title '', \
\
     "test-01-def-olia-qoe01.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "blue" title '', \
\
     "test-01-def-olia-qoe01.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title '', \
\
     "test-01-qms-qcc-qoe01.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-01-qms-qcc-qoe01.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-green" title ''


unset label
# unset ylabel
set xrange [0:500]
set xtics 0,60,500
set mxtics 6
# set xtics ('' 0, '' 60, '' 120, '' 180, '' 240, '' 300, '' 360, '' 420, '' 480)
set yrange [0:800]
set ytics 0,200,800
set mytics 5
# set title "def-cubic-qoe02"

set label 12 at 393,668 point pt 11 ps 1.3 lc rgb "red"
set label 13 at 393,570 point pt 11 ps 1.3 lc rgb "dark-red"
set label 14 at 393,460 point pt 9 ps 1.3 lc rgb "blue"
set label 15 at 393,360 point pt 9 ps 1.3 lc rgb "dark-blue"
set label 16 at 393,270 point pt 7 ps 1.3 lc rgb "green"
set label 17 at 393,170 point pt 7 ps 1.3 lc rgb "dark-green"

set label 1 at 20,680 "qoe=2" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 1.024515,28 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 474.965124,788 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 1.027335,28 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 491.882590,25 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 1.058780,26 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 427.790590,787 point pt 7 ps 1.5 lc rgb "dark-green"
set key spacing 1.1 font ",12" at 220,120 bottom left samplen 5		# Increasing the value of <some number> should increase the distance between titles.
plot \
     "test-01-def-cubic-qoe02.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "red" title 'def-cubic---wifi', \
\
     "test-01-def-cubic-qoe02.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-red" title 'def-cubic---4g', \
\
     "test-01-def-olia-qoe02.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "blue" title 'def-olia---wifi', \
\
     "test-01-def-olia-qoe02.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title 'def-olia---4g', \
\
     "test-01-qms-qcc-qoe02.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "green" title 'qms-qcc---wifi', \
\
     "test-01-qms-qcc-qoe02.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-green" title 'qms-qcc---4g'


set ylabel offset 0,0 "The congestion window size (cwnd)"
unset label
# unset ylabel
set xrange [0:390]
set xtics 0,60,390
set mxtics 6
# set xtics ('' 0, '' 60, '' 120, '' 180, '' 240, '' 300, '' 360)
set yrange [0:820]
set ytics 0,200,820
set mytics 5
# set title "def-cubic-qoe03"
set label 1 at 20,680 "qoe=3" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 354.783434,26 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 354.511672,17 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 376.553177,11 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 376.618821,250 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 262.552756,396 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 120.875606,236 point pt 7 ps 1.5 lc rgb "dark-green"
plot \
     "test-01-def-cubic-qoe03.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-01-def-cubic-qoe03.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-red" title '', \
\
     "test-01-def-olia-qoe03.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "blue" title '', \
\
     "test-01-def-olia-qoe03.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title '', \
\
     "test-01-qms-qcc-qoe03.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-01-qms-qcc-qoe03.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-green" title ''


unset label
unset ylabel
set xrange [0:390]
set xtics 0,60,390
set mxtics 6
# set xtics ('' 0, '' 60, '' 120, '' 180, '' 240, '' 300, '' 360)
set yrange [0:820]
set ytics 0,200,820
set mytics 5
# set title "def-cubic-qoe07"
set label 1 at 20,680 "qoe=7" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 317.989985,11 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 317.758200,34 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 379.922086,39 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 379.922305,351 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 276.668866,306 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 180.977960,391 point pt 7 ps 1.5 lc rgb "dark-green"
plot \
     "test-01-def-cubic-qoe07.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-01-def-cubic-qoe07.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-red" title '', \
\
     "test-01-def-olia-qoe07.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "blue" title '', \
\
     "test-01-def-olia-qoe07.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title '', \
\
     "test-01-qms-qcc-qoe07.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-01-qms-qcc-qoe07.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-green" title ''


set xlabel offset 0,0 "Data transmission time (seconds)"
unset label
unset ylabel
set xrange [0:390]
set xtics 0,60,390
set mxtics 6
# set xtics ('' 0, '' 60, '' 120, '' 180, '' 240, '' 300, '' 360)
set yrange [0:880]
set ytics 0,200,880
set mytics 5
# set title "def-cubic-qoe11"
set label 1 at 20,680 "qoe=11" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 332.674780,600 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 332.650146,310 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 386.521133,424 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 321.159693,317 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 267.042209,628 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 132.768153,514 point pt 7 ps 1.5 lc rgb "dark-green"
plot \
     "test-01-def-cubic-qoe11.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-01-def-cubic-qoe11.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-red" title '', \
\
     "test-01-def-olia-qoe11.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "blue" title '', \
\
     "test-01-def-olia-qoe11.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title '', \
\
     "test-01-qms-qcc-qoe11.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-01-qms-qcc-qoe11.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-green" title ''


# using 1:2 with lines lw 1 lt 3 lc "blue" title 'hosta'
# linestyle   连线风格（包括linetype，linewidth等）
# linetype     连线种类
# linewidth   连线粗细
# linecolor   连线颜色
# pointtype   点的种类
# pointsize   点的大小


