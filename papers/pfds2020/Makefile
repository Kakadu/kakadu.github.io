.PHONY: debs depexts all pics 
.SUFFIXES: .tex .pdf

TARGET=pfds_talk
all: $(TARGET).pdf

pics: 
	$(MAKE) -C tikzpics

$(TARGET).pdf: pics $(TARGET).tex

%.pdf: %.tex
	xelatex -synctex=1 -shell-escape -interaction=nonstopmode $< -o $@

clean:
	@$(RM) -r _minted* 
	@$(RM) *.aux *.log *.bbl *.blg *.vrb *.xdv *.nav *.out *.snm *.toc *.synctex.gz *.pdf 

cleanminted:
	@$(RM) -r _minted* *.pdf

depexts: debs
debs:
	sudo apt install texlive-lang-cyrillic fonts-cmu python3-pygments texlive-fonts-extra texlive-science

