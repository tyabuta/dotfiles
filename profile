# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

echo "Load: .profile"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi





#####################################################################
# 端末間で、コマンド履歴をリアルタイムに同期する。
#####################################################################
HISTSIZE=10000       # メモリ上の履歴件数
HISTFILESIZE=10000   # .bash_history に保存する履歴最大件数

function share_history {
    history -a  # .bash_historyに前回コマンドを１行追記
    history -c  # 端末ローカルの履歴を一旦消去
    history -r  # .bash_historyから履歴を読み込み直す。
}
PROMPT_COMMAND='share_history'  # share_history関数をプロンプト毎に自動実施
shopt -u histappend             # .bash_history追記モードは不要なのでOFFに


#####################################################################
# <Ctrl+S> でbashコマンド履歴を前方検索できるよう、
# sttyの機能を抑制する。
#####################################################################
stty stop undef


#####################################################################
# X-Window Input Method用の設定
#####################################################################
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
ibus-daemon --daemonize --xim



#####################################################################
# alias設定
#####################################################################
if [ -d "$HOME/homedrive/work" ] ; then
    alias work='cd ~/homedrive/work'
fi



#####################################################################
# OS環境別設定
#####################################################################
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

