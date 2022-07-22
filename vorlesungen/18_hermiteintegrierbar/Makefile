#
# Makefile -- hermiteintegrierbar
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	hermiteintegrierbar-handout.pdf MathSem-18-hermiteintegrierbar.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-18-hermiteintegrierbar.pdf:	MathSem-18-hermiteintegrierbar.tex $(SOURCES)
	pdflatex MathSem-18-hermiteintegrierbar.tex

hermiteintegrierbar-handout.pdf:	hermiteintegrierbar-handout.tex $(SOURCES)
	pdflatex hermiteintegrierbar-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSem-18-hermiteintegrierbar.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-18-hermiteintegrierbar.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSem-18-hermiteintegrierbar.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSem-18-hermiteintegrierbar.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

