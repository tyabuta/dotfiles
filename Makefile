


usage:
	@echo "make [all-link | link-<File> | unlink-<File> | backup-<File> | install-<File>]"
	@echo "make [git-config]"
	@echo "make [template-mine]"


# -----------------------------------------------
# link
# -----------------------------------------------
FILES   = bashrc bash_profile vim vimrc gvimrc minttyrc screenrc tmux.conf tmux-osx.conf
LINK    = ln -snf

all-link: $(foreach f,$(FILES),install-$(f))

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

# -----------------------------------------------
# git
# -----------------------------------------------
VIMPATH        = $(shell readlink -f $(shell which vim))
GIT_USER_NAME  = $(shell read -p "user.name: " answer; echo $$answer)
GIT_USER_EMAIL = $(shell read -p "user.email: " answer; echo $$answer)

git-config:
	git config --global user.name   "$(GIT_USER_NAME)"
	git config --global user.email  "$(GIT_USER_EMAIL)"
	git config --global core.editor "$(VIMPATH)"
	git config --global color.ui "auto"
	git config --global core.whitespace cr-at-eol


# -----------------------------------------------
# template
# -----------------------------------------------
template-mine:
	cat ./skeleton/minerc >> ./minerc



