#
# Makefile for images
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#

all:									\
	deftrig.pdf							\
	einheitskreis.pdf						\
	hyperbelflaeche.pdf						\
	hyperbel.pdf							\
	kegelschnitte.pdf						\
	polargleichung.pdf						\
	zylinder.pdf

deftrig.pdf:	deftrig.tex
	pdflatex deftrig.tex

einheitskreis.pdf:	einheitskreis.tex
	pdflatex einheitskreis.tex

hyperbelflaeche.pdf:	hyperbelflaeche.tex
	pdflatex hyperbelflaeche.tex

hyperbel.pdf:	hyperbel.tex
	pdflatex hyperbel.tex

polargleichung.pdf:	polargleichung.tex
	pdflatex polargleichung.tex

zylinder.png:	zylinder.pov
	povray +A0.1 +W1920 +H1080 -Ozylinder.png zylinder.pov
zylinder.jpg:	zylinder.png Makefile
	convert -extract 1844x1080+32+0 zylinder.png \
		-density 300 -units PixelsPerInch zylinder.jpg
zylinder.pdf:	zylinder.tex zylinder.jpg
	pdflatex zylinder.tex

kegelschnitte.pdf:	kegelschnitte.tex kegelschnitte.jpg
	pdflatex kegelschnitte.tex
kegelschnitte.png:	kegelschnitte.pov
	povray +A0.1 +W1920 +H1080 -Okegelschnitte.png kegelschnitte.pov
kegelschnitte.jpg:	kegelschnitte.png Makefile
	convert -extract 1520x1080+200+0 kegelschnitte.png \
		-density 300 -units PixelsPerInch kegelschnitte.jpg
