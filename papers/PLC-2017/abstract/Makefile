SOURCE="main"

all:
	pdflatex $(SOURCE)
	bibtex $(SOURCE)
	pdflatex $(SOURCE)
	pdflatex $(SOURCE)

clean:
	rm -f *.aux *.log *.bbl *.out *.blg *.*~ main.pdf *~
