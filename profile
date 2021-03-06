#####################################################################
#
#                            .profile
#                                             (c) 2011-2013 tyabuta.
#####################################################################
echo "import .profile"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

#
# 端末間で、コマンド履歴をリアルタイムに同期する。
#
HISTSIZE=10000       # メモリ上の履歴件数
HISTFILESIZE=10000   # .bash_history に保存する履歴最大件数

function share_history {
    history -a  # .bash_historyに前回コマンドを１行追記
    history -c  # 端末ローカルの履歴を一旦消去
    history -r  # .bash_historyから履歴を読み込み直す。
}
PROMPT_COMMAND='share_history'  # share_history関数をプロンプト毎に自動実施
shopt -u histappend             # .bash_history追記モードは不要なのでOFFに

#
# <Ctrl+S> でbashコマンド履歴を前方検索できるよう、
# sttyの機能を抑制する。
#
stty stop undef


#
# X-Window Input Method用の設定
#
which ibus-daemon >/dev/null 2>&1
if [ 0 == $? ] ; then
    export XMODIFIERS=@im=ibus
    export GTK_IM_MODULE=ibus
    export QT_IM_MODULE=ibus
    ibus-daemon --daemonize --xim
fi


# -----------------------------------------------
# PATH設定
# -----------------------------------------------

PATH="/usr/local/bin:$PATH"

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


# -----------------------------------------------
# OS環境別設定
# -----------------------------------------------
UNAME=`uname`
if [ "Darwin" == "$UNAME" ]; then
    # Mac用
    alias ls="ls -G"
    alias la="ls -a"
    export CLICOLOR=1
    export LSCOLORS=CxGxcxdxCxegedabagacad

#elif [ $UNAME = "Linux" ]; then
    # Linux用
fi


#
# rbenv
#
if which rbenv > /dev/null 2>&1; then eval "$(rbenv init -)"; fi

# -----------------------------------------------
# functions
# -----------------------------------------------


# パターンにマッチするファイルの指定キーワードを検索する
# file-grep <FileName-RegExp> <Keyword-RegExp>
function file-grep(){
  local filename=$1
  local keyword=$2
  find ./ -iname "$filename" | xargs grep "$keyword"
}

# ファイル名検索をおこなう
# file-find <Keyword>
function file-find(){
  local keyword=$1
  find ./ -iname "$keyword"
}

#
# プロセス表示関数
#
proc() {
    # 引数なしなら、すべてのプロセスを表示する。
    ! ps aux | grep "$1" && ps aux
}

#
# grep -i <RegEx> [File]
#
search-regex(){
    if [ "" == "$1" ]; then
        echo "usage: search-regex <RegEx> [File]"
    else
        grep -i "$1" "$2"
    fi
}

#
# PATHが一致するファイルを出力する。
# find . -iname <FileName>
#
search-file-with-name(){
    if [ "" == "$1" ]; then
        echo "usage: search-file-with-name <FileName>"
    else
        find . -iname "$1"
    fi
}

#
# PATHが正規表現にマッチするファイルを出力する。
# find . -iname <RegEx>
#
search-file-with-regex(){
    if [ "" == "$1" ]; then
        echo "usage: search-file-with-regex <RegEx>"
    else
        find . -regex "$1"
    fi
}

#
# テキストファイルのエンコードをUTF-8に変換する。
# nkf -w <Source> <Output>
#
encode-utf8(){
    if [ "" == "$1" -o "" == "$2" ]; then
        echo "usage: encode-utf <Source> <Output>"
    else
        nkf -w "$1" > "$2"
    fi
}

#
# 環境変数PATHに新しいPathを通す。
#
path-insert(){
    if [ "" == "$1" ]; then
        echo "udage: path-insert <Path>"
    else
        export PATH="$1:$PATH"
    fi
}


# -----------------------------------------------
# alias設定
# -----------------------------------------------
alias cls="clear"
if [[ "$(uname)" =~ "CYGWIN" ]]; then
    alias ls="ls -h --color=tty"
fi
alias la="ls -la"
alias rmf="rm -Rf"
alias vimsudo="sudo -H vim"
alias desktop="cd ~/Desktop"
alias dotfiles="cd ~/dotfiles"
alias download="curl -L -O"

# diff -u -b
alias diff="diff --unified --ignore-space-change"


# tmux のセッションを呼び出す。
# 起動していない場合はセッション作成を行う。
alias tmux="! tmux a > /dev/null 2>&1 && tmux > /dev/null 2>&1 "

alias wgetall="wget --recursive --no-clobber --page-requisites --html-extension --convert-links --no-parent"

# -----------------------------------------------
# Git関係
# -----------------------------------------------

# ステージングしたワークツリーとのdiffを表示する。
alias git-diff-cached="git diff --cached"

# git submodule init/update を兼ねたクローン
alias git-clone="git clone --recursive"

# 全てのブランチを表示
alias git-branches="git branch -a"

# git submoduleの更新を行う。
alias git-submodules-update="git submodule foreach 'git pull origin master'"

#
# カレントディレクトリのリポジトリ用にGitWebを立ち上げる。
# デーモンを停止させる時は、git-instaweb stop とする。
#
alias git-instaweb="git  instaweb --http=webrick"

# git commit の省略
git-commit(){
    if [ "" != "$1" ]; then
        git commit -m "$1"
    else
        git commit
    fi
}


