#!/usr/bin/env bash
# *******************************************************************
#
#               dotfiles のインストールスクリプト
#
#                                                  (c) 2013 tyabuta.
# *******************************************************************


# バックアップ用のディレクトリ
backup_dir=$HOME/.dotfiles.backup


# --- Func ---

# -------------------------------------------------------------------
# 指定ファイルをbackupディレクトリに複製する。
# $1: コピーするファイル
# -------------------------------------------------------------------
function backup(){
    src=$HOME/$1
    dst=$backup_dir/$1
    [ ! -d $backup_dir ] && mkdir $backup_dir
    [ -e $src ] && cp $src $dst && echo "backup $dst"
}

# -------------------------------------------------------------------
# dotfilesディレクトリ内にあるファイルからリンクを張る。
# $1: リンクさせるファイル
# -------------------------------------------------------------------
function link(){
    src="$PWD/$1"
    dst="$HOME/.$1"
    [ -e "$src" ] && ln -snf "$src"   "$dst" && echo "link $dst"
}

# -------------------------------------------------------------------
# dotfilesディレクトリ内にあるファイルからリンクを張る。
# $1: リンク元のファイル名
# $2: リンク先のファイル名
# -------------------------------------------------------------------
function link2(){
    src="$PWD/$1"
    dst="$HOME/$2"
    [ -e "$src" ] && ln -snf "$src"   "$dst" && echo "link $dst"
}



# --- Main ---

# ファイルのバックアップ
echo "Begin to backup files."
backup .profile
backup .tmux.conf
backup .vimrc
backup .vim
backup .emacs.d
backup .bashrc
backup .bash_profile
backup .minttyrc


# リンクを張る
echo "Beginning to make link files."
link profile
link vimrc
link vim
link emacs.d

if [[ "$(uname)" =~ "CYGWIN" ]]; then
    link minttyrc
fi

if [ "Darwin" = "$(uname)" ]; then
    link2 tmux-osx.conf .tmux.conf
else
    link tmux.conf
fi

# 不要なファイルを削除する。
# 環境によっては .profile が呼ばれなくなる為、.bashrc .bash_profile を削除。
rm -f $HOME/.bashrc
rm -f $HOME/.bash_profile

exit 0

