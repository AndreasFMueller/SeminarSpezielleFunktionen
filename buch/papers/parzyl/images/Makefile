#
# Makefile to build 3d images
#
# (c) 2022 Prof Dr Andreas Müller
#

all:	halfplane.pdf

halfplane.pdf:	halfplane.tex halfplane.jpg
	pdflatex halfplane.tex
halfplane.png:	halfplane.pov
	povray +A0.1 -W1920 -H1080 -Ohalfplane.png halfplane.pov
halfplane.jpg: halfplane.png Makefile
	convert -extract 1280x1080+340+0 halfplane.png \
		-density 300 -units PixelsPerInch halfplane.jpg

