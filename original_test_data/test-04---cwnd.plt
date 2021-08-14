# dnf install gnuplot

# /bin/cp /opt/note/paper/xxu/paper/paper-2/gnuplot/test-04---cwnd.plt /root/文档/paper2---original--test--data---20210729---OK/
# /bin/cp /opt/note/paper/xxu/paper/paper-2/gnuplot/test-04---cwnd.plt /mnt/hdd/data/新乡学院/paper/paper-2---testing---results---20210729/paper2---original--test--data---20210729---OK

# cd /root/文档/paper2---original--test--data---20210729---OK/
# cd /mnt/hdd/data/新乡学院/paper/paper-2---testing---results---20210729/paper2---original--test--data---20210729---OK

# gnuplot < test-04---cwnd.plt  > test-04---cwnd.png
# eog     test-04---cwnd.png &
# display test-04---cwnd.png &

# /bin/cp test-0*cwnd.png /opt/note/paper/xxu/paper/paper-2/gnuplot && /bin/cp test-0*cwnd.png /root/图片

# 由于 test-02---cwnd.plt 和 test-04---cwnd.plt 得到的图 太密集，看不清楚。因此 大量减少采样点
# awk 'NR%136==1' test-04-def-cubic-qoe03-0.10.txt---wlan0 > test-04-def-cubic-qoe03-0.10.txt---wlan0---0.x-lines

reset
set terminal png font "times new roman" size 600,1000

# set tmargin 2
# set bmargin 2
# set lmargin 1
# set rmargin 1

if (!exists("MP_LEFT"))   MP_LEFT = .11
if (!exists("MP_RIGHT"))  MP_RIGHT = .99
if (!exists("MP_TOP"))    MP_TOP = .993
if (!exists("MP_BOTTOM")) MP_BOTTOM = .046
if (!exists("MP_GAP"))    MP_GAP = 0.026

# set multiplot layout 6,3
# set multiplot layout 6,3 rowsfirst title "{/:Bold=12 Multiplot with explicit page margins}"
set multiplot layout 6,1 rowsfirst margins screen MP_LEFT, MP_RIGHT, MP_BOTTOM, MP_TOP spacing screen MP_GAP

# set label 1 at  2,1.2  'e-ssthresh'
# set arrow from 1,0.211261 to 186,0.211261  nohead front ls 10 lt 0 lc "green"


set xrange [0:122]
set xtics 0,10,122
set mxtics 5
# set xtics ('' 0, '' 60, '' 120, '' 180, '' 240, '' 300, '' 360)
set yrange [0:320]
set ytics 0,100,320
set mytics 5
# set title "def-cubic-qoe00"

set label 12 at 99,213 point pt 11 ps 1.3 lc rgb "red"
set label 13 at 99,175.6 point pt 11 ps 1.3 lc rgb "dark-red"
set label 14 at 99,133 point pt 9 ps 1.3 lc rgb "blue"
set label 15 at 99,97 point pt 9 ps 1.3 lc rgb "dark-blue"

set label 1 at 100,275 "loss=0.10" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 63.063035,54 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 63.036318,56 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 121.741213,21 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 121.739407,13 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 51.513078,52 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 51.521315,155 point pt 7 ps 1.5 lc rgb "dark-green"
set label 8 at 52.610430,102 point pt 5 ps 1.5 lc rgb "goldenrod"
set label 9 at 52.538830,98 point pt 5 ps 1.5 lc rgb "dark-goldenrod"
set label 10 at 52.403027,79 point pt 13 ps 1.5 lc rgb "violet"
set label 11 at 52.454292,41 point pt 13 ps 1.5 lc rgb "dark-violet"
set key spacing 1.1 font ",12" at 50,80 bottom left samplen 5		# Increasing the value of <some number> should increase the distance between titles.
plot \
     "test-04-def-cubic-qoe03-0.10.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "red" title 'def-cubic-qoe03-wifi', \
\
     "test-04-def-cubic-qoe03-0.10.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-red" title 'def-cubic-qoe03-4g', \
\
     "test-04-def-olia-qoe03-0.10.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "blue" title 'def-olia-qoe03-wifi', \
\
     "test-04-def-olia-qoe03-0.10.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title 'def-olia-qoe03-4g', \
\
     "test-04-qms-qcc-qoe03-0.10.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-04-qms-qcc-qoe03-0.10.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-green" title '', \
\
     "test-04-qms-qcc-qoe07-0.10.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "goldenrod" title '', \
\
     "test-04-qms-qcc-qoe07-0.10.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-goldenrod" title '', \
\
     "test-04-qms-qcc-qoe11-0.10.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "violet" title '', \
\
     "test-04-qms-qcc-qoe11-0.10.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-violet" title ''


unset label
# unset ylabel
set xrange [0:170]
set xtics 0,20,170
set mxtics 4
# set xtics ('' 0, '' 60, '' 120, '' 180, '' 240, '' 300, '' 360)
set yrange [0:200]
set ytics 0,50,200
set mytics 5
# set title "def-cubic-qoe01"

set label 16 at 138,180.6 point pt 7 ps 1.3 lc rgb "green"
set label 17 at 138,156 point pt 7 ps 1.3 lc rgb "dark-green"
set label 18 at 138,132 point pt 5 ps 1.3 lc rgb "goldenrod"
set label 19 at 138,108.6 point pt 5 ps 1.3 lc rgb "dark-goldenrod"
set label 20 at 138,85 point pt 13 ps 1.3 lc rgb "violet"
set label 21 at 138,61.6 point pt 13 ps 1.3 lc rgb "dark-violet"

set label 1 at 140,170 "loss=0.20" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 93.855519,36 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 93.834243,27 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 169.471930,6 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 169.477083,2 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 62.427969,35 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 62.433333,81 point pt 7 ps 1.5 lc rgb "dark-green"
set label 8 at 72.665538,74 point pt 5 ps 1.5 lc rgb "goldenrod"
set label 9 at 31.490770,26 point pt 5 ps 1.5 lc rgb "dark-goldenrod"
set label 10 at 69.682996,126 point pt 13 ps 1.5 lc rgb "violet"
set label 11 at 69.670787,38 point pt 13 ps 1.5 lc rgb "dark-violet"
set key spacing 1.1 font ",12" at 75,50 bottom left samplen 5		# Increasing the value of <some number> should increase the distance between titles.
plot \
     "test-04-def-cubic-qoe03-0.20.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-04-def-cubic-qoe03-0.20.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-red" title '', \
\
     "test-04-def-olia-qoe03-0.20.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "blue" title '', \
\
     "test-04-def-olia-qoe03-0.20.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title '', \
\
     "test-04-qms-qcc-qoe03-0.20.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "green" title 'qms-qcc-qoe03-wifi', \
\
     "test-04-qms-qcc-qoe03-0.20.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-green" title 'qms-qcc-qoe03-4g', \
\
     "test-04-qms-qcc-qoe07-0.20.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "goldenrod" title 'qms-qcc-qoe07-wifi', \
\
     "test-04-qms-qcc-qoe07-0.20.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-goldenrod" title 'qms-qcc-qoe07-4g', \
\
     "test-04-qms-qcc-qoe11-0.20.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "violet" title 'qms-qcc-qoe11-wifi', \
\
     "test-04-qms-qcc-qoe11-0.20.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-violet" title 'qms-qcc-qoe11-4g'


set ylabel offset 0,-5 "The congestion window size (cwnd)"
unset label
# unset ylabel
set xrange [0:225]
set xtics 0,20,225
set mxtics 4
# set xtics ('' 0, '' 60, '' 120, '' 180, '' 240, '' 300, '' 360, '' 420, '' 480)
set yrange [0:100]
set ytics 0,20,100
set mytics 2
# set title "def-cubic-qoe02"
set label 1 at 185,85 "loss=0.30" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 112.878822,7 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 112.701254,21 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 222.180143,18 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 222.179558,11 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 71.436950,40 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 71.440443,18 point pt 7 ps 1.5 lc rgb "dark-green"
set label 8 at 71.593772,32 point pt 5 ps 1.5 lc rgb "goldenrod"
set label 9 at 71.592877,42 point pt 5 ps 1.5 lc rgb "dark-goldenrod"
set label 10 at 92.786759,25 point pt 13 ps 1.5 lc rgb "violet"
set label 11 at 92.785996,22 point pt 13 ps 1.5 lc rgb "dark-violet"
plot \
     "test-04-def-cubic-qoe03-0.30.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-04-def-cubic-qoe03-0.30.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-red" title '', \
\
     "test-04-def-olia-qoe03-0.30.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "blue" title '', \
\
     "test-04-def-olia-qoe03-0.30.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title '', \
\
     "test-04-qms-qcc-qoe03-0.30.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-04-qms-qcc-qoe03-0.30.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-green" title '', \
\
     "test-04-qms-qcc-qoe07-0.30.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "goldenrod" title '', \
\
     "test-04-qms-qcc-qoe07-0.30.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-goldenrod" title '', \
\
     "test-04-qms-qcc-qoe11-0.30.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "violet" title '', \
\
     "test-04-qms-qcc-qoe11-0.30.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-violet" title ''


unset label
unset ylabel
set xrange [0:266]
set xtics 0,20,266
set mxtics 4
# set xtics ('' 0, '' 60, '' 120, '' 180, '' 240, '' 300, '' 360)
set yrange [0:100]
set ytics 0,20,100
set mytics 2
# set title "def-cubic-qoe03"
set label 1 at 220,85 "loss=0.40" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 122.789548,12 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 122.788764,19 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 258.374309,12 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 258.356157,2 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 87.160174,19 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 87.161529,40 point pt 7 ps 1.5 lc rgb "dark-green"
set label 8 at 97.279651,13 point pt 5 ps 1.5 lc rgb "goldenrod"
set label 9 at 97.280296,28 point pt 5 ps 1.5 lc rgb "dark-goldenrod"
set label 10 at 91.113753,21 point pt 13 ps 1.5 lc rgb "violet"
set label 11 at 91.107379,17 point pt 13 ps 1.5 lc rgb "dark-violet"
plot \
     "test-04-def-cubic-qoe03-0.40.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-04-def-cubic-qoe03-0.40.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-red" title '', \
\
     "test-04-def-olia-qoe03-0.40.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "blue" title '', \
\
     "test-04-def-olia-qoe03-0.40.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title '', \
\
     "test-04-qms-qcc-qoe03-0.40.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-04-qms-qcc-qoe03-0.40.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-green" title '', \
\
     "test-04-qms-qcc-qoe07-0.40.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "goldenrod" title '', \
\
     "test-04-qms-qcc-qoe07-0.40.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-goldenrod" title '', \
\
     "test-04-qms-qcc-qoe11-0.40.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "violet" title '', \
\
     "test-04-qms-qcc-qoe11-0.40.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-violet" title ''


unset label
unset ylabel
set xrange [0:266]
set xtics 0,20,266
set mxtics 4
# set xtics ('' 0, '' 60, '' 120, '' 180, '' 240, '' 300, '' 360)
set yrange [0:60]
set ytics 0,10,60
set mytics 2
# set title "def-cubic-qoe07"
set label 1 at 220,50 "loss=0.50" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 138.973157,12 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 138.962013,13 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 265.044354,11 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 264.130100,2 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 97.298481,21 point pt 7 ps 1.5 lc rgb "green"
#set label 7 at 97.306481,66 point pt 7 ps 1.5 lc rgb "dark-green"
set label 7 at 97.306481,60 point pt 7 ps 1.5 lc rgb "dark-green"
set label 8 at 93.682915,7 point pt 5 ps 1.5 lc rgb "goldenrod"
set label 9 at 93.566708,17 point pt 5 ps 1.5 lc rgb "dark-goldenrod"
set label 10 at 99.882398,10 point pt 13 ps 1.5 lc rgb "violet"
set label 11 at 99.882680,8 point pt 13 ps 1.5 lc rgb "dark-violet"
plot \
     "test-04-def-cubic-qoe03-0.50.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-04-def-cubic-qoe03-0.50.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-red" title '', \
\
     "test-04-def-olia-qoe03-0.50.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "blue" title '', \
\
     "test-04-def-olia-qoe03-0.50.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title '', \
\
     "test-04-qms-qcc-qoe03-0.50.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-04-qms-qcc-qoe03-0.50.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-green" title '', \
\
     "test-04-qms-qcc-qoe07-0.50.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "goldenrod" title '', \
\
     "test-04-qms-qcc-qoe07-0.50.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-goldenrod" title '', \
\
     "test-04-qms-qcc-qoe11-0.50.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "violet" title '', \
\
     "test-04-qms-qcc-qoe11-0.50.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-violet" title ''


set xlabel offset 0,0 "Data transmission time (seconds)"
unset label
unset ylabel
set xrange [0:306]
set xtics 0,60,306
set mxtics 6
# set xtics ('' 0, '' 60, '' 120, '' 180, '' 240, '' 300, '' 360)
set yrange [0:60]
set ytics 0,10,60
set mytics 2
# set title "def-cubic-qoe11"
set label 1 at 253,52 "loss=0.60" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 157.748948,17 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 157.742283,12 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 291.480134,16 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 256.513741,2 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 121.107683,11 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 121.116707,31 point pt 7 ps 1.5 lc rgb "dark-green"
set label 8 at 121.652816,8 point pt 5 ps 1.5 lc rgb "goldenrod"
set label 9 at 121.646018,20 point pt 5 ps 1.5 lc rgb "dark-goldenrod"
set label 10 at 129.734844,16 point pt 13 ps 1.5 lc rgb "violet"
set label 11 at 129.734132,18 point pt 13 ps 1.5 lc rgb "dark-violet"
plot \
     "test-04-def-cubic-qoe03-0.60.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-04-def-cubic-qoe03-0.60.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-red" title '', \
\
     "test-04-def-olia-qoe03-0.60.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "blue" title '', \
\
     "test-04-def-olia-qoe03-0.60.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title '', \
\
     "test-04-qms-qcc-qoe03-0.60.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-04-qms-qcc-qoe03-0.60.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-green" title '', \
\
     "test-04-qms-qcc-qoe07-0.60.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "goldenrod" title '', \
\
     "test-04-qms-qcc-qoe07-0.60.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-goldenrod" title '', \
\
     "test-04-qms-qcc-qoe11-0.60.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "violet" title '', \
\
     "test-04-qms-qcc-qoe11-0.60.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-violet" title ''


# using 1:2 with lines lw 1 lt 3 lc "blue" title 'hosta'
# linestyle   连线风格（包括linetype，linewidth等）
# linetype     连线种类
# linewidth   连线粗细
# linecolor   连线颜色
# pointtype   点的种类
# pointsize   点的大小


