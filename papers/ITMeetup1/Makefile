.SUFFIXES: .pdf .tex
.PHONY: all

NAME=ocamlWeb2
DEFAULT_TARGET: all

all: $(NAME).pdf

$(NAME).pdf: $(NAME).tex
	pdflatex -shell-escape -interaction batchmode $<

clean:
	@$(RM) -r _minted-ocamlWeb2
	$(RM) *.nav *.aux *.log *.bbl *.out *.snm *.toc *.vrb *.blg *.*~ $(NAME).dvi *~ #$(NAME).pdf

