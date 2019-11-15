.DEFAULT_GOAL := build
CXX       ?= c++

cramopts  ?= --shell=zsh
cram_root ?= cram
cram_path ?= $(cram_root)

prefix   ?= /usr/local
libdir   ?= $(DESTDIR)$(prefix)/lib
bindir   ?= $(DESTDIR)$(prefix)/bin
mandir   ?= $(DESTDIR)$(prefix)/man/man1

brootdir   = _build
blibdir    = $(brootdir)/lib
bbindir    = $(brootdir)/bin
bmandir    = $(brootdir)/man/man1

dirs = $(blibdir) $(bbindir)

cmds     = $(patsubst src/xdgenv/%.zsh,%,$(wildcard src/xdgenv/*))
mans     = $(patsubst Documentation/%.rst,%.1,$(wildcard Documentation/xdgenv*))

build_deps  =
build_deps += $(bmandir)
build_deps += $(bbindir)/xdgenv
build_deps += $(addprefix $(bbindir)/xdgenv-,$(cmds))
build_deps += $(addprefix $(bmandir)/,$(mans))

install_deps += $(mandir)
install_deps += $(bindir)/xdgenv
install_deps += $(addprefix $(bindir)/xdgenv-,$(cmds))
install_deps += $(addprefix $(mandir)/,$(mans))

check_path = $(CURDIR)/$(brootdir)/fakeroot/usr/local/bin:$(PATH)

.PHONY: build
build: $(build_deps)

$(bbindir)/xdgenv-%: src/xdgenv/%.zsh

	install -m755 -D $< $@

$(bbindir)/xdgenv: src/xdgenv.zsh

	install -m755 -D $< $@

$(bmandir):

	install -d $@

$(bmandir)/%.1: Documentation/%.rst

	rst2man $< $@

.PHONY: install
install: $(install_deps)

$(bindir)/%: $(bbindir)/%

	install -m755 -D $< $@

$(mandir):

	install -d $@

$(mandir)/%: $(bmandir)/%

	install -m644 $< $@

.PHONY: clean
clean:

	$(RM) -r $(brootdir) $(cram_root)/*.t.err

.PHONY: check
check: build

	mkdir -p $(brootdir)/fakeroot
	DESTDIR=$(brootdir)/fakeroot $(MAKE) install
	env -i PATH=$(check_path) cram $(cramopts) $(cram_path)
