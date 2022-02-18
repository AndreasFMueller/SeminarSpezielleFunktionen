#
# Makefile -- start
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	start-handout.pdf MathSem-01-start.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-01-start.pdf:	MathSem-01-start.tex $(SOURCES)
	pdflatex MathSem-01-start.tex

start-handout.pdf:	start-handout.tex $(SOURCES)
	pdflatex start-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSem-01-start.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-01-start.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSem-01-start.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSem-01-start.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

