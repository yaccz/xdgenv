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

distdir = $(brootdir)/sdist
name := xdgenv
version := 0.1.0
vname := $(name)_$(version)

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
	env -i PATH=$(check_path) $(MAKE) sys-check

.PHONY: sys-check
sys-check:

	cram $(cramopts) $(cram_path)

.PHONY: sdist
sdist:

	mkdir -p $(distdir)
	git archive --format=tar.gz HEAD --prefix $(vname)/ -o $(distdir)/$(vname).tar.gz

.PHONY: deb
deb: clean sdist

	mkdir -p $(brootdir)/pkg/debian

	cp -a $(distdir)/$(vname).tar.gz ./$(brootdir)/pkg/debian/$(vname).orig.tar.gz
	cd ./$(brootdir)/pkg/debian && tar -xf $(vname).orig.tar.gz

	cp -a pkg/debian $(brootdir)/pkg/debian/$(vname)

	cd $(brootdir)/pkg/debian/$(vname) && debuild -us -uc
	test -f $(brootdir)/pkg/debian/$(vname)-0_all.deb

.PHONY: deb-check
deb-check:

	docker build --build-arg=VNAME="$(vname)" -t $(name):$(version) -f pkg/debian/Dockerfile .
	docker run $(name):$(version)
