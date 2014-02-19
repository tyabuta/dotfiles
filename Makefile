
FILES=vim vimrc gvimrc minttyrc profile screenrc tmux.conf tmux-osx.conf
LINK=ln -snf

all: $(foreach f,$(FILES),link-$(f))

link-%: %
	$(LINK) $(CURDIR)/$< $(HOME)/.$<

unlink-%: %
	$(RM) $(HOME)/.$<

