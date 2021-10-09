#
# Makefile.inc
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#

CHAPTERFILES = 								\
	chapters/part1.tex						\
	chapters/vorwort.tex

include chapters/000-einleitung/Makefile.inc
include chapters/020-exponential/Makefile.inc
include chapters/060-integral/Makefile.inc
include chapters/080-funktionentheorie/Makefile.inc

