#
# Makefile -- zeta
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	zeta-handout.pdf MathSem-17-zeta.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-17-zeta.pdf:	MathSem-17-zeta.tex $(SOURCES)
	pdflatex MathSem-17-zeta.tex

zeta-handout.pdf:	zeta-handout.tex $(SOURCES)
	pdflatex zeta-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSem-17-zeta.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-17-zeta.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSem-17-zeta.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSem-17-zeta.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

