#
# Makefile to build images
#
all:	primzahlfunktion2.pdf zetaplot.pdf

primzahlfunktion2.pdf:	primzahlfunktion2.tex
	pdflatex primzahlfunktion2.tex

zetapath.tex:	zetaplot.m zeta.m
	octave zetaplot.m

zetaplot.pdf:	zetaplot.tex zetapath.tex 
	pdflatex zetaplot.tex
