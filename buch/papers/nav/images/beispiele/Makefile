#
# Makefile to build images 
#
# (c) 2022
#
all:	beispiele

POSITION =								\
	beispiele1.pdf							\
	beispiele2.pdf							\
	beispiele3.pdf	

beispiele: $(POSITION)

POVRAYOPTIONS = -W1080 -H1080
#POVRAYOPTIONS = -W480 -H480

beispiele1.png:	beispiele1.pov common.inc geometrie.inc ../macros.inc
	povray +A0.1 $(POVRAYOPTIONS) -Obeispiele1.png beispiele1.pov
beispiele1.jpg:	beispiele1.png
	convert beispiele1.png -density 300 -units PixelsPerInch beispiele1.jpg
beispiele1.pdf:	beispiele1.tex common.tex beispiele1.jpg
	pdflatex beispiele1.tex

beispiele2.png:	beispiele2.pov common.inc geometrie.inc ../macros.inc
	povray +A0.1 $(POVRAYOPTIONS) -Obeispiele2.png beispiele2.pov
beispiele2.jpg:	beispiele2.png
	convert beispiele2.png -density 300 -units PixelsPerInch beispiele2.jpg
beispiele2.pdf:	beispiele2.tex common.tex beispiele2.jpg
	pdflatex beispiele2.tex

beispiele3.png:	beispiele3.pov common.inc geometrie.inc ../macros.inc
	povray +A0.1 $(POVRAYOPTIONS) -Obeispiele3.png beispiele3.pov
beispiele3.jpg:	beispiele3.png
	convert beispiele3.png -density 300 -units PixelsPerInch beispiele3.jpg
beispiele3.pdf:	beispiele3.tex common.tex beispiele3.jpg
	pdflatex beispiele3.tex

