ROOTFILE=_slides

.PHONY: help clear clean show final quick

quick:
	indentex . -v
	- pdflatex --interaction=nonstopmode $(ROOTFILE).tex | \
	grep -inE --color=always "^\!.*" | cat

final: clear
	indentex . -v
	pdflatex --interaction=batchmode $(ROOTFILE).tex
	bibtex $(ROOTFILE).aux
	pdflatex --interaction=batchmode $(ROOTFILE).tex
	bibtex $(ROOTFILE).aux
	pdflatex --interaction=batchmode $(ROOTFILE).tex
	xdg-open $(ROOTFILE).pdf

show:
	xdg-open $(ROOTFILE).pdf

clean:
	find . -type f -name '*_indentex.tex' -delete
	find . -type f -name '*.aux' -delete
	find . -type f -name '*.bbl' -delete
	find . -type f -name '*.lot' -delete
	find . -type f -name '*.lof' -delete
	find . -type f -name '*.lol' -delete
	find . -type f -name '*.loa' -delete
	find . -type f -name '*.loe' -delete
	find . -type f -name '*.toc' -delete
	find . -type f -name '*.blg' -delete
	find . -type f -name '*.out' -delete
	find . -type f -name '*.log' -delete
	find . -type f -name '*.1' -delete
	find . -type f -name '*.mp' -delete
	find . -type f -name '*.synctex.gz' -delete
	find . -type f -name '*.preview.pdf' -delete

clear: clean
	find . -type f -name "$(ROOTFILE).pdf" -delete

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'
