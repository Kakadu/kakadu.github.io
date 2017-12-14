set terminal epslatex
set output 'graph1.eps'

set style data histogram
set style histogram cluster gap 1

set style fill solid border rgb "black"
set auto x
# Comment/uncomment to switch logscale off/on
#set logscale y
set yrange [0.01:*]
plot 'data1.gnuplot' using 2:xtic(1) title col \
      , '' using 5:xtic(1) title col \
