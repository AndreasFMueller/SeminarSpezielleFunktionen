#
# Makefile -- kugel2
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	kugel2-handout.pdf MathSem-11-kugel2.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-11-kugel2.pdf:	MathSem-11-kugel2.tex $(SOURCES)
	pdflatex MathSem-11-kugel2.tex

kugel2-handout.pdf:	kugel2-handout.tex $(SOURCES)
	pdflatex kugel2-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSem-11-kugel2.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-11-kugel2.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSem-11-kugel2.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSem-11-kugel2.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

