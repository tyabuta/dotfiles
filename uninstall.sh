#!/usr/bin/env bash


backup_dir=$HOME/.dotfiles.backup


# リンクファイルを削除
echo "Beginning to delete dotfiles."
rm "$HOME/.profile"   > /dev/null 2>&1
rm "$HOME/.tmux.conf" > /dev/null 2>&1
rm "$HOME/.vimrc"     > /dev/null 2>&1
rm "$HOME/.vim"       > /dev/null 2>&1
rm "$HOME/.emacs.d"   > /dev/null 2>&1

# バックアップに保管していたファイルを配置
[ -d $backup_dir ] && cp $backup_dir/.* $HOME/ > /dev/null 2>&1

exit 0


