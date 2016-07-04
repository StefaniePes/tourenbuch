# Makefile for Tourenbuch
#

.PHONY: register beschreibung.tex hoehenprofil.tex

SEASON=winter2016
PROJECTROOT=/Users/ull/sport/tourenbuch/

# elevation profile
GPXPLOT=meta/gpxplot.py

# pandoc options
PANDOCFLAGS=--from markdown+tex_math_dollars \
            --template=$(PROJECTROOT)meta/tourenbuch.template

# get the last two directories
CWD=$(shell basename $(shell dirname $(shell pwd)))/$(shell basename $(shell pwd))

all: tourenbuch

skitour:
	cp -r $(PROJECTROOT)meta/vorlagen/skitour/* .

gpxdata.txt:
	python $(PROJECTROOT)$(GPXPLOT) input.gpx > $@

hoehenprofil.tex: gpxdata.txt
	gnuplot hoehenprofil.plt

beschreibung.tex:
	pandoc $(PANDOCFLAGS) beschreibung.md -o $@

register:
# variable assignment is fine; but in ifeq not?!
# $(eval REGISTERED:=$(shell grep -q $(CWD)/beschreibung $(PROJECTROOT)meta/$(SEASON).tex; echo $$?))
# use this instead
ifeq ($(shell grep -q $(CWD)/beschreibung $(PROJECTROOT)meta/$(SEASON).tex; echo $$?),1)
	$(shell echo \\include{$(CWD)/beschreibung} >> $(PROJECTROOT)meta/$(SEASON).tex)
	@echo "$(CWD) registered in $(SEASON).tex"
else
	@echo "$(CWD) already registered in $(SEASON).tex"
endif

tourenbuch: beschreibung.tex hoehenprofil.tex register
	cd $(PROJECTROOT); \
	pdflatex $(PROJECTROOT)tourenbuch.tex -output-directory $(PROJECTROOT)



