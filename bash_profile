#####################################################################
#
#                         .bash_profile
#                                             (c) 2011-2014 tyabuta.
#####################################################################
echo "import .bash_profile"

# -----------------------------------------------
# プラットフォーム判定
# -----------------------------------------------
PLATFORM='unknown'
unamestr=`uname`
if [[ 'Linux' == "$unamestr" ]]; then
    PLATFORM='linux'
    if [ -f /etc/debian_version ]; then
        PLATFORM='debian'
    fi
elif [[ 'FreeBSD' == "$unamestr" ]]; then
    PLATFORM='freebsd'
elif [[ 'cygwin' == "$OSTYPE" ]]; then
    PLATFORM='cygwin'
fi

echo "platform: $PLATFORM"
export PLATFORM


# -----------------------------------------------
# カスタム用環境変数
# -----------------------------------------------

# defaults
export WORKDIR="$HOME/Desktop"
export VIM_TABSIZE=4

# minerc
if [ -f $HOME/dotfiles/minerc ]; then
    source $HOME/dotfiles/minerc
fi

# -----------------------------------------------
# bashrc
# -----------------------------------------------
if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
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

