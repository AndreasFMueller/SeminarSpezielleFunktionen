#
# Makefile -- build images
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all: curvature.jpg spherecurve.jpg

curvature.inc:	curvgraph.m
	octave curvgraph.m

curvature.png:	curvature.pov curvature.inc
	povray +A0.1 +W1920 +H1080 +Ocurvature.png curvature.pov

curvature.jpg:	curvature.png
	convert curvature.png -density 300 -units PixelsPerInch curvature.jpg

spherecurve.inc:	spherecurve.m
	octave spherecurve.m

spherecurve.png:	spherecurve.pov spherecurve.inc
	povray +A0.1 +W1920 +H1080 +Ospherecurve.png spherecurve.pov

spherecurve.jpg:	spherecurve.png
	convert spherecurve.png -density 300 -units PixelsPerInch spherecurve.jpg

