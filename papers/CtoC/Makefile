.SUFFIXES: .tex .pdf

all: CtoC.pdf


define WRAP
INPUT_$(1)=$(wildcard $(1)*.tex)
.PHONY: $(1).pdf

$(1).pdf: $$(INPUT_$(1):%.tex=%.pdf)
$$(INPUT_$(1):%.tex=%.pdf): $$(INPUT_$(1)) heading.tex
	xelatex -shell-escape -interaction=nonstopmode $$<
endef

LECTURES=CtoC

$(foreach i,$(LECTURES),$(eval $(call WRAP,$(i)) ) )

clean:
	@$(RM) -r _minted* 
	@$(RM) *.aux *.log *.nav *.out *.snm *.toc

cleanminted:
	@$(RM) -r _minted* *.pdf

