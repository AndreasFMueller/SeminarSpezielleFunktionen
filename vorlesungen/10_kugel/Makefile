#
# Makefile -- kugel
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	kugel-handout.pdf MathSem-10-kugel.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-10-kugel.pdf:	MathSem-10-kugel.tex $(SOURCES)
	pdflatex MathSem-10-kugel.tex

kugel-handout.pdf:	kugel-handout.tex $(SOURCES)
	pdflatex kugel-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSem-10-kugel.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-10-kugel.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSem-10-kugel.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSem-10-kugel.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

