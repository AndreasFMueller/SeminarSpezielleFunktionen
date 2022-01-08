#
# Makefile -- Bilder zum Kapitel über durch Integrale definierte spezielle
#             Funktionen
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	legendre.pdf orthogonal.pdf weight.pdf

legendrepaths.tex:	legendre.m
	octave legendre.m
legendre.pdf:	legendre.tex legendrepaths.tex
	pdflatex legendre.tex

orthogonal.pdf:	orthogonal.tex legendrepaths.tex
	pdflatex orthogonal.tex

weight.pdf:	weight.tex weightfunction.tex
	pdflatex weight.tex
weightfunction.tex:	weight.m
	octave weight.m

