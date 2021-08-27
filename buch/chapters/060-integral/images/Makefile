#
# Makefile -- Bilder zum Kapitel über durch Integrale definierte spezielle
#             Funktionen
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	erf.pdf

erf.pdf:	erf.tex erfpunkte.tex
	pdflatex erf.tex
erfpunkte.tex:	erfpunkte.m
	octave erfpunkte.m
