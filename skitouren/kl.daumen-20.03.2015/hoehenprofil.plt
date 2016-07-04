# Gnuplot file for the elevationprofile
#
# SKITOUR VERSION
#
# -- [ Colors ] --
# MTB       Maroon      #AF3235
# Skitour   RoyalBlue   #006EB8
# Wandern   ForestGreen #009B55
# Alternat. Olivegreen  #3C8031
mtb 		= "#AF3235"
skitour 	= "#006EB8"
wandern 	= "#009B55"
olivegreen 	= "#3C8031"

mycolor = skitour
altcolor = olivegreen

# -- [ Scaling ] --
# MTB
mtbKM = 20
mtbHM = 0.235
#
# SKITOUR
skiKM = 75.2
skiHM = 0.376

# RENNRAD
#myscaleKM = 12.53
#myscaleHM = 0.313

# WANDERN
wandernKM = 44.97 # 17.99cm / 40km
wandernHM = 0.225

myscaleKM = skiKM
myscaleHM = skiHM

file = 'gpxdata.txt'

reset
unset key
stats file u 3:2 nooutput
set xrange [STATS_min_x:STATS_max_x]
set yrange [STATS_min_y - 30:STATS_max_y]
set y2range [STATS_min_y - 30:STATS_max_y]

# Max Km mit Skalierungsfaktor. Den (fiktiven) Pixelwert von 300dpi auf cm
# umrechnen und den gesamten Skalierungsfaktor darauf mulitiplizieren.
# vielleicht nicht so ideal
w = floor(STATS_max_x * myscaleKM) * 2.54 / 300	* 2
h = floor((STATS_max_y - STATS_min_y) * myscaleHM) * 2.54 / 300 * 2

# -- [ Labels ] --
set label 1 '\textcolor{skitour}{Kl. Daumen \tiny 2197m}' at STATS_pos_max_y,STATS_max_y  point pointtype 7 ps 0.6 offset 0.3,0.3 front

# -- [ Terminal ] --
# epslates does not support transparency
# for mac xquartz is required to install epslatex https://xquartz.macosforge.org/landing/
# brew install gnuplot --cairo
set terminal cairolatex size w cm,h cm color
set output "hoehenprofil.tex"
set multiplot

# -- [ Grid and Tics ] --
set xtics 5
#set ytics 200
#set ytics format ""
unset border
unset xtics
unset ytics
unset x2tics
set y2tics border 200
set format x "%g\\scriptsize km"
set format y2 "%g\\scriptsize m"
set border 8 lt 0 lw 3 lc rgb "black"
#set ytic scale 0
set xtics
set grid y2 lt 0 lw 3 lc rgb "black"


set style fill transparent solid 0.45 noborder
plot file u 3:2 w filledcurve x1 lc rgb "black" , \
	file u 3:2 w lines lt 1 lw 5 lc rgb mycolor
#print STATS_max_x
#print STATS_pos_max_y
s = (STATS_pos_max_y  / STATS_max_x) - 0.1
set  size s,1
unset grid
unset xtics
unset y2tics
set style fill solid noborder
set nolabel
set noborder
plot [0:STATS_pos_max_y] file u 3:2 w filledcurve  x2 lc rgb "white"

