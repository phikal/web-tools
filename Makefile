#############
# constants #
#############

SSH_TARGET = bateleur:/var/www/html/

#############
# variables #
#############

GAL = infog faces wallp selfm etc
DOC = cheat
GIT = ReGeX doji nbody wastat emacs.d web-tools # 0bwm bft

#############################
# automatically found files #
#############################

GALFILE  := $(GAL:%=md/gal/%.md)
DOCFILE  := $(DOC:%=md/doc/%.md)
GITDIR   := $(GIT:%=www/git/%.git/)
DOCDIR   != find ./www/pdf/ -type f
GALDIR   != find ./www/img/ -type f
ITMPDIR  := $(GALDIR:./www/img/%=./www/tmb/img/%)
DTMPDIR  := $(DOCDIR:./www/pdf/%.pdf=./www/tmb/pdf/%.png)
MARKDOWN != find ./md/ -type f -name "*.md"
TXTS     != find ./md/txt/ -type f -name "*.md" -and -not -name index.md
HTML     := $(MARKDOWN:./md/%.md=./www/%.html)
MDDIR    != find ./md/ -type d
HTMLDIR  := $(MDDIR:./md/%=./www/%)
TRFILES  != find www/files -not -name index.html

##################
# default target #
##################

all: markdown www/files/index.html www/txt/atom.xml www/emacs.d.html sync

################################
# actually existing filesystem #
################################

$(HTML): ./www/%.html: ./md/%.md head.html tail.html
	sed "$$(awk '/^# / { sub(/^# /, ""); if ($$0) { print "s^%TITLE%^" $$0 "^"; d=1 } } END { if (!d) print "s/%TITLE%/~phi/" }' $<)" head.html > $@
	cmark --smart $< >> $@
	cat tail.html >> $@

$(HTMLDIR): ./www/%: ./md/%
	@mkdir -p $@

$(GALFILE): gal.tsv
	awk -v section=$(@:md/gal/%.md=%)	-f bin/grid.awk $<	> $@

$(ITMPDIR):
	convert $(@:www/tmb/img/%=www/img/%) \
		-alpha off                       \
		-unsharp 0.25x0.25+8+0.065       \
		-interlace none                  \
		-ordered-dither o8x8             \
		-filter Lanczos                  \
		-quality 50                      \
		-auto-level                      \
		-strip -thumbnail 200x200\>      \
		-compose CopyOpacity $@

$(DOCFILE): doc.tsv
	awk -v section=$(@:md/doc/%.md=%)	-f bin/grid.awk $<	> $@

$(DTMPDIR):
	mutool draw -o $@ -F png -r 50 -w 200 -h 200 $(@:www/tmb/pdf/%.png=www/pdf/%.pdf) 1
	optipng -silent -strip all -o6 $@

www/git/index.html: $(GIT:%=www/git/%)
	stagit-index $(GIT:%=www/git/%.git/) > $@

www/files/index.html: $(TRFILES)
	tree -I index.html -T files -H /files --dirsfirst -F -D --du -h -Q -C -o $@ $<
	sed -i '/GENERATOR/a<style>body{ margin: 0.5em; }</style>' $@
	sed -i '/GENERATOR/a<link rel="stylesheet" href="/normalize.css" />' $@
	sed -i '/GENERATOR/a<meta name="viewport" content="width=device-width" />' $@
	sed -i '/GENERATOR/a<meta name="referrer" content="none" />' $@

www/txt/atom.xml: $(TXTS)
	awk -f bin/blog.awk $^ | \
		sort -k2nr | sed 20q | \
		awk -f bin/atom.awk > $@

www/emacs.d.html: ~/.emacs.d/conf.org
	emacs -nw -Q --script ./bin/exconf.el

$(GIT:%=www/git/%): $(GIT:%=www/git/%.git)
	[ ! -d $@ ] && mkdir $@
	stagit -c .cache -C $@ $@.git
	ln -f www/git/style.css $@/style.css
	ln -f www/git/logo.png $@/logo.png
	ln -f $@/log.html $@/index.html

##########
# pseuds #
##########

markdown: $(HTMLDIR) $(HTML) head.html tail.html

update-git: # can take a while
	@for f in $(GIT:%=www/git/%.git)
	@do
	@cd $$f
	git fetch -v
	git gc
	@git gc
	@cd ../../..
	@done

stagit: $(GIT:%=www/git/%) www/git/index.html

git: update-git stagit

ggal: $(GALFILE) $(ITMPDIR)

gdoc: $(DOCFILE) $(DTMPDIR)

files: www/files/index.html

clean:
	rm -f www/tmb/pdf/* www/tmb/img/* www/index.html www/gal/* www/doc/*
	@for f in $(GALFILE)
	@do
	@rm -f $$f
	@done
	@for f in $(DOCFILE)
	@do
	rm -f $$f
	@done
	rm -f $(HTML)

sync:
	rsync -vtruhlHW --partial --delete www/ ${SSH_TARGET}

###########
# options #
###########

.PHONY: all markdown update-git git ggal gdoc clean sync
.TARGET: all
.ONESHELL:
