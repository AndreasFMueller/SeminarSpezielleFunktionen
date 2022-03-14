#
# Makefile -- kra
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	kra-handout.pdf MathSem-14-kra.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-14-kra.pdf:	MathSem-14-kra.tex $(SOURCES)
	pdflatex MathSem-14-kra.tex

kra-handout.pdf:	kra-handout.tex $(SOURCES)
	pdflatex kra-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSem-14-kra.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-14-kra.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSem-14-kra.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSem-14-kra.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

