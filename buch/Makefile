#
# Makefile zum Skript ueber Spezielle Funktionen
#
# (c) 2021 Prof Dr Andreas Mueller, OST Ostschweizer Fachhochschule
#
all:	buch.pdf

papers/common/Makefile.inc:	papers/common/paperlist

include common/Makefile.inc
include chapters/Makefile.inc
include papers/common/Makefile.inc
include papers/common/includes.inc

ALLTEXFILES = $(TEXFILES) $(CHAPTERFILES)

buch.pdf:	buch.tex $(TEXFILES) buch.ind $(BLXFILES)
	pdflatex buch.tex
	bibtex buch

buch.idx:	buch.tex $(TEXFILES) images
	touch buch.ind
	pdflatex buch.tex

buch.ind:	buch.idx
	makeindex buch.idx

separate:	buch.aux buch.pdf
	bash splitpapers

speziellefunktionen.pdf:	
	pdfjam --outfile speziellefunktionen.pdf \
		../cover/front.pdf 1,{} \
		buch.pdf 1-20 \
		../cover/back.pdf {},1

SeminarSpezielleFunktionen.pdf:	SeminarSpezielleFunktionen.tex $(TEXFILES) \
	buch.ind $(BLXFILES)
	pdflatex buch.tex
	bibtex buch

#
# This Makefile can also construct the short tests
#
tests:  test1.pdf test2.pdf test3.pdf

test1.pdf:	common/test-common.tex common/test1.tex aufgaben1.tex
	pdflatex common/test1.tex

test2.pdf:	common/test-common.tex common/test1.tex aufgaben2.tex
	pdflatex common/test2.tex

test3.pdf:	common/test-common.tex common/test1.tex aufgaben3.tex
	pdflatex common/test3.tex

#
# Errata
#
errata.pdf:	errata.tex
	pdflatex errata.tex

