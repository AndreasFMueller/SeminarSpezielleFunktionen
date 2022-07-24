#
# Makefile -- 0f1
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	0f1-handout.pdf MathSem-01-0f1.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-01-0f1.pdf:	MathSem-01-0f1.tex $(SOURCES)
	pdflatex MathSem-01-0f1.tex

0f1-handout.pdf:	0f1-handout.tex $(SOURCES)
	pdflatex 0f1-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSem-01-0f1.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-01-0f1.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSem-01-0f1.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSem-01-0f1.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

