#
# Makefile -- kreismembran
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	kreismembran-handout.pdf MathSem-07-kreismembran.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-07-kreismembran.pdf:	MathSem-07-kreismembran.tex $(SOURCES)
	pdflatex MathSem-07-kreismembran.tex

kreismembran-handout.pdf:	kreismembran-handout.tex $(SOURCES)
	pdflatex kreismembran-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSem-07-kreismembran.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-07-kreismembran.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSem-07-kreismembran.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSem-07-kreismembran.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

