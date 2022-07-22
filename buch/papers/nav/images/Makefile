#
# Makefile to build images 
#
# (c) 2022
#
all:	dreiecke3d

dreieck.pdf:	dreieck.tex dreieckdata.tex macros.tex
	pdflatex dreieck.tex

dreieckdata.tex:	pk.m
	octave pk.m

DREIECKE = 								\
	dreieck1.pdf 							\
	dreieck2.pdf 							\
	dreieck3.pdf 							\
	dreieck4.pdf							\
	dreieck5.pdf 							\
	dreieck6.pdf 							\
	dreieck7.pdf

dreiecke:	$(DREIECKE)

dreieck1.pdf:	dreieck1.tex dreieckdata.tex macros.tex
	pdflatex dreieck1.tex

dreieck2.pdf:	dreieck2.tex dreieckdata.tex macros.tex
	pdflatex dreieck2.tex

dreieck3.pdf:	dreieck3.tex dreieckdata.tex macros.tex
	pdflatex dreieck3.tex

dreieck4.pdf:	dreieck4.tex dreieckdata.tex macros.tex
	pdflatex dreieck4.tex

dreieck5.pdf:	dreieck5.tex dreieckdata.tex macros.tex
	pdflatex dreieck5.tex

dreieck6.pdf:	dreieck6.tex dreieckdata.tex macros.tex
	pdflatex dreieck6.tex

dreieck7.pdf:	dreieck7.tex dreieckdata.tex macros.tex
	pdflatex dreieck7.tex

DREIECKE3D =								\
	dreieck3d1.pdf							\
	dreieck3d2.pdf							\
	dreieck3d3.pdf							\
	dreieck3d4.pdf							\
	dreieck3d5.pdf							\
	dreieck3d6.pdf							\
	dreieck3d7.pdf							\
	dreieck3d8.pdf	

dreiecke3d: $(DREIECKE3D)

POVRAYOPTIONS = -W1080 -H1080
#POVRAYOPTIONS = -W480 -H480

dreieck3d1.png:	dreieck3d1.pov common.inc macros.inc
	povray +A0.1 $(POVRAYOPTIONS) -Odreieck3d1.png dreieck3d1.pov
dreieck3d1.jpg:	dreieck3d1.png
	convert dreieck3d1.png -density 300 -units PixelsPerInch dreieck3d1.jpg
dreieck3d1.pdf:	dreieck3d1.tex dreieck3d1.jpg
	pdflatex dreieck3d1.tex

dreieck3d2.png:	dreieck3d2.pov common.inc macros.inc
	povray +A0.1 $(POVRAYOPTIONS) -Odreieck3d2.png dreieck3d2.pov
dreieck3d2.jpg:	dreieck3d2.png
	convert dreieck3d2.png -density 300 -units PixelsPerInch dreieck3d2.jpg
dreieck3d2.pdf:	dreieck3d2.tex dreieck3d2.jpg
	pdflatex dreieck3d2.tex

dreieck3d3.png:	dreieck3d3.pov common.inc macros.inc
	povray +A0.1 $(POVRAYOPTIONS) -Odreieck3d3.png dreieck3d3.pov
dreieck3d3.jpg:	dreieck3d3.png
	convert dreieck3d3.png -density 300 -units PixelsPerInch dreieck3d3.jpg
dreieck3d3.pdf:	dreieck3d3.tex dreieck3d3.jpg
	pdflatex dreieck3d3.tex

dreieck3d4.png:	dreieck3d4.pov common.inc macros.inc
	povray +A0.1 $(POVRAYOPTIONS) -Odreieck3d4.png dreieck3d4.pov
dreieck3d4.jpg:	dreieck3d4.png
	convert dreieck3d4.png -density 300 -units PixelsPerInch dreieck3d4.jpg
dreieck3d4.pdf:	dreieck3d4.tex dreieck3d4.jpg
	pdflatex dreieck3d4.tex

dreieck3d5.png:	dreieck3d5.pov common.inc macros.inc
	povray +A0.1 $(POVRAYOPTIONS) -Odreieck3d5.png dreieck3d5.pov
dreieck3d5.jpg:	dreieck3d5.png
	convert dreieck3d5.png -density 300 -units PixelsPerInch dreieck3d5.jpg
dreieck3d5.pdf:	dreieck3d5.tex dreieck3d5.jpg
	pdflatex dreieck3d5.tex

dreieck3d6.png:	dreieck3d6.pov common.inc macros.inc
	povray +A0.1 $(POVRAYOPTIONS) -Odreieck3d6.png dreieck3d6.pov
dreieck3d6.jpg:	dreieck3d6.png
	convert dreieck3d6.png -density 300 -units PixelsPerInch dreieck3d6.jpg
dreieck3d6.pdf:	dreieck3d6.tex dreieck3d6.jpg
	pdflatex dreieck3d6.tex

dreieck3d7.png:	dreieck3d7.pov common.inc macros.inc
	povray +A0.1 $(POVRAYOPTIONS) -Odreieck3d7.png dreieck3d7.pov
dreieck3d7.jpg:	dreieck3d7.png
	convert dreieck3d7.png -density 300 -units PixelsPerInch dreieck3d7.jpg
dreieck3d7.pdf:	dreieck3d7.tex dreieck3d7.jpg
	pdflatex dreieck3d7.tex

dreieck3d8.png:	dreieck3d8.pov common.inc macros.inc
	povray +A0.1 $(POVRAYOPTIONS) -Odreieck3d8.png dreieck3d8.pov
dreieck3d8.jpg:	dreieck3d8.png
	convert dreieck3d8.png -density 300 -units PixelsPerInch dreieck3d8.jpg
dreieck3d8.pdf:	dreieck3d8.tex dreieck3d8.jpg
	pdflatex dreieck3d8.tex

dreieck3d9.png:	dreieck3d9.pov common.inc macros.inc
	povray +A0.1 $(POVRAYOPTIONS) -Odreieck3d9.png dreieck3d9.pov
dreieck3d9.jpg:	dreieck3d9.png
	convert dreieck3d9.png -density 300 -units PixelsPerInch dreieck3d9.jpg
dreieck3d9.pdf:	dreieck3d9.tex dreieck3d9.jpg
	pdflatex dreieck3d9.tex

dreieck3d10.png:	dreieck3d10.pov common.inc macros.inc
	povray +A0.1 $(POVRAYOPTIONS) -Odreieck3d10.png dreieck3d10.pov
dreieck3d10.jpg:	dreieck3d10.png
	convert dreieck3d10.png -density 300 -units PixelsPerInch dreieck3d10.jpg
dreieck3d10.pdf:	dreieck3d10.tex dreieck3d10.jpg macros.inc
	pdflatex dreieck3d10.tex

