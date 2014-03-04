
FILES   = bashrc bash_profile vim vimrc gvimrc minttyrc screenrc tmux.conf tmux-osx.conf
LINK    = ln -snf

all: $(foreach f,$(FILES),install-$(f))

link-%: %
	$(LINK) $(CURDIR)/$< $(HOME)/.$<

unlink-%: %
	$(RM) $(HOME)/.$<


BAKDATE = $(shell date +%Y%m%d-%s)
backup-%: %
	cp $(HOME)/.$< $(HOME)/.$<.bak$(BAKDATE) 2>&1 | /dev/null

install-%: %
	cp $(HOME)/.$< $(HOME)/.$<.bak$(BAKDATE) 2>&1 | /dev/null
	$(LINK) $(CURDIR)/$< $(HOME)/.$<

#
# git-config
#
VIMPATH        = $(shell readlink -f $(shell which vim))
GIT_USER_NAME  = $(shell read -p "user.name: " answer; echo $$answer)
GIT_USER_EMAIL = $(shell read -p "user.email: " answer; echo $$answer)
git-config:
	git config --global user.name   "$(GIT_USER_NAME)"
	git config --global user.email  "$(GIT_USER_EMAIL)"
	git config --global core.editor "$(VIMPATH)"
	git config --global color.ui "auto"

