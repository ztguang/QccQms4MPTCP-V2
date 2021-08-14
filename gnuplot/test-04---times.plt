
reset
set terminal png font "times new roman" size 600,300

if (!exists("MP_LEFT"))   MP_LEFT = .11
if (!exists("MP_RIGHT"))  MP_RIGHT = .99
if (!exists("MP_TOP"))    MP_TOP = .96
if (!exists("MP_BOTTOM")) MP_BOTTOM = .08
if (!exists("MP_GAP"))    MP_GAP = 0.15

set multiplot layout 1,1 rowsfirst margins screen MP_LEFT, MP_RIGHT, MP_BOTTOM, MP_TOP spacing screen MP_GAP

set ylabel "Data transmission time (seconds)"

set key spacing 1.1 font ",11" at -1.36,122 bottom left samplen 1.6

set style data histogram
set style histogram clustered gap 5
set style fill solid 0.9 border
set datafile separator "|"
plot "test-04---times.dat" \
	using 2:xticlabels(1) lc "red" title columnheader(2), '' \
	using 3:xticlabels(1) lc "dark-red" title columnheader(3), '' \
	using 4:xticlabels(1) lc "blue" title columnheader(4), '' \
	using 5:xticlabels(1) lc "dark-blue" title columnheader(5), '' \
	using 6:xticlabels(1) lc "green" title columnheader(6), '' \
	using 7:xticlabels(1) lc "dark-green" title columnheader(7), '' \
	using 8:xticlabels(1) lc "goldenrod" title columnheader(8), '' \
	using 9:xticlabels(1) lc "dark-goldenrod" title columnheader(9), '' \
	using 10:xticlabels(1) lc "violet" title columnheader(10), '' \
	using 11:xticlabels(1) lc "dark-violet" title columnheader(11)


