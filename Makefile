#!/usr/bin/make -f
# https://stackoverflow.com/questions/7123241/makefile-as-an-executable-script-with-shebang
ECHOCMD:=/bin/echo -e

# The main latex file
THESIS_MAIN_FILE   = modelo-ufsc-main.tex

# This will be the pdf generated
THESIS_OUTPUT_NAME   = thesis

# This is the folder where the temporary files are going to be
CACHE_FOLDER = setup/cache

# GNU Make silent by default
# https://stackoverflow.com/questions/24005166/gnu-make-silent-by-default
MAKEFLAGS += --silent
.PHONY: clean

# Default target
all: thesis


##
## Usage:
##   make <target>
##
## Targets:
##   all               generate all assets
##   thesis            build the `$THESIS_MAIN_FILE` to the `$THESIS_OUTPUT_NAME` file
##   verbose           build the `$THESIS_MAIN_FILE` to the `$THESIS_OUTPUT_NAME` file with maximum output logs
##

# Print the usage instructions
# https://gist.github.com/prwhite/8168133
help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'


TEST_SRCS:=$(wildcard *.tex)
TEST_PDFS:=$(TEST_SRCS:.tex=.pdf)


#LATEX:=lualatex --time-statistics --shell-escape -interaction=batchmode
#LATEX:=pdflatex --time-statistics --shell-escape -interaction=batchmode
#LATEX:=pdflatex --time-statistics --synctex=1 -interaction=nonstopmode
LATEX:=pdflatex --time-statistics --shell-escape --synctex=1 --interaction=batchmode\
-output-directory="$(CACHE_FOLDER)" -aux-directory="$(CACHE_FOLDER)"\
-jobname="$(THESIS_OUTPUT_NAME)"

thesis: $(TEST_PDFS)

%.pdf: %.tex

	# Creates the shell variable `current_dir` within the current folder path
	$(eval current_dir := $(shell pwd)) echo $(current_dir) > /dev/null

	@$(LATEX) $<
	cp $(CACHE_FOLDER)/$(THESIS_OUTPUT_NAME).pdf $(current_dir)/$(THESIS_OUTPUT_NAME).pdf


# Using Makefile to clean subdirectories
# https://stackoverflow.com/questions/26007005/using-makefile-to-clean-subdirectories
#
# Exclude directory from find . command
# https://stackoverflow.com/questions/4210042/exclude-directory-from-find-command
GARBAGE_TYPES := "*.gz(busy)" *.aux *.log *.pdf *.aux *.bbl *.log *.out *.toc *.dvi *.blg\
*.synctex.gz *.fdb_latexmk *.fls *.lot *.lol *.lof *.idx

DIRECTORIES_TO_CLEAN  := $(shell find -not -path "./.git**" -not -path "./pictures**" -type d)
GARBAGE_TYPED_FOLDERS := $(foreach DIR, $(DIRECTORIES_TO_CLEAN), $(addprefix $(DIR)/,$(GARBAGE_TYPES)))

clean:
	rm -rfv $(GARBAGE_TYPED_FOLDERS)

# veryclean:
# 	git clean -dxf

thesis_verbose: $(THESIS_MAIN_FILE)

	# Creates the shell variable `current_dir` within the current folder path
	$(eval current_dir := $(shell pwd)) echo $(current_dir) > /dev/null

	# What is the difference between “-interaction=nonstopmode” and “-halt-on-error”?
	# https://tex.stackexchange.com/questions/258814/what-is-the-difference-between-interaction-nonstopmode-and-halt-on-error
	#
	# What reasons (if any) are there for compiling in interactive mode?
	# https://tex.stackexchange.com/questions/25267/what-reasons-if-any-are-there-for-compiling-in-interactive-mode
	latexmk \
	-pdf \
	-jobname="$(THESIS_OUTPUT_NAME)" \
	-output-directory="$(CACHE_FOLDER)" \
	-aux-directory="$(CACHE_FOLDER)" \
	-pdflatex="pdflatex --synctex=1 --interaction=nonstopmode" \
	-use-make $(THESIS_MAIN_FILE)

	# Copy the generated PDF file from the cache folder
	cp $(CACHE_FOLDER)/$(THESIS_OUTPUT_NAME).pdf $(current_dir)/$(THESIS_OUTPUT_NAME).pdf
