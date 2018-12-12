.SUFFIXES: .pdf .tex

NAME=miniConf18
all: $(NAME).pdf


$(NAME).pdf: $(NAME).tex
	pdflatex $<

clean:
	rm -f *.aux *.log *.bbl *.out *.blg *.*~ main.dvi *~ $(NAME).pdf

