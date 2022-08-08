# dnf install gnuplot

# /bin/cp /opt/note/paper/xxu/paper/paper-2/gnuplot/test-03---times.plt /root/文档/paper2---original--test--data---20210729---OK/
# /bin/cp /opt/note/paper/xxu/paper/paper-2/gnuplot/test-03---times.plt /mnt/hdd/data/新乡学院/paper/paper-2---testing---results---20210729/paper2---original--test--data---20210729---OK

# cd /root/文档/paper2---original--test--data---20210729---OK/
# cd /mnt/hdd/data/新乡学院/paper/paper-2---testing---results---20210729/paper2---original--test--data---20210729---OK

# cd /opt/note/paper/xxu/paper/paper-2/gnuplot
# gnuplot < test-03---times.plt  > test-03---times.png
# eog     test-03---times.png &
# display test-03---times.png &

reset
set terminal png font "times new roman" size 600,220

# set grid ls 100
set grid ytics lt 0 lw 0.6 lc rgb "#bebebe"

# set tmargin 2
# set bmargin 2
# set lmargin 1
# set rmargin 1

if (!exists("MP_LEFT"))   MP_LEFT = .098
if (!exists("MP_RIGHT"))  MP_RIGHT = .99
if (!exists("MP_TOP"))    MP_TOP = .952
if (!exists("MP_BOTTOM")) MP_BOTTOM = .098
if (!exists("MP_GAP"))    MP_GAP = 0.15

# set multiplot layout 1,2 rowsfirst title "{/:Bold=12 Multiplot with explicit page margins}"
set multiplot layout 1,1 rowsfirst margins screen MP_LEFT, MP_RIGHT, MP_BOTTOM, MP_TOP spacing screen MP_GAP



set ylabel "Data transmission time (seconds)"
# set xlabel "packet loss rate (%)"

set key spacing 1.1 font ",11" at -1.1,65 bottom left samplen 1.6		# Increasing the value of <some number> should increase the distance between titles.

set style data histogram
set style histogram clustered gap 3
set style fill solid 0.9 border
set datafile separator "|"
plot "test-03---times.dat" \
	using 2:xticlabels(1) lc "red" title columnheader(1), '' \
	using 3:xticlabels(1) lc "green" title columnheader(2), '' \
	using 4:xticlabels(1) lc "blue" title columnheader(3)


