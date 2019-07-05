# Usage: make TARGET=handan rundish

SYSPATH   ?= ../../
HSPCMP    := $(SYSPATH)/hspcmp
HSP3DISH  := $(SYSPATH)/hsp3dish
HSP3CL    := $(SYSPATH)/hsp3cl
COMPATH   := $(SYSPATH)/common/
SYSPATH   := $(SYSPATH)/

.SUFFIXES: .hsp .ax

.hsp.ax:
	$(HSPCMP) -d -i -u --compath=$(COMPATH) $<

run: $(TARGET).ax
	$(HSPCMP) --syspath=$(SYSPATH) -e $<

rundish: $(TARGET).ax
	$(HSP3DISH) $<

runcl: $(TARGET).ax
	$(HSP3CL) $<

.PHONY: clean
clean:
	-rm -rf $(TARGET).ax
