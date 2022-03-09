#
# Makefile -- hermite
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	hermite-handout.pdf MathSem-09-hermite.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-09-hermite.pdf:	MathSem-09-hermite.tex $(SOURCES)
	pdflatex MathSem-09-hermite.tex

hermite-handout.pdf:	hermite-handout.tex $(SOURCES)
	pdflatex hermite-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSem-09-hermite.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-09-hermite.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSem-09-hermite.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSem-09-hermite.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

