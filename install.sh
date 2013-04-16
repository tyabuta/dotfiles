#!/usr/bin/env bash


#
# 指定ファイルをbackupディレクトリに複製する。
# $1: コピーするファイル
#
function backup(){
    [ ! -d ./backup ] && mkdir ./backup
    [ -e $HOME/$1 ] && cp $HOME/$1 ./backup/
}



# ファイルのバックアップ
echo "Begin to backup files."
backup .profile
backup .tmux.conf
backup .vimrc
backup .vim


# リンクを張る
echo "Create link files."
ln -snf "$PWD/profile" "$HOME/.profile"
ln -snf "$PWD/tmux.conf" "$HOME/.tmux.conf"
ln -snf "$PWD/vimrc" "$HOME/.vimrc"
ln -snf "$PWD/vim" "$HOME/.vim"

exit 0

