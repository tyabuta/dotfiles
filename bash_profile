#####################################################################
#
#                         .bash_profile
#                                             (c) 2011-2014 tyabuta.
#####################################################################
echo "import .bash_profile"

export LANG=ja_JP.UTF-8

# -----------------------------------------------
# プラットフォーム判定
# -----------------------------------------------
PLATFORM='unknown'
unamestr=`uname`
if [[ 'Linux' == "$unamestr" ]]; then
    PLATFORM='linux'
    if [ -f /etc/debian_version ]; then
        PLATFORM='debian'
    elif [ -f /etc/redhat-release ]; then
        PLATFORM='centos'
    fi
elif [[ 'FreeBSD' == "$unamestr" ]]; then
    PLATFORM='freebsd'
elif [[ 'cygwin' == "$OSTYPE" ]]; then
    PLATFORM='cygwin'
fi

echo "platform: $PLATFORM"
export PLATFORM


# -----------------------------------------------
# cygwin用の設定
# -----------------------------------------------
if [[ 'cygwin' == "$PLATFORM" ]]; then
    # DOSのファイルPATHを使用したときに警告を出さない
    export CYGWIN="nodosfilewarning"
fi


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

# node_modules
if [ -d "$HOME/node_modules/.bin" ]; then
    PATH="$HOME/node_modules/.bin:$PATH"
fi

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
# cocos2d-x設定
# -----------------------------------------------

COCOS_CONSOLE_ROOT="$HOME/Dropbox/lib/cocos2d-x-3.2/tools/cocos2d-console/bin"
if [ -d "$COCOS_CONSOLE_ROOT" ]; then
    export COCOS_CONSOLE_ROOT
    export PATH=$COCOS_CONSOLE_ROOT:$PATH
else
    unset COCOS_CONSOLE_ROOT
fi


# -----------------------------------------------
# rbenv
# -----------------------------------------------
if which rbenv > /dev/null 2>&1; then eval "$(rbenv init -)"; fi








