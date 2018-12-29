.DEFAULT_GOAL := build
CXX       ?= c++
CRAMOPTS  ?= --shell=zsh
CRAM_ROOT ?= cram
CRAM_PATH ?= $(CRAM_ROOT)

PREFIX   ?= /usr/local
LIBDIR   ?= $(DESTDIR)$(PREFIX)/lib
BINDIR   ?= $(DESTDIR)$(PREFIX)/bin
MANDIR   ?= $(DESTDIR)$(PREFIX)/man/man1

BROOTDIR   = _build
BLIBDIR    = $(BROOTDIR)/lib
BBINDIR    = $(BROOTDIR)/bin
BMANDIR    = $(BROOTDIR)/man/man1

DIRS = $(BLIBDIR) $(BBINDIR)

CMDS     = $(patsubst src/xdgenv/%.zsh,%,$(wildcard src/xdgenv/*))
MANS     = $(patsubst Documentation/%.rst,%.1,$(wildcard Documentation/xdgenv*))

BUILD_DEPS  =
BUILD_DEPS += $(BMANDIR)
BUILD_DEPS += $(BBINDIR)/xdgenv
BUILD_DEPS += $(addprefix $(BBINDIR)/xdgenv-,$(CMDS))
BUILD_DEPS += $(addprefix $(BMANDIR)/,$(MANS))

INSTALL_DEPS += $(MANDIR)
INSTALL_DEPS += $(BINDIR)/xdgenv
INSTALL_DEPS += $(addprefix $(BINDIR)/xdgenv-,$(CMDS))
INSTALL_DEPS += $(addprefix $(MANDIR)/,$(MANS))

CHECK_PATH = $(CURDIR)/$(BROOTDIR)/fakeroot/usr/local/bin:$(PATH)

.PHONY: build
build: $(BUILD_DEPS)

$(BBINDIR)/xdgenv-%: src/xdgenv/%.zsh

	install -m755 -D $< $@

$(BBINDIR)/xdgenv: src/xdgenv.zsh

	install -m755 -D $< $@

$(BMANDIR):

	install -d $@

$(BMANDIR)/%.1: Documentation/%.rst

	rst2man $< $@

.PHONY: install
install: $(INSTALL_DEPS)

.PHONY: install-home
install-home:

	$(MAKE) install PREFIX=$(HOME)/.local

$(BINDIR)/%: $(BBINDIR)/%

	install -m755 -D $< $@

$(MANDIR):

	install -d $@

$(MANDIR)/%: $(BMANDIR)/%

	install -m644 $< $@

.PHONY: clean
clean:

	$(RM) -r $(BROOTDIR) $(CRAM_ROOT)/*.t.err

.PHONY: check
check: build

	mkdir -p $(BROOTDIR)/fakeroot
	DESTDIR=$(BROOTDIR)/fakeroot $(MAKE) install
	env -i PATH=$(CHECK_PATH) cram $(CRAMOPTS) $(CRAM_PATH)
