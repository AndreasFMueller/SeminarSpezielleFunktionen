#
# Makefile -- Bilder zum Kapitel über durch Integrale definierte spezielle
#             Funktionen
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	erf.pdf legendre.pdf orthogonal.pdf

erf.pdf:	erf.tex erfpunkte.tex
	pdflatex erf.tex
erfpunkte.tex:	erfpunkte.m
	octave erfpunkte.m

legendrepaths.tex:	legendre.m
	octave legendre.m
legendre.pdf:	legendre.tex legendrepaths.tex
	pdflatex legendre.tex
orthogonal.pdf:	orthogonal.tex legendrepaths.tex
	pdflatex orthogonal.tex
