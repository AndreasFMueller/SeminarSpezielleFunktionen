#
# Makefile -- build the book cover
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	buchcover.png front.pdf back.pdf

buchcover.pdf:	buchcover.tex 
	pdflatex buchcover.tex

buchcover.png:	buchcover.pdf 
	convert -density 300 -extract 1966x2900+2630+190 buchcover.pdf \
		buchcover.png

front.pdf:	front.tex buchcover.pdf
	pdflatex front.tex

back.pdf:	back.tex buchcover.pdf
	pdflatex back.tex
