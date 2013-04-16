#!/usr/bin/env bash


# リンクファイルを削除
rm "$HOME/.profile"   > /dev/null 2>&1
rm "$HOME/.tmux.conf" > /dev/null 2>&1
rm "$HOME/.vimrc"     > /dev/null 2>&1
rm "$HOME/.vim"       > /dev/null 2>&1

# バックアップに保管していたファイルを配置
[ -d ./backup ] && cp ./backup/.* $HOME/ > /dev/null 2>&1

exit 0


