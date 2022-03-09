#
# Makefile -- dreieck
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	dreieck-handout.pdf MathSem-12-dreieck.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-12-dreieck.pdf:	MathSem-12-dreieck.tex $(SOURCES)
	pdflatex MathSem-12-dreieck.tex

dreieck-handout.pdf:	dreieck-handout.tex $(SOURCES)
	pdflatex dreieck-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSem-12-dreieck.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-12-dreieck.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSem-12-dreieck.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSem-12-dreieck.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

