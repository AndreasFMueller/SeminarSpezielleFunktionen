#
# Makefile for images
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#

all:	hyperbelflaeche.pdf						\
	polargleichung.pdf						\
	deftrig.pdf							\
	einheitskreis.pdf						\
	zylinder.pdf

hyperbelflaeche.pdf:	hyperbelflaeche.tex
	pdflatex hyperbelflaeche.tex

polargleichung.pdf:	polargleichung.tex
	pdflatex polargleichung.tex

deftrig.pdf:	deftrig.tex
	pdflatex deftrig.tex

einheitskreis.pdf:	einheitskreis.tex
	pdflatex einheitskreis.tex

zylinder.png:	zylinder.pov
	povray +A0.1 +W1920 +H1080 -Ozylinder.png zylinder.pov
zylinder.jpg:	zylinder.png Makefile
	convert -extract 1844x1080+32+0 zylinder.png \
		-density 300 -units PixelsPerInch zylinder.jpg
zylinder.pdf:	zylinder.tex zylinder.jpg
	pdflatex zylinder.tex

