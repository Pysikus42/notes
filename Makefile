rwildcard=$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))
tex_files = $(call rwildcard, , *.tex)
pdf_files = $(tex_files:.tex=.pdf)
clean_files = $(tex_files:.tex=.does_not_exist)

%.does_not_exist: %.tex
	latexmk -xelatex -cd -c -pdflatex="xelatex -8bit %O %S" $<	

%.pdf: %.tex
	latexmk -xelatex -cd --shell-escape -pdflatex="xelatex -8bit %O %S" $<	
	latexmk -xelatex -cd -c -pdflatex="xelatex -8bit %O %S" $<	

all: $(pdf_files)

.PHONY: clean clobber
clean: $(clean_files)
	find . -mindepth 2 -maxdepth 2 -name '*.pdf' -delete

clobber: $(clean_files)
