
DOT_FILES = .vimrc .vim .tmux.conf

all: vim tmux

tmux: $(foreach f, $(filter .tmux%, $(DOT_FILES)), link-dot-file-$(f))

vim: $(foreach f, $(filter .vim%, $(DOT_FILES)), link-dot-file-$(f))
	  
clean: $(foreach f, $(DOT_FILES), unlink-dot-file-$(f))
	  

link-dot-file-%: %
	@echo "Create Symlink $< => $(HOME)/$<"
	@ln -snf $(CURDIR)/$< $(HOME)/$<

unlink-dot-file-%: %
	@echo "Remove Symlink $(HOME)/$<"
	@$(RM) $(HOME)/$<


