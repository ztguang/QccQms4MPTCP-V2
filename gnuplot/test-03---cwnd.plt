# dnf install gnuplot

# /bin/cp /opt/note/paper/xxu/paper/paper-2/gnuplot/test-03---cwnd.plt /root/文档/paper2---original--test--data---20210729---OK/
# /bin/cp /opt/note/paper/xxu/paper/paper-2/gnuplot/test-03---cwnd.plt /mnt/hdd/data/新乡学院/paper/paper-2---testing---results---20210729/paper2---original--test--data---20210729---OK

# cd /root/文档/paper2---original--test--data---20210729---OK/
# cd /mnt/hdd/data/新乡学院/paper/paper-2---testing---results---20210729/paper2---original--test--data---20210729---OK

# gnuplot < test-03---cwnd.plt  > test-03---cwnd.png
# eog     test-03---cwnd.png &
# display test-03---cwnd.png &

# /bin/cp test-0*cwnd.png /opt/note/paper/xxu/paper/paper-2/gnuplot && /bin/cp test-0*cwnd.png /root/图片

reset
set terminal png font "times new roman" size 600,720

# set tmargin 2
# set bmargin 2
# set lmargin 1
# set rmargin 1

if (!exists("MP_LEFT"))   MP_LEFT = .123
if (!exists("MP_RIGHT"))  MP_RIGHT = .99
if (!exists("MP_TOP"))    MP_TOP = .99
if (!exists("MP_BOTTOM")) MP_BOTTOM = .058
if (!exists("MP_GAP"))    MP_GAP = 0.026

# set multiplot layout 6,3
# set multiplot layout 6,3 rowsfirst title "{/:Bold=12 Multiplot with explicit page margins}"
set multiplot layout 5,1 rowsfirst margins screen MP_LEFT, MP_RIGHT, MP_BOTTOM, MP_TOP spacing screen MP_GAP

# set label 1 at  2,1.2  'e-ssthresh'
# set arrow from 1,0.211261 to 186,0.211261  nohead front ls 10 lt 0 lc "green"


set xrange [0:51]
set xtics 0,10,51
set mxtics 5
# set xtics ('' 0, '' 10, '' 20, '' 30, '' 40, '' 50)
set yrange [0:1420]
set ytics 0,200,1420
set mytics 5
# set title "def-cubic-qoe01"
set label 1 at 44,200 "qoe=1" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 38.908650,1400 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 0.164630,10 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 48.896790,444 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 0.333073,10 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 31.217957,886 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 0.161820,10 point pt 7 ps 1.5 lc rgb "dark-green"

set arrow from 38.908650,0 to 38.908650,1400  nohead front lw 2 lt 0 lc "red"
set arrow from 0.164630,0 to 0.164630,10  nohead front lw 2 lt 0 lc "dark-red"
set arrow from 48.896790,0 to 48.896790,444  nohead front lw 2 lt 0 lc "blue"
set arrow from 0.333073,0 to 0.333073,10  nohead front lw 2 lt 0 lc "dark-blue"
set arrow from 31.217957,0 to 31.217957,886  nohead front lw 2 lt 0 lc "green"
set arrow from 0.161820,0 to 0.161820,10  nohead front lw 2 lt 0 lc "dark-green"

plot \
     "test-03-def-cubic-qoe01.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-03-def-cubic-qoe01.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-red" title '', \
\
     "test-03-def-olia-qoe01.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "blue" title '', \
\
     "test-03-def-olia-qoe01.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title '', \
\
     "test-03-qms-qcc-qoe01.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-03-qms-qcc-qoe01.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-green" title ''


unset label
unset arrow
# unset ylabel
set xrange [0:81]
set xtics 0,10,81
set mxtics 5
# set xtics ('' 0, '' 10, '' 20, '' 30, '' 40, '' 50, '' 60, '' 70, '' 80)
set yrange [0:1420]
set ytics 0,200,1420
set mytics 5
# set title "def-cubic-qoe02"

set label 12 at 48.1,932 point pt 11 ps 1.3 lc rgb "red"
set label 13 at 48.1,780 point pt 11 ps 1.3 lc rgb "dark-red"
set label 14 at 48.1,611 point pt 9 ps 1.3 lc rgb "blue"
set label 15 at 48.1,460 point pt 9 ps 1.3 lc rgb "dark-blue"
set label 16 at 48.1,317 point pt 7 ps 1.3 lc rgb "green"
set label 17 at 48.1,160 point pt 7 ps 1.3 lc rgb "dark-green"

set label 1 at 70,200 "qoe=2" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 2.684202,101 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 79.416245,1291 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 0.604357,177 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 78.205992,1036 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 0.573039,333 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 58.852550,1058 point pt 7 ps 1.5 lc rgb "dark-green"

set arrow from 2.684202,0 to 2.684202,101  nohead front lw 2 lt 0 lc "red"
set arrow from 79.416245,0 to 79.416245,1291  nohead front lw 2 lt 0 lc "dark-red"
set arrow from 0.604357,0 to 0.604357,177  nohead front lw 2 lt 0 lc "blue"
set arrow from 78.205992,0 to 78.205992,1036  nohead front lw 2 lt 0 lc "dark-blue"
set arrow from 0.573039,0 to 0.573039,333  nohead front lw 2 lt 0 lc "green"
set arrow from 58.852550,0 to 58.852550,1058  nohead front lw 2 lt 0 lc "dark-green"

set key spacing 0.99 font ",12" at 20,46 bottom left samplen 5		# Increasing the value of <some number> should increase the distance between titles.
plot \
     "test-03-def-cubic-qoe02.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "red" title 'def-cubic--wifi', \
\
     "test-03-def-cubic-qoe02.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-red" title 'def-cubic--4g', \
\
     "test-03-def-olia-qoe02.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "blue" title 'def-olia--wifi', \
\
     "test-03-def-olia-qoe02.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title 'def-olia--4g', \
\
     "test-03-qms-qcc-qoe02.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "green" title 'qms-qcc--wifi', \
\
     "test-03-qms-qcc-qoe02.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-green" title 'qms-qcc--4g'


set ylabel offset 0,0 "The congestion window size (cwnd)"
unset label
unset arrow
# unset ylabel
set xrange [0:54]
set xtics 0,10,54
set mxtics 5
# set xtics ('' 0, '' 10, '' 20, '' 30, '' 40, '' 50)
set yrange [0:1420]
set ytics 0,200,1420
set mytics 5
# set title "def-cubic-qoe03"
set label 1 at 47,200 "qoe=3" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 39.741682,1400 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 5.305366,628 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 53.018218,446 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 17.634738,928 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 25.038942,187 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 25.099437,220 point pt 7 ps 1.5 lc rgb "dark-green"

set arrow from 39.741682,0 to 39.741682,1400  nohead front lw 2 lt 0 lc "red"
set arrow from 5.305366,0 to 5.305366,628  nohead front lw 2 lt 0 lc "dark-red"
set arrow from 53.018218,0 to 53.018218,446  nohead front lw 2 lt 0 lc "blue"
set arrow from 17.634738,0 to 17.634738,928  nohead front lw 2 lt 0 lc "dark-blue"
set arrow from 25.038942,0 to 25.038942,187  nohead front lw 2 lt 0 lc "green"
set arrow from 25.099437,0 to 25.099437,220  nohead front lw 2 lt 0 lc "dark-green"

plot \
     "test-03-def-cubic-qoe03.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-03-def-cubic-qoe03.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-red" title '', \
\
     "test-03-def-olia-qoe03.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "blue" title '', \
\
     "test-03-def-olia-qoe03.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title '', \
\
     "test-03-qms-qcc-qoe03.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-03-qms-qcc-qoe03.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-green" title ''


unset label
unset arrow
unset ylabel
set xrange [0:48]
set xtics 0,10,48
set mxtics 5
# set xtics ('' 0, '' 10, '' 20, '' 30, '' 40)
set yrange [0:1420]
set ytics 0,200,1420
set mytics 5
# set title "def-cubic-qoe07"
set label 1 at 42,200 "qoe=7" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 38.937466,1061 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 5.149086,229 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 13.143308,320 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 47.418006,888 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 28.211363,265 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 28.266852,341 point pt 7 ps 1.5 lc rgb "dark-green"

set arrow from 38.937466,0 to 38.937466,1061  nohead front lw 2 lt 0 lc "red"
set arrow from 5.149086,0 to 5.149086,229  nohead front lw 2 lt 0 lc "dark-red"
set arrow from 13.143308,0 to 13.143308,320  nohead front lw 2 lt 0 lc "blue"
set arrow from 47.418006,0 to 47.418006,888  nohead front lw 2 lt 0 lc "dark-blue"
set arrow from 28.211363,0 to 28.211363,265  nohead front lw 2 lt 0 lc "green"
set arrow from 28.266852,0 to 28.266852,341  nohead front lw 2 lt 0 lc "dark-green"

plot \
     "test-03-def-cubic-qoe07.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-03-def-cubic-qoe07.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-red" title '', \
\
     "test-03-def-olia-qoe07.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "blue" title '', \
\
     "test-03-def-olia-qoe07.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title '', \
\
     "test-03-qms-qcc-qoe07.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-03-qms-qcc-qoe07.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-green" title ''


set xlabel offset 0,0 "Data transmission time (seconds)"
unset label
unset arrow
unset ylabel
set xrange [0:55]
set xtics 0,10,55
set mxtics 5
# set xtics ('' 0, '' 10, '' 20, '' 30, '' 40, '' 50)
set yrange [0:1420]
set ytics 0,200,1420
set mytics 5
# set title "def-cubic-qoe11"
set label 1 at 47,200 "qoe=11" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 39.731484,889 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 5.917541,886 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 53.895364,887 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 43.657038,895 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 28.151761,394 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 27.891181,365 point pt 7 ps 1.5 lc rgb "dark-green"

set arrow from 39.731484,0 to 39.731484,889  nohead front lw 2 lt 0 lc "red"
set arrow from 5.917541,0 to 5.917541,886  nohead front lw 2 lt 0 lc "dark-red"
set arrow from 53.895364,0 to 53.895364,887  nohead front lw 2 lt 0 lc "blue"
set arrow from 43.657038,0 to 43.657038,895  nohead front lw 2 lt 0 lc "dark-blue"
set arrow from 28.151761,0 to 28.151761,394  nohead front lw 2 lt 0 lc "green"
set arrow from 27.891181,0 to 27.891181,365  nohead front lw 2 lt 0 lc "dark-green"

plot \
     "test-03-def-cubic-qoe11.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-03-def-cubic-qoe11.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-red" title '', \
\
     "test-03-def-olia-qoe11.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "blue" title '', \
\
     "test-03-def-olia-qoe11.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title '', \
\
     "test-03-qms-qcc-qoe11.txt---wlan0" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-03-qms-qcc-qoe11.txt---rmnet_data" using 1:3 with lines lw 1 lt 3 lc "dark-green" title ''


# using 1:2 with lines lw 1 lt 3 lc "blue" title 'hosta'
# linestyle   连线风格（包括linetype，linewidth等）
# linetype     连线种类
# linewidth   连线粗细
# linecolor   连线颜色
# pointtype   点的种类
# pointsize   点的大小


