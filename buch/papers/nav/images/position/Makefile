#
# Makefile to build images 
#
# (c) 2022
#
all:	position

POSITION =								\
	position1.pdf							\
	position2.pdf							\
	position3.pdf							\
	position4.pdf							\
	position5.pdf	

position: $(POSITION)

POVRAYOPTIONS = -W1080 -H1080
#POVRAYOPTIONS = -W480 -H480

position1.png:	position1.pov common.inc ../macros.inc
	povray +A0.1 $(POVRAYOPTIONS) -Oposition1.png position1.pov
position1.jpg:	position1.png
	convert position1.png -density 300 -units PixelsPerInch position1.jpg
position1.pdf:	position1.tex common.tex position1.jpg
	pdflatex position1.tex

position2.png:	position2.pov common.inc ../macros.inc
	povray +A0.1 $(POVRAYOPTIONS) -Oposition2.png position2.pov
position2.jpg:	position2.png
	convert position2.png -density 300 -units PixelsPerInch position2.jpg
position2.pdf:	position2.tex common.tex position2.jpg
	pdflatex position2.tex

position3.png:	position3.pov common.inc ../macros.inc
	povray +A0.1 $(POVRAYOPTIONS) -Oposition3.png position3.pov
position3.jpg:	position3.png
	convert position3.png -density 300 -units PixelsPerInch position3.jpg
position3.pdf:	position3.tex common.tex position3.jpg
	pdflatex position3.tex

position4.png:	position4.pov common.inc ../macros.inc
	povray +A0.1 $(POVRAYOPTIONS) -Oposition4.png position4.pov
position4.jpg:	position4.png
	convert position4.png -density 300 -units PixelsPerInch position4.jpg
position4.pdf:	position4.tex common.tex position4.jpg
	pdflatex position4.tex

position5.png:	position5.pov common.inc ../macros.inc
	povray +A0.1 $(POVRAYOPTIONS) -Oposition5.png position5.pov
position5.jpg:	position5.png
	convert position5.png -density 300 -units PixelsPerInch position5.jpg
position5.pdf:	position5.tex common.tex position5.jpg
	pdflatex position5.tex

