#
# Makefile -- transfer
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	transfer-handout.pdf MathSem-16-transfer.pdf

include ../slides/Makefile.inc

SOURCES = common.tex slides.tex $(slides)

MathSem-16-transfer.pdf:	MathSem-16-transfer.tex $(SOURCES)
	pdflatex MathSem-16-transfer.tex

transfer-handout.pdf:	transfer-handout.tex $(SOURCES)
	pdflatex transfer-handout.tex

thumbnail:	thumbnail.jpg # fix1.jpg

thumbnail.pdf:	MathSem-16-transfer.pdf
	pdfjam --outfile thumbnail.pdf --papersize '{16cm,9cm}' \
		MathSem-16-transfer.pdf 1
thumbnail.jpg:	thumbnail.pdf
	convert -density 300 thumbnail.pdf \
                -resize 1920x1080 -units PixelsPerInch thumbnail.jpg

fix1.pdf:	MathSem-16-transfer.pdf
	pdfjam --outfile fix1.pdf --papersize '{16cm,9cm}' \
		MathSem-16-transfer.pdf 1
fix1.jpg:	fix1.pdf
	convert -density 300 fix1.pdf \
                -resize 1920x1080 -units PixelsPerInch fix1.jpg

