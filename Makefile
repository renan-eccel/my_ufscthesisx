#!/usr/bin/make -f
# https://stackoverflow.com/questions/7123241/makefile-as-an-executable-script-with-shebang
ECHOCMD:=/bin/echo -e

# The main latex file
THESIS_MAIN_FILE = main

# This will be the pdf generated
THESIS_OUTPUT_NAME = thesis

# This is the folder where the temporary files are going to be
CACHE_FOLDER = setup/cache

# Find all files ending with `main.tex`
LATEX_SOURCE_FILES := $(wildcard *main.tex)

# Create a new variable within all `LATEX_SOURCE_FILES` file names ending with `.pdf`
LATEX_PDF_FILES := $(LATEX_SOURCE_FILES:.tex=.pdf)


# GNU Make silent by default
# https://stackoverflow.com/questions/24005166/gnu-make-silent-by-default
MAKEFLAGS += --silent
.PHONY: all help biber start_timer biber_hook pdflatex_hook1 pdflatex_hook2 latex thesis verbose clean

# How do I write the 'cd' command in a makefile?
# http://stackoverflow.com/questions/1789594/how-do-i-write-the-cd-command-in-a-makefile
.ONESHELL:

# Default target
all: thesis


##
## Usage:
##   make <target>
##
## Targets:
##   all        call the `thesis` make rule
##   biber      build the main file with bibliography pass
##   latex      build the main file with no bibliography pass
##   thesis     completely build the main file with minimum output logs
##   verbose    completely build the main file with maximum output logs
##   clean      remove all cache folders and generated pdf files
##   veryclean  same as `clean`, but searches for all generated files outside
##              the cache folders.
##

# Print the usage instructions
# https://gist.github.com/prwhite/8168133
help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'


# Where to find official (!) and extended documentation for tex/latex's commandline options (especially -interaction modes)?
# https://tex.stackexchange.com/questions/91592/where-to-find-official-and-extended-documentation-for-tex-latexs-commandlin
PDF_LATEX_COMMAND = pdflatex --time-statistics --synctex=1 -halt-on-error -file-line-error
LATEX =	$(PDF_LATEX_COMMAND)\
--interaction=batchmode\
-output-directory="$(CACHE_FOLDER)"\
-aux-directory="$(CACHE_FOLDER)"


# Run pdflatex, biber, pdflatex
biber: start_timer biber_hook pdflatex_hook2

	# Creates the shell variable `current_dir` within the current folder path
	$(eval current_dir := $(shell pwd)) echo $(current_dir) > /dev/null

	# Copies the PDF to the current folder
	cp $(CACHE_FOLDER)/$(THESIS_MAIN_FILE).pdf $(current_dir)/$(THESIS_OUTPUT_NAME).pdf

	# Calculate the elapsed seconds and print them to the screen
	. ./setup/scripts/timer_calculator.sh
	showTheElapsedSeconds "$(current_dir)"


start_timer:

	# Start counting the elapsed seconds to print them to the screen later
	. ./setup/scripts/timer_calculator.sh


# Internally called rule which does not attempt to show the elapsed time
biber_hook:

	# Creates the shell variable `current_dir` within the current folder path
	$(eval current_dir := $(shell pwd)) echo $(current_dir) > /dev/null

	# Enters to the thesis folder to build the files
	cd ./$(THESIS_FOLDER)

	# Call biber to process the bibliography
	echo "Running biber quietly..."

	# https://www.mankier.com/1/biber --debug
	biber --quiet --input-directory="$(CACHE_FOLDER)" --output-directory="$(CACHE_FOLDER)" $(THESIS_MAIN_FILE).bcf


# How to call Makefile recipe/rule multiple times?
# https://stackoverflow.com/questions/46135614/how-to-call-makefile-recipe-rule-multiple-times
pdflatex_hook1 pdflatex_hook2:

	@$(LATEX) $(LATEX_SOURCE_FILES)


# This rule will be called for every latex file and pdf associated
latex: $(LATEX_PDF_FILES)

	# Creates the shell variable `current_dir` within the current folder path
	$(eval current_dir := $(shell pwd)) echo $(current_dir) > /dev/null

	# Calculate the elapsed seconds and print them to the screen
	. ./setup/scripts/timer_calculator.sh
	showTheElapsedSeconds "$(current_dir)"


# Dynamically generated recipes for all PDF and latex files
%.pdf: %.tex

	# Start counting the compilation time and import its shell functions
	. ./setup/scripts/timer_calculator.sh

	# Creates the shell variable `current_dir` within the current folder path
	$(eval current_dir := $(shell pwd)) echo $(current_dir) > /dev/null

	@$(LATEX) $<
	cp $(CACHE_FOLDER)/$(THESIS_MAIN_FILE).pdf $(current_dir)/$(THESIS_OUTPUT_NAME).pdf


# MAIN LATEXMK RULE
#
# -pdf tells latexmk to generate PDF directly (instead of DVI).
#
# -pdflatex="" tells latexmk to call a specific backend with specific options.
#
# -use-make tells latexmk to call make for generating missing files. When after a run of latex or
# pdflatex, there are warnings about missing files (e.g., as requested by the LaTeX \input,
# \include, and \includgraphics commands), latexmk tries to make them by a custom dependency. If no
# relevant custom dependency with an appropriate source file is found, and if the -use-make option
# is set, then as a last resort latexmk will try to use the make program to try to make the missing
# files.
#
# -interaction=nonstopmode keeps the pdflatex backend from stopping at a missing file reference and
# interactively asking you for an alternative.
#
# https://www.ctan.org/pkg/latexmk
# http://docs.miktex.org/manual/texfeatures.html#auxdirectory
thesis:

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
	--pdf \
	--silent \
	--output-directory="$(CACHE_FOLDER)" \
	--aux-directory="$(CACHE_FOLDER)" \
	--pdflatex="$(PDF_LATEX_COMMAND) --interaction=batchmode" \
	$(THESIS_MAIN_FILE).tex

	# Copy the generated PDF file from the cache folder
	cp $(CACHE_FOLDER)/$(THESIS_MAIN_FILE).pdf $(current_dir)/$(THESIS_OUTPUT_NAME).pdf

	# Calculate the elapsed seconds and print them to the screen
	showTheElapsedSeconds "$(current_dir)"


verbose:

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
	--pdf \
	--output-directory="$(CACHE_FOLDER)" \
	--aux-directory="$(CACHE_FOLDER)" \
	--pdflatex="$(PDF_LATEX_COMMAND) --interaction=nonstopmode" \
	$(THESIS_MAIN_FILE).tex

	# Copy the generated PDF file from the cache folder
	cp $(CACHE_FOLDER)/$(THESIS_MAIN_FILE).pdf $(current_dir)/$(THESIS_OUTPUT_NAME).pdf

	# Calculate the elapsed seconds and print them to the screen
	showTheElapsedSeconds "$(current_dir)"


clean:
	$(RM) -rv $(CACHE_FOLDER)
	$(RM) -v $(THESIS_OUTPUT_NAME).pdf


# Using Makefile to clean subdirectories
# https://stackoverflow.com/questions/26007005/using-makefile-to-clean-subdirectories
#
# Exclude directory from find . command
# https://stackoverflow.com/questions/4210042/exclude-directory-from-find-command
GARBAGE_TYPES := "*.gz(busy)" *.aux *.log *.aux *.bbl *.log *.out *.toc *.dvi *.blg\
*.synctex.gz *.fdb_latexmk *.fls *.lot *.lol *.lof *.idx *.bcf *.mw *.run.xml

DIRECTORIES_TO_CLEAN  := $(shell /bin/find -not -path "./**.git**" -not -path "./pictures**" -type d)
GARBAGE_TYPED_FOLDERS := $(foreach DIR, $(DIRECTORIES_TO_CLEAN), $(addprefix $(DIR)/,$(GARBAGE_TYPES)))

veryclean:
	$(RM) -v $(GARBAGE_TYPED_FOLDERS)


