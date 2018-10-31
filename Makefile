.PHONY: fin

final: pandoc --filter pandoc-citeproc --bibliography=paper.bib --variable classoption=twocolumn --variable papersize=a4paper -s paper.md -o paper.pdf