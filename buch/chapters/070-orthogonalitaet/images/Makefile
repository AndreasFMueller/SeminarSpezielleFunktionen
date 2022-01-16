#
# Makefile -- Bilder zum Kapitel über durch Integrale definierte spezielle
#             Funktionen
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	legendre.pdf orthogonal.pdf weight.pdf jacobi.pdf laguerre.pdf

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

jacobi:	jacobi.cpp
	g++ --std=c++11 -O -Wall -g -o jacobi jacobi.cpp

laguerre.pdf:	laguerre.tex laguerrepaths.tex
	pdflatex laguerre.tex
laguerrepaths.tex:	laguerre.m
	octave laguerre.m

jacobipaths.tex:	jacobi Makefile
	./jacobi --a=0 --b=0 --prefix=legendre --outfile=jacobipaths.tex
	./jacobi --a=1 --b=0 --degree=14 --prefix=aone >> jacobipaths.tex
	./jacobi --a=2 --b=0 --prefix=atwo >> jacobipaths.tex
	./jacobi --a=-1 --b=0 --degree=14 --prefix=aminusone >> jacobipaths.tex
	./jacobi --a=-2 --b=0 --prefix=aminustwo >> jacobipaths.tex
jacobi.pdf:	jacobi.tex jacobipaths.tex
	pdflatex jacobi.tex
