MAIN=whistle
.PHONY: all clean

all:
	xelatex -shell-escape $(MAIN).tex

clean:
	@$(RM) -r *.aux *.log $(MAIN).pdf *.synctex.gz
	@$(RM) -r _minted-*


