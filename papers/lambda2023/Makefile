.PHONY: debs depexts all pics 
.SUFFIXES: .tex .pdf

TARGET = lambda2025
ENGINE ?= xelatex

all: $(TARGET).pdf

pics: 
	$(MAKE) -C tikzpics

$(TARGET).pdf: $(TARGET).tex

%.pdf: %.tex
	latexmk -$(ENGINE) $<
	#xelatex -$(ENGINE) -synctex=1 -shell-escape -interaction=nonstopmode $< -o $@


clean:
	@$(RM) -r _minted* 
	@$(RM) *.aux *.log *.bbl *.blg *.vrb *.xdv *.nav *.out *.snm *.toc *_latexmk *.synctex.gz *.pdf *-blx.bib *.run.xml

cleanminted:
	@$(RM) -r _minted* *.pdf

depexts: debs
debs:
	sudo apt install texlive-lang-cyrillic fonts-cmu python3-pygments texlive-fonts-extra texlive-science

