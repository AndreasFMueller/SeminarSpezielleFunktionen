#
# Makefile to build images 
#
# (c) 2022
#
all:	dreiecke

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
