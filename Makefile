BR_VERSION := 2018.02.2
BR_BASEDIR := buildroot-$(BR_VERSION)
BR_TARBALL := $(BR_BASEDIR).tar.bz2
BR_URL     := https://buildroot.org/downloads/$(BR_TARBALL)

all:
.PHONY: all

BR_LOCALMK := $(strip $(wildcard $(CURDIR)/local.mk))
ifneq ($(BR_LOCALMK),)
BR_LOCALMK := $(BR_BASEDIR)/local.mk
endif

BR_PATCHES := $(wildcard $(CURDIR)/patches/*.patch)
ifneq ($(BR_PATCHES),)
BR_PATCHED := $(BR_BASEDIR)/.patched
BR_PATCHES := $(sort $(realpath $(BR_PATCHES)))
endif

ifeq ($(strip $(MAKECMDGOALS)),)
MAKECMDGOALS := all
endif

br2-info = printf '[1;1mBR2 %s[0;0m: %s\n'


$(filter-out mrproper,$(MAKECMDGOALS)): $(BR_BASEDIR)/Makefile $(BR_LOCALMK) $(BR_PATCHED)
	@$(MAKE) --no-print-directory -C $(BR_BASEDIR) BR2_EXTERNAL=$(CURDIR) $(MAKECMDGOALS)

$(BR_BASEDIR)/Makefile: $(BR_TARBALL)
	@$(br2-info) Unpack $(<F)
	@test -d $(@D) && rm -rf $(@D) || true
	@mkdir $(@D)
	@bunzip2 -c $< | tar --strip-components=1 -xf - -C $(@D)
	@test -L output || ln -sf $(@D)/output output
	@touch $@

$(BR_PATCHED): $(BR_BASEDIR)/Makefile
	@cd $(@D) $(foreach P,$(BR_PATCHES), && $(br2-info) Patch $(notdir $P) && patch -s -f -p1 -i $P)
	@touch $@

$(BR_TARBALL): SHA512
	@$(br2-info) Fetch $(BR_URL)
	@wget -O $@ -c $(BR_URL)
	@$(br2-info) Check $(@F)
	@sha512sum -c SHA512
	@touch $@

ifeq ($(BR_LOCALMK),)
_ := $(shell $(RM) $(BR_BASEDIR)/local.mk)
else
$(BR_LOCALMK): local.mk
	@$(br2-info) Link $(@F)
	@ln -sf $(realpath $<) $@
	@touch $@
endif

mrproper:
	$(RM) -r skel/*
	$(RM) -r $(BR_BASEDIR)
	$(RM) output

.PHONY: mrproper
