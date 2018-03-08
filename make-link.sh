#!/usr/bin/env bash
# *******************************************************************
#      dotfiles の指定ファイルをHOMEディレクトリにリンクをはる。
#                                                  (c) 2016 tyabuta.
# *******************************************************************

# -------------------------------------------------------------------
# dotfilesディレクトリ内にあるファイルからリンクを張る。
# $1: リンクさせるファイル
# -------------------------------------------------------------------
function link(){
    src="$PWD/$1"
    dst="$HOME/.$1"
    [ -e "$src" ] && ln -snf "$src"   "$dst" && echo "link to $dst"
}


file="$1"
if [ ! -f "$file" ]; then
    echo "usage: cmd <FILE>"
    exit 1
fi

link $1

