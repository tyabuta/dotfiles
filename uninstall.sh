#!/usr/bin/env bash

# リンクファイルを削除
rm "$HOME/.profile"
rm "$HOME/.tmux.conf"
rm "$HOME/.vimrc"
rm "$HOME/.vim"

# バックアップに保管していたファイルを配置
[ -d ./backup ] && cp ./backup/* $HOME/

exit 0


