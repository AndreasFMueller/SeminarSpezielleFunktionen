#
# Makefile.inc -- Makefile Targets und Variablen für Papers
#
# Achtung: dieses File wird erzeugt vom Skript scripts/mkmakefile
#
# (c) 2020 Prof Dr Andreas Müller, Hochschule Rapperswil
#
PAPERFILES = \
	papers/part2.tex \
	papers/uebersicht.tex \
	papers/000template/main.tex \
	papers/lambertw/main.tex \
	papers/fm/main.tex \
	papers/nlwave/main.tex \
	papers/fresnel/main.tex \
	papers/kreismembran/main.tex \
	papers/sturmliouville/main.tex \
	papers/laguerre/main.tex \
	papers/zeta/main.tex \
	papers/0f1/main.tex \
	papers/nav/main.tex \
	papers/transfer/main.tex \
	papers/kra/main.tex \
	papers/kugel/main.tex \
	papers/hermite/main.tex \
	papers/ellfilter/main.tex \
	
buch1-blx.bbl:	buch1-blx.aux
	bibtex buch1-blx

buch2-blx.bbl:	buch2-blx.aux
	bibtex buch2-blx

buch3-blx.bbl:	buch3-blx.aux
	bibtex buch3-blx

buch4-blx.bbl:	buch4-blx.aux
	bibtex buch4-blx

buch5-blx.bbl:	buch5-blx.aux
	bibtex buch5-blx

buch6-blx.bbl:	buch6-blx.aux
	bibtex buch6-blx

buch7-blx.bbl:	buch7-blx.aux
	bibtex buch7-blx

buch8-blx.bbl:	buch8-blx.aux
	bibtex buch8-blx

buch9-blx.bbl:	buch9-blx.aux
	bibtex buch9-blx

buch10-blx.bbl:	buch10-blx.aux
	bibtex buch10-blx

buch11-blx.bbl:	buch11-blx.aux
	bibtex buch11-blx

buch12-blx.bbl:	buch12-blx.aux
	bibtex buch12-blx

buch13-blx.bbl:	buch13-blx.aux
	bibtex buch13-blx

buch14-blx.bbl:	buch14-blx.aux
	bibtex buch14-blx

buch15-blx.bbl:	buch15-blx.aux
	bibtex buch15-blx

buch16-blx.bbl:	buch16-blx.aux
	bibtex buch16-blx

buch17-blx.bbl:	buch17-blx.aux
	bibtex buch17-blx

BLXFILES = buch.bbl \
	buch1-blx.bbl \
	buch2-blx.bbl \
	buch3-blx.bbl \
	buch4-blx.bbl \
	buch5-blx.bbl \
	buch6-blx.bbl \
	buch7-blx.bbl \
	buch8-blx.bbl \
	buch9-blx.bbl \
	buch10-blx.bbl \
	buch11-blx.bbl \
	buch12-blx.bbl \
	buch13-blx.bbl \
	buch14-blx.bbl \
	buch15-blx.bbl \
	buch16-blx.bbl \
	buch17-blx.bbl \

PAPER_DIRECTORIES = \
	000template \
	lambertw \
	fm \
	nlwave \
	fresnel \
	kreismembran \
	sturmliouville \
	laguerre \
	zeta \
	0f1 \
	nav \
	transfer \
	kra \
	kugel \
	hermite \
	ellfilter \
	
PAPER_MAKEFILEINC = \
	papers/000template/Makefile.inc \
	papers/lambertw/Makefile.inc \
	papers/fm/Makefile.inc \
	papers/nlwave/Makefile.inc \
	papers/fresnel/Makefile.inc \
	papers/kreismembran/Makefile.inc \
	papers/sturmliouville/Makefile.inc \
	papers/laguerre/Makefile.inc \
	papers/zeta/Makefile.inc \
	papers/0f1/Makefile.inc \
	papers/nav/Makefile.inc \
	papers/transfer/Makefile.inc \
	papers/kra/Makefile.inc \
	papers/kugel/Makefile.inc \
	papers/hermite/Makefile.inc \
	papers/ellfilter/Makefile.inc \
	
