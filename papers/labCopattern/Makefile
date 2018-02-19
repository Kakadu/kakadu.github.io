.SUFFIXES: .pdf .tex
.PHONY: all

NAME=copatterns

all: $(NAME).pdf


$(NAME).pdf: $(NAME).tex
	pdflatex $<

clean:
	rm -f *.aux *.log *.bbl *.out *.blg *.*~ main.dvi *~ $(NAME).pdf

