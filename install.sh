#!/usr/bin/env bash

# バックアップ用のディレクトリ
backup_dir=$HOME/.dotfiles.backup

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


# ファイルのバックアップ
echo "Begin to backup files."
backup .profile
backup .tmux.conf
backup .vimrc
backup .vim
backup .emacs.d

# リンクを張る
echo "Beginning to make link files."
link profile
link tmux.conf
link vimrc
link vim
link emacs.d

exit 0

