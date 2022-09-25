#
# Makefile
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	am.pdf								\
	amnormal.pdf							\
	amfrequency.pdf							\
	bessel.pdf							\
	beta2.pdf							\
	fm.pdf								\
	fc150.pdf							\
	fm10.pdf							\
	normal.pdf							\
	pm.pdf	

am.pdf:	am.tex
	pdflatex am.tex

pm.pdf:	pm.tex
	pdflatex pm.tex

fm.pdf:	fm.tex
	pdflatex fm.tex

amnormal.pdf:	amnormal.tex
	pdflatex amnormal.tex

amfrequency.pdf:	amfrequency.tex AM_frequency.pgf
	pdflatex amfrequency.tex

bessel.pdf:	bessel.tex bessel.pgf
	pdflatex bessel.tex

normal.pdf:	normal.tex normal.pgf
	pdflatex normal.tex

beta2.pdf:	beta2.tex beta_2.pgf
	pdflatex beta2.tex

fc150.pdf:	fc150.tex fc_150.pgf
	pdflatex fc150.tex

fm10.pdf:	fm10.tex fm_10.pgf
	pdflatex fm10.tex


