#
# Makefile -- laguerre
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	laguerre-handout.pdf MathSem-15-laguerre.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-15-laguerre.pdf:	MathSem-15-laguerre.tex $(SOURCES)
	pdflatex MathSem-15-laguerre.tex

laguerre-handout.pdf:	laguerre-handout.tex $(SOURCES)
	pdflatex laguerre-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSem-15-laguerre.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-15-laguerre.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSem-15-laguerre.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSem-15-laguerre.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

