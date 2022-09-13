TEX := xelatex
BIB := bibtex
TEXARGS := --halt-on-error

DOCNAME := KugelBSc
SOURCES := $(DOCNAME).tex
BIBFILE := $(DOCNAME).bib

.PHONY: clean
all: $(DOCNAME).pdf

clean:
	@rm -fv $(DOCNAME)-blx.bib $(DOCNAME).aux $(DOCNAME).bbl $(DOCNAME).blg $(DOCNAME).log $(DOCNAME).nav $(DOCNAME).out $(DOCNAME).run.xml $(DOCNAME).snm $(DOCNAME).toc

$(DOCNAME).pdf : $(SOURCES) $(BIBFILE)
	$(TEX) $(TEXARGS) $<
	$(BIB) $(DOCNAME)
	$(TEX) $(TEXARGS) $<
