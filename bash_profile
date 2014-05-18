#####################################################################
#
#                         .bash_profile
#                                             (c) 2011-2014 tyabuta.
#####################################################################
echo "import .bash_profile"

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# -----------------------------------------------
# PATH設定
# -----------------------------------------------
PATH="/usr/local/bin:$PATH"
PATH="$HOME/local/bin:$PATH"

# Heroku
if [ -d "/usr/local/heroku/bin" ] ; then
    export PATH="/usr/local/heroku/bin:$PATH"
fi

# ~/Dropbox/bin
if [ -d "$HOME/Dropbox/bin" ] ; then
    PATH="$HOME/Dropbox/bin:$PATH"
fi

# ~/ScriptTools
if [ -d "$HOME/ScriptTools" ] ; then
    PATH="$HOME/ScriptTools:$PATH"
fi

# ~/bin
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export PATH



# -----------------------------------------------
# rbenv
# -----------------------------------------------
if which rbenv > /dev/null 2>&1; then eval "$(rbenv init -)"; fi

