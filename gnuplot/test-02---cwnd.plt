
reset
set terminal png font "times new roman" size 600,1000

if (!exists("MP_LEFT"))   MP_LEFT = .11
if (!exists("MP_RIGHT"))  MP_RIGHT = .99
if (!exists("MP_TOP"))    MP_TOP = .99
if (!exists("MP_BOTTOM")) MP_BOTTOM = .046
if (!exists("MP_GAP"))    MP_GAP = 0.026

set multiplot layout 6,1 rowsfirst margins screen MP_LEFT, MP_RIGHT, MP_BOTTOM, MP_TOP spacing screen MP_GAP


set xrange [0:440]
set xtics 0,60,440
set mxtics 6
set yrange [0:1200]
set ytics 0,200,1200
set mytics 5
set label 1 at 20,1000 "loss=0.10" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 408.670322,30 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 408.772418,15 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 435.684766,33 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 433.712034,5 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 334.122397,453 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 334.143884,778 point pt 7 ps 1.5 lc rgb "dark-green"
set label 8 at 342.723969,946 point pt 5 ps 1.5 lc rgb "goldenrod"
set label 9 at 342.723696,557 point pt 5 ps 1.5 lc rgb "dark-goldenrod"
set label 10 at 324.968195,464 point pt 13 ps 1.5 lc rgb "violet"
set label 11 at 283.399181,741 point pt 13 ps 1.5 lc rgb "dark-violet"
plot \
     "test-02-def-cubic-qoe03-0.10.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-02-def-cubic-qoe03-0.10.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-red" title '', \
\
     "test-02-def-olia-qoe03-0.10.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "blue" title '', \
\
     "test-02-def-olia-qoe03-0.10.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title '', \
\
     "test-02-qms-qcc-qoe03-0.10.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-02-qms-qcc-qoe03-0.10.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-green" title '', \
\
     "test-02-qms-qcc-qoe07-0.10.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "goldenrod" title '', \
\
     "test-02-qms-qcc-qoe07-0.10.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-goldenrod" title '', \
\
     "test-02-qms-qcc-qoe11-0.10.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "violet" title '', \
\
     "test-02-qms-qcc-qoe11-0.10.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-violet" title ''


unset label
set xrange [0:580]
set xtics 0,60,580
set mxtics 6
set yrange [0:140]
set ytics 0,20,140
set mytics 5
set label 1 at 25,120 "loss=0.20" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 485.434248,18 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 485.765619,20 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 571.822552,12 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 571.408869,2 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 398.941819,81 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 396.135091,53 point pt 7 ps 1.5 lc rgb "dark-green"
set label 8 at 391.759456,24 point pt 5 ps 1.5 lc rgb "goldenrod"
set label 9 at 391.489547,15 point pt 5 ps 1.5 lc rgb "dark-goldenrod"
set label 10 at 393.669462,27 point pt 13 ps 1.5 lc rgb "violet"
set label 11 at 393.391584,17 point pt 13 ps 1.5 lc rgb "dark-violet"
plot \
     "test-02-def-cubic-qoe03-0.20.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-02-def-cubic-qoe03-0.20.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-red" title '', \
\
     "test-02-def-olia-qoe03-0.20.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "blue" title '', \
\
     "test-02-def-olia-qoe03-0.20.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title '', \
\
     "test-02-qms-qcc-qoe03-0.20.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-02-qms-qcc-qoe03-0.20.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-green" title '', \
\
     "test-02-qms-qcc-qoe07-0.20.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "goldenrod" title '', \
\
     "test-02-qms-qcc-qoe07-0.20.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-goldenrod" title '', \
\
     "test-02-qms-qcc-qoe11-0.20.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "violet" title '', \
\
     "test-02-qms-qcc-qoe11-0.20.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-violet" title ''


unset label
set ylabel offset 0,-5 "The congestion window size (cwnd)"
set xrange [0:690]
set xtics 0,60,690
set mxtics 6
set yrange [0:130]
set ytics 0,20,130
set mytics 5

set label 12 at 672,95 point pt 11 ps 1.3 lc rgb "red"
set label 13 at 672,79.6 point pt 11 ps 1.3 lc rgb "dark-red"
set label 14 at 672,63 point pt 9 ps 1.3 lc rgb "blue"
set label 15 at 672,47 point pt 9 ps 1.3 lc rgb "dark-blue"

set label 1 at 30,110 "loss=0.30" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 581.869309,9 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 581.561022,8 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 687.652746,8 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 687.452439,4 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 452.193748,36 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 452.026434,23 point pt 7 ps 1.5 lc rgb "dark-green"
set label 8 at 454.134187,12 point pt 5 ps 1.5 lc rgb "goldenrod"
set label 9 at 453.873968,13 point pt 5 ps 1.5 lc rgb "dark-goldenrod"
set label 10 at 436.176339,26 point pt 13 ps 1.5 lc rgb "violet"
set label 11 at 436.087514,22 point pt 13 ps 1.5 lc rgb "dark-violet"
set key spacing 1.1 font ",12" at 390,40 bottom left samplen 5
plot \
     "test-02-def-cubic-qoe03-0.30.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "red" title 'def-cubic-qoe03-wifi', \
\
     "test-02-def-cubic-qoe03-0.30.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-red" title 'def-cubic-qoe03-4g', \
\
     "test-02-def-olia-qoe03-0.30.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "blue" title 'def-olia-qoe03-wifi', \
\
     "test-02-def-olia-qoe03-0.30.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title 'def-olia-qoe03-4g', \
\
     "test-02-qms-qcc-qoe03-0.30.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-02-qms-qcc-qoe03-0.30.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-green" title '', \
\
     "test-02-qms-qcc-qoe07-0.30.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "goldenrod" title '', \
\
     "test-02-qms-qcc-qoe07-0.30.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-goldenrod" title '', \
\
     "test-02-qms-qcc-qoe11-0.30.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "violet" title '', \
\
     "test-02-qms-qcc-qoe11-0.30.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-violet" title ''


unset label
unset ylabel
set xrange [0:810]
set xtics 0,60,810
set mxtics 6
set yrange [0:70]
set ytics 0,10,70
set mytics 5

set label 16 at 788,61.6 point pt 7 ps 1.3 lc rgb "green"
set label 17 at 788,53.6 point pt 7 ps 1.3 lc rgb "dark-green"
set label 18 at 788,45 point pt 5 ps 1.3 lc rgb "goldenrod"
set label 19 at 788,37 point pt 5 ps 1.3 lc rgb "dark-goldenrod"
set label 20 at 788,28.5 point pt 13 ps 1.3 lc rgb "violet"
set label 21 at 788,20 point pt 13 ps 1.3 lc rgb "dark-violet"

set label 1 at 35,60 "loss=0.40" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 644.565641,2 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 644.040484,13 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 805.012315,8 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 804.776099,2 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 508.235904,9 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 508.519824,18 point pt 7 ps 1.5 lc rgb "dark-green"
set label 8 at 497.586801,10 point pt 5 ps 1.5 lc rgb "goldenrod"
set label 9 at 497.593288,10 point pt 5 ps 1.5 lc rgb "dark-goldenrod"
set label 10 at 489.080190,11 point pt 13 ps 1.5 lc rgb "violet"
set label 11 at 489.148073,16 point pt 13 ps 1.5 lc rgb "dark-violet"
set key spacing 1.1 font ",12" at 480,16 bottom left samplen 5
plot \
     "test-02-def-cubic-qoe03-0.40.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-02-def-cubic-qoe03-0.40.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-red" title '', \
\
     "test-02-def-olia-qoe03-0.40.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "blue" title '', \
\
     "test-02-def-olia-qoe03-0.40.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title '', \
\
     "test-02-qms-qcc-qoe03-0.40.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "green" title 'qms-qcc-qoe03-wifi', \
\
     "test-02-qms-qcc-qoe03-0.40.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-green" title 'qms-qcc-qoe03-4g', \
\
     "test-02-qms-qcc-qoe07-0.40.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "goldenrod" title 'qms-qcc-qoe07-wifi', \
\
     "test-02-qms-qcc-qoe07-0.40.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-goldenrod" title 'qms-qcc-qoe07-4g', \
\
     "test-02-qms-qcc-qoe11-0.40.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "violet" title 'qms-qcc-qoe11-wifi', \
\
     "test-02-qms-qcc-qoe11-0.40.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-violet" title 'qms-qcc-qoe11-4g'


unset label
unset ylabel
set xrange [0:1010]
set xtics 0,60,1010
set mxtics 6
set yrange [0:40]
set ytics 0,10,40
set mytics 5
set label 1 at 40,34 "loss=0.50" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 722.189982,8 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 722.154958,5 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 1008.690637,2 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 1008.984713,5 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 592.318124,10 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 591.995212,10 point pt 7 ps 1.5 lc rgb "dark-green"
set label 8 at 581.959150,13 point pt 5 ps 1.5 lc rgb "goldenrod"
set label 9 at 582.252541,17 point pt 5 ps 1.5 lc rgb "dark-goldenrod"
set label 10 at 540.962250,7 point pt 13 ps 1.5 lc rgb "violet"
set label 11 at 540.987712,6 point pt 13 ps 1.5 lc rgb "dark-violet"
plot \
     "test-02-def-cubic-qoe03-0.50.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-02-def-cubic-qoe03-0.50.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-red" title '', \
\
     "test-02-def-olia-qoe03-0.50.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "blue" title '', \
\
     "test-02-def-olia-qoe03-0.50.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title '', \
\
     "test-02-qms-qcc-qoe03-0.50.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-02-qms-qcc-qoe03-0.50.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-green" title '', \
\
     "test-02-qms-qcc-qoe07-0.50.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "goldenrod" title '', \
\
     "test-02-qms-qcc-qoe07-0.50.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-goldenrod" title '', \
\
     "test-02-qms-qcc-qoe11-0.50.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "violet" title '', \
\
     "test-02-qms-qcc-qoe11-0.50.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-violet" title ''


set xlabel offset 0,0 "Data transmission time (seconds)"
unset label
unset ylabel
set xrange [0:1300]
set xtics 0,120,1300
set mxtics 6
set yrange [0:30]
set ytics 0,10,30
set mytics 5
set label 1 at 45,26 "loss=0.60" tc rgb "sea-green" font "Microsoft Sans Serif,14"
set label 2 at 818.890561,7 point pt 11 ps 1.5 lc rgb "red"
set label 3 at 819.118034,8 point pt 11 ps 1.5 lc rgb "dark-red"
set label 4 at 1292.133057,4 point pt 9 ps 1.5 lc rgb "blue"
set label 5 at 1292.209821,3 point pt 9 ps 1.5 lc rgb "dark-blue"
set label 6 at 633.419268,6 point pt 7 ps 1.5 lc rgb "green"
set label 7 at 633.545052,10 point pt 7 ps 1.5 lc rgb "dark-green"
set label 8 at 613.878753,2 point pt 5 ps 1.5 lc rgb "goldenrod"
set label 9 at 614.023608,9 point pt 5 ps 1.5 lc rgb "dark-goldenrod"
set label 10 at 596.352601,4 point pt 13 ps 1.5 lc rgb "violet"
set label 11 at 595.951398,6 point pt 13 ps 1.5 lc rgb "dark-violet"
plot \
     "test-02-def-cubic-qoe03-0.60.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "red" title '', \
\
     "test-02-def-cubic-qoe03-0.60.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-red" title '', \
\
     "test-02-def-olia-qoe03-0.60.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "blue" title '', \
\
     "test-02-def-olia-qoe03-0.60.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-blue" title '', \
\
     "test-02-qms-qcc-qoe03-0.60.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "green" title '', \
\
     "test-02-qms-qcc-qoe03-0.60.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-green" title '', \
\
     "test-02-qms-qcc-qoe07-0.60.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "goldenrod" title '', \
\
     "test-02-qms-qcc-qoe07-0.60.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-goldenrod" title '', \
\
     "test-02-qms-qcc-qoe11-0.60.txt---wlan0---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "violet" title '', \
\
     "test-02-qms-qcc-qoe11-0.60.txt---rmnet_data---0.x-lines" using 1:3 with lines lw 1 lt 3 lc "dark-violet" title ''


