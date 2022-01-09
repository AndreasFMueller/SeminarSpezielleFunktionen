#
# Makefile
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	wurzel.pdf lissajous.pdf lissajous-chebyshef.pdf

wurzel.pdf:	wurzel.tex
	pdflatex wurzel.tex

lissajous.pdf:  lissajous.tex lissajous.jpg
	pdflatex lissajous.tex

lissajous-chebyshef.pdf:        lissajous-chebyshef.tex lissajous.jpg
	pdflatex lissajous-chebyshef.tex

