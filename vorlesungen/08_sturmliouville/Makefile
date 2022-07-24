#
# Makefile -- sturmliouville
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	sturmliouville-handout.pdf MathSem-08-sturmliouville.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-08-sturmliouville.pdf:	MathSem-08-sturmliouville.tex $(SOURCES)
	pdflatex MathSem-08-sturmliouville.tex

sturmliouville-handout.pdf:	sturmliouville-handout.tex $(SOURCES)
	pdflatex sturmliouville-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSem-08-sturmliouville.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-08-sturmliouville.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSem-08-sturmliouville.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSem-08-sturmliouville.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

