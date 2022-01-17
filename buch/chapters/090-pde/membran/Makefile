#
# Makefile
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	membran.png

membran.inc:	membran.m
	octave membran.m

size="+W1920 +H540"
size="+W3840 +H1080"

membran.png:	membran.pov membran.inc
	povray +A0.1 +UA $(size) -Omembran.png membran.pov
