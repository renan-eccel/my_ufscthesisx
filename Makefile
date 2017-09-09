#!/usr/bin/make -f
# https://stackoverflow.com/questions/7123241/makefile-as-an-executable-script-with-shebang
ECHOCMD:=/bin/echo -e

# The main latex file
THESIS_MAIN_FILE = modelomain.tex

# This will be the pdf generated
THESIS_OUTPUT_NAME = thesis

# This is the folder where the temporary files are going to be
CACHE_FOLDER = setup/cache

# GNU Make silent by default
# https://stackoverflow.com/questions/24005166/gnu-make-silent-by-default
MAKEFLAGS += --silent
.PHONY: clean

# How do I write the 'cd' command in a makefile?
# http://stackoverflow.com/questions/1789594/how-do-i-write-the-cd-command-in-a-makefile
.ONESHELL:

# Default target
all: thesis_verbose


##
## Usage:
##   make <target>
##
## Targets:
##   all               generate all assets
##   thesis            build the `$THESIS_MAIN_FILE` to the `$THESIS_OUTPUT_NAME` file with no bibliography pass
##   verbose           build the `$THESIS_MAIN_FILE` to the `$THESIS_OUTPUT_NAME` file with maximum output logs
##

# Print the usage instructions
# https://gist.github.com/prwhite/8168133
help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'


TEST_SRCS:=$(wildcard *main.tex)
TEST_PDFS:=$(TEST_SRCS:.tex=.pdf)

#
# Where to find official (!) and extended documentation for tex/latex's commandline options (especially -interaction modes)?
# https://tex.stackexchange.com/questions/91592/where-to-find-official-and-extended-documentation-for-tex-latexs-commandlin
#
#LATEX:=lualatex --time-statistics --shell-escape -interaction=batchmode
#LATEX:=pdflatex --time-statistics --shell-escape -interaction=batchmode
#LATEX:=pdflatex --time-statistics --synctex=1 -interaction=nonstopmode
PDF_LATEX_COMMAND = pdflatex --time-statistics --synctex=1 -halt-on-error -file-line-error
LATEX =	$(PDF_LATEX_COMMAND)\
--interaction=batchmode\
-jobname="$(THESIS_OUTPUT_NAME)"\
-output-directory="$(CACHE_FOLDER)"\
-aux-directory="$(CACHE_FOLDER)"



thesis: $(TEST_PDFS)

%.pdf: %.tex

	# Start counting the compilation time and import its shell functions
	. ./setup/scripts/timer_calculator.sh

	# Creates the shell variable `current_dir` within the current folder path
	$(eval current_dir := $(shell pwd)) echo $(current_dir) > /dev/null

	@$(LATEX) $<
	cp $(CACHE_FOLDER)/$(THESIS_OUTPUT_NAME).pdf $(current_dir)/$(THESIS_OUTPUT_NAME).pdf

	# Calculate the elapsed seconds and print them to the screen
	showTheElapsedSeconds "$(current_dir)"


# Using Makefile to clean subdirectories
# https://stackoverflow.com/questions/26007005/using-makefile-to-clean-subdirectories
#
# Exclude directory from find . command
# https://stackoverflow.com/questions/4210042/exclude-directory-from-find-command
GARBAGE_TYPES := "*.gz(busy)" *.aux *.log *.pdf *.aux *.bbl *.log *.out *.toc *.dvi *.blg\
*.synctex.gz *.fdb_latexmk *.fls *.lot *.lol *.lof *.idx

DIRECTORIES_TO_CLEAN  := $(shell /bin/find -not -path "./**.git**" -not -path "./pictures**" -type d)
GARBAGE_TYPED_FOLDERS := $(foreach DIR, $(DIRECTORIES_TO_CLEAN), $(addprefix $(DIR)/,$(GARBAGE_TYPES)))

clean:
	rm -rfv $(GARBAGE_TYPED_FOLDERS)

# veryclean:
# 	git clean -dxf

thesis_verbose: $(THESIS_MAIN_FILE)

	# Start counting the compilation time and import its shell functions
	. ./setup/scripts/timer_calculator.sh

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
	-pdflatex="$(PDF_LATEX_COMMAND) --interaction=nonstopmode" \
	-use-make $(THESIS_MAIN_FILE)

	# Copy the generated PDF file from the cache folder
	cp $(CACHE_FOLDER)/$(THESIS_OUTPUT_NAME).pdf $(current_dir)/$(THESIS_OUTPUT_NAME).pdf

	# Calculate the elapsed seconds and print them to the screen
	showTheElapsedSeconds "$(current_dir)"


