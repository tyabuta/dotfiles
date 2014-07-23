#####################################################################
#
#                            .bashrc
#                                             (c) 2011-2014 tyabuta.
#####################################################################
echo "import .bashrc"

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi


# -----------------------------------------------
# ヒストリ設定
# -----------------------------------------------

# 重複コマンドを保存しない。
#HISTCONTROL=ignoredups

# 空白から始めたコマンドを保存しない。
#HISTCONTROL=ignorespace

# 空白から始めたコマンドと、重複コマンドを保存しない。
HISTCONTROL=ignoreboth


# メモリ上の履歴件数
HISTSIZE=10000

# .bash_history に保存する履歴最大件数
HISTFILESIZE=10000


# 端末間で、コマンド履歴をリアルタイムに同期する。
function share_history {
    history -a  # .bash_historyに前回コマンドを１行追記
    history -c  # 端末ローカルの履歴を一旦消去
    history -r  # .bash_historyから履歴を読み込み直す。
}
PROMPT_COMMAND='share_history'  # share_history関数をプロンプト毎に自動実施
shopt -u histappend             # .bash_history追記モードは不要なのでOFFに


# <Ctrl+S> でbashコマンド履歴を前方検索できるよう、sttyの機能を抑制する。
stty stop undef


# -----------------------------------------------
# bash_completion (補完機能強化)
# -----------------------------------------------
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


# -----------------------------------------------
# 端末設定
# -----------------------------------------------

# 端末サイズを自動認識
shopt -s checkwinsize


# -----------------------------------------------
# X-Window Input Method用の設定
# -----------------------------------------------
which ibus-daemon >/dev/null 2>&1
if [ 0 == $? ] ; then
    export XMODIFIERS=@im=ibus
    export GTK_IM_MODULE=ibus
    export QT_IM_MODULE=ibus
    ibus-daemon --daemonize --xim
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


# -----------------------------------------------
# functions
# -----------------------------------------------

# phpファイルのgrep検索
# php-file-grep <Keyword-RegExp>
function php-file-grep(){
  local keyword=$1
  find ./ -iname "*.php" | xargs grep -n "$keyword"
}

# カレントディレクトリ以下のファイル全てを対象に権限変更
# chmod-files <Permission>
function chmod-files(){
  local permission=$1
  find ./ -type f -print | xargs chmod --verbose $permission
}

# カレントディレクトリ以下のディレクトリ全てを対象に権限変更
# chmod-dirs <Permission>
function chmod-dirs(){
  local permission=$1
  find ./ -type d -print | xargs chmod --verbose $permission
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

alias ls="ls --color=auto"
if [[ "$(uname)" =~ "CYGWIN" ]]; then
    alias ls="ls -h --color=tty"
fi
alias la="ls -lha"
alias rmf="rm -Rf"
alias vimsudo="sudo -H vim"
alias desktop="cd ~/Desktop"
alias dotfiles="cd ~/dotfiles"
alias download="curl -L -O"
alias screenx="screen -xR"
alias top="top -d 5"
alias watch-ps-user='watch --interval=5 "ps ux"'

# diff -u -b
alias diff="diff --unified --ignore-space-change"


# tmux のセッションを呼び出す。
# 起動していない場合はセッション作成を行う。
alias tmux="! tmux a > /dev/null 2>&1 && tmux > /dev/null 2>&1 "

alias wgetall="wget --recursive --no-clobber --page-requisites --html-extension --convert-links --no-parent"

# -----------------------------------------------
# Git関係
# -----------------------------------------------

#export GIT_SSL_NO_VERIFY=true

alias git-status="git status"

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

alias git-checkout-patch="git checkout --patch"


# 変更・追加・削除ファイルを重複なしで列挙する
# git-log-change-files [--since=<Date>] [--author=<Author>]
function git-log-change-files(){
    options="$@"
    git log --name-status $options | grep -e "^[AMD]\b" | cut -f 2 | sort | uniq
}

function git-spull(){
    git stash
    git pull
    git stash pop
}

function setenv(){
    cd $WORKDIR
    screen -xR
}


