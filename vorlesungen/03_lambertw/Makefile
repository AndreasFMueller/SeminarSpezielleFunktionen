#
# Makefile -- lambertw
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	lambertw-handout.pdf MathSem-03-lambertw.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-03-lambertw.pdf:	MathSem-03-lambertw.tex $(SOURCES)
	pdflatex MathSem-03-lambertw.tex

lambertw-handout.pdf:	lambertw-handout.tex $(SOURCES)
	pdflatex lambertw-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSem-03-lambertw.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-03-lambertw.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSem-03-lambertw.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSem-03-lambertw.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

