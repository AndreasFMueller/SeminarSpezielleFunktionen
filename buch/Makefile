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

#
# Buchblock für Druckerei
#
buch.pdf:	buch.tex $(TEXFILES) buch.ind $(BLXFILES)
	pdflatex buch.tex
	bibtex buch

buch.idx:	buch.tex $(TEXFILES) images
	touch buch.ind
	pdflatex buch.tex

buch.ind:	buch.idx
	makeindex buch.idx

#
# Papers in einzelne PDF-Files separieren für digitales Feedback
#
separate:	buch.aux buch.pdf
	bash splitpapers

#
# Version mit Buchdeckeln für Release/Website
#
SeminarSpezielleFunktionen.pdf:	SeminarSpezielleFunktionen.tex $(TEXFILES) \
	SeminarSpezielleFunktionen.ind $(BLXFILES)
	pdflatex SeminarSpezielleFunktionen.tex
	bibtex SeminarSpezielleFunktionen

SeminarSpezielleFunktionen.idx:	SeminarSpezielleFunktionen.tex $(TEXFILES) \
	images
	touch SeminarSpezielleFunktionen.ind
	pdflatex SeminarSpezielleFunktionen.tex

SeminarSpezielleFunktionen.ind:	SeminarSpezielleFunktionen.idx
	makeindex SeminarSpezielleFunktionen

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

