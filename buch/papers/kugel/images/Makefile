#
# Makefile -- build images
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all: curvature.jpg

curvature.inc:	curvgraph.m
	octave curvgraph.m

curvature.png:	curvature.pov curvature.inc
	povray +A0.1 +W1920 +H1080 +Ocurvature.png curvature.pov

curvature.jpg:	curvature.png
	convert curvature.png -density 300 -units PixelsPerInch curvature.jpg
