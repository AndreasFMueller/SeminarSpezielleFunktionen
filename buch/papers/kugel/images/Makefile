#
# Makefile -- build images
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all: curvature.png

curvature.inc:	curvgraph.m
	octave curvgraph.m

curvature.png:	curvature.pov curvature.inc
	povray +A0.1 +W1920 +H1080 +Ocurvature.png curvature.pov

