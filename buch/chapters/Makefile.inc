#
# Makefile.inc
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#

CHAPTERFILES = 								\
	chapters/part1.tex						\
	chapters/vorwort.tex

include chapters/000-einleitung/Makefile.inc
include chapters/010-potenzen/Makefile.inc
include chapters/020-exponential/Makefile.inc
include chapters/030-geometrie/Makefile.inc
include chapters/040-rekursion/Makefile.inc
include chapters/060-integral/Makefile.inc
include chapters/070-orthogonalitaet/Makefile.inc
include chapters/075-fourier/Makefile.inc
include chapters/080-funktionentheorie/Makefile.inc
include chapters/090-pde/Makefile.inc
include chapters/110-elliptisch/Makefile.inc

