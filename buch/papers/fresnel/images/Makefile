#
# Makefile
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	schale.pdf							\
	fresnelgraph.pdf						\
	eulerspirale.pdf						\
	pfad.pdf							\
	apfel.pdf							\
	kruemmung.pdf

schale.png:	schale.pov
	povray +A0.1 -W1920 -H1080 -Oschale.png schale.pov

schale.jpg:	schale.png Makefile
	convert -extract 1240x1080+340 schale.png -density 300 -units PixelsPerInch schale.jpg

schale.pdf:	schale.tex schale.jpg
	pdflatex schale.tex

eulerpath.tex:	eulerspirale.m
	octave eulerspirale.m

fresnelgraph.pdf:	fresnelgraph.tex eulerpath.tex
	pdflatex fresnelgraph.tex

eulerspirale.pdf:	eulerspirale.tex eulerpath.tex
	pdflatex eulerspirale.tex

pfad.pdf:	pfad.tex
	pdflatex pfad.tex

apfel.pdf:	apfel.tex apfel.jpg eulerpath.tex
	pdflatex apfel.tex

kruemmung.pdf:	kruemmung.tex
	pdflatex kruemmung.tex
