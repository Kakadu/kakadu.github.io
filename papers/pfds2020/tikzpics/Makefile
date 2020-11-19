.PHONY: all
.SUFFIXES: .tex .pdf

TIKZES=$(wildcard *.tex)
TIKZES_PDF=$(patsubst %.tex,%.pdf,$(TIKZES))
all: $(TIKZES_PDF)

%.pdf: %.tex
	xelatex -synctex=1 -shell-escape -interaction=nonstopmode $< -o $@



clean:
	@$(RM) -r _minted* 
	@$(RM) *.aux *.log *.bbl *.blg *.vrb *.xdv *.nav *.out *.snm *.toc *.synctex.gz *.pdf 

cleanminted:
	@$(RM) -r _minted* *.pdf


