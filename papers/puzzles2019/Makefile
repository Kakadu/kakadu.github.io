.PHONY: debs
.SUFFIXES: .tex .pdf

TARGET=puzzles_talk
all: $(TARGET).pdf


define WRAP
INPUT_$(1)=$(wildcard $(1)*.tex)
.PHONY: $(1).pdf

$(1).pdf: $$(INPUT_$(1):%.tex=%.pdf)
$$(INPUT_$(1):%.tex=%.pdf): $$(INPUT_$(1)) heading.tex
	xelatex -shell-escape -interaction=nonstopmode $$<
endef

LECTURES=$(TARGET)

$(foreach i,$(LECTURES),$(eval $(call WRAP,$(i)) ) )

clean:
	@$(RM) -r _minted* 
	@$(RM) *.aux *.log *.nav *.out *.snm *.toc *.gz *.vrb

cleanminted:
	@$(RM) -r _minted* *.pdf

debs:
	sudo apt install texlive-lang-cyrillic fonts-cmu python3-pygments

