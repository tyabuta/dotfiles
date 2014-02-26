
FILES=bashrc bash_profile vim vimrc gvimrc minttyrc screenrc tmux.conf tmux-osx.conf
LINK=ln -snf
BAKDATE=$(shell date +%Y%m%d-%s)

all: $(foreach f,$(FILES),install-$(f))

link-%: %
	$(LINK) $(CURDIR)/$< $(HOME)/.$<

unlink-%: %
	$(RM) $(HOME)/.$<

backup-%: %
	cp $(HOME)/.$< $(HOME)/.$<.bak$(BAKDATE) 2>&1 | /dev/null

install-%: %
	cp $(HOME)/.$< $(HOME)/.$<.bak$(BAKDATE) 2>&1 | /dev/null
	$(LINK) $(CURDIR)/$< $(HOME)/.$<

