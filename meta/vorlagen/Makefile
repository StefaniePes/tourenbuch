# Makefile for Tourenbuch
#

.PHONY: register beschreibung.tex elevation.tex marker

SEASON=sommer2016
PROJECTROOT=/Users/ull/gefahrengut/sport/tourenbuch/
LAYOUT=fullelevationhead

# elevation profile
GPXPLOT=meta/gpxplot.py

# pandoc options
PANDOCFLAGS=--from markdown+tex_math_dollars \
            --template=template.pandoc
            #--template=$(PROJECTROOT)meta/layout/$(LAYOUT).template.pandoc

# get the last two directories
CWD=$(shell basename $(shell dirname $(shell pwd)))/$(shell basename $(shell pwd))

all: tourenbuch

skitour:
	cp -r $(PROJECTROOT)meta/vorlagen/skitour/* .
	cp $(PROJECTROOT)meta/vorlagen/layout/skitour.$(LAYOUT).template.pandoc template.pandoc
mtb:
	cp -r $(PROJECTROOT)meta/vorlagen/mtb/* .
	cp $(PROJECTROOT)meta/vorlagen/layout/mtb.$(LAYOUT).template.pandoc template.pandoc

gpxdata.txt:
	python $(PROJECTROOT)$(GPXPLOT) input.gpx > $@

elevation.tex: gpxdata.txt
	gnuplot elevation.plt

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

marker:
ifdef TOP
	@sed -i bak -e '1,/TOP/s/TOP/$(TOP)/' elevation.plt
	$(info marked $(TOP) as heighest point in the elevation profile)
else
	sed -i bak -e '1,/# set label III/s/# set label III/set label $(I)/' elevation.plt
	sed -i bak -e '1,/NNN/s/NNN/$(N)/' elevation.plt
	sed -i bak -e '1,/XXX/s/XXX/$(X)/' elevation.plt
endif

tourenbuch: beschreibung.tex elevation.tex register
	cd $(PROJECTROOT); \
	pdflatex $(PROJECTROOT)tourenbuch.tex -output-directory $(PROJECTROOT)



