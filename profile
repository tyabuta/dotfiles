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
if [ `which ibus-daemon` ] ; then
    export XMODIFIERS=@im=ibus
    export GTK_IM_MODULE=ibus
    export QT_IM_MODULE=ibus
    ibus-daemon --daemonize --xim
fi


# -----------------------------------------------
# PATH設定
# -----------------------------------------------

PATH="/usr/local/bin:$PATH"

# ~/Dropbox/bin
if [ -d "$HOME/Dropbox/bin" ] ; then
    PATH="$HOME/Dropbox/bin:$PATH"
fi

# ~/bin
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi


# -----------------------------------------------
# OS環境別設定
# -----------------------------------------------
UNAME=`uname`
if [ $UNAME = "Darwin" ]; then
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

# プロセス
proc() {
    ! ps aux | grep $1 && ps aux 
}

# git commit の省略
commit(){
    if [ "" != "$1" ]; then
        git commit -m "\"$1\""
    else
        git commit 
    fi
}


# -----------------------------------------------
# alias設定
# -----------------------------------------------
alias cls="clear"
alias la="ls -la"
alias rmf="rm -Rf"
alias vimsudo="sudo -H vim"

# Dropbox内にあるbinディレクトリのコマンド一覧を出力する。
alias list="ls ~/Dropbox/bin/"

# tmux のセッションを呼び出す。
# 起動していない場合はセッション作成を行う。
alias tmux="! tmux a > /dev/null 2>&1 && tmux > /dev/null 2>&1 "

alias wgetall="wget --recursive --no-clobber --page-requisites --html-extension --convert-links --no-parent"

# -----------------------------------------------
# Git関係
# -----------------------------------------------

# git submodule init/update を兼ねたクローン
alias git-clone="git clone --recursive"

# masterリポジトリのプッシュ
alias git-push="git push origin master"

# 全てのブランチを表示
alias git-branches="git branch -a"

# git submoduleの更新を行う。
alias git-submodules-update="git submodule foreach 'git pull origin master'"

#
# カレントディレクトリのリポジトリ用にGitWebを立ち上げる。
# デーモンを停止させる時は、git-instaweb stop とする。
#
alias git-instaweb="git  instaweb --http=webrick"


