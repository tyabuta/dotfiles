#!/bin/sh

PWD=`pwd`
COMMAND="$1"
case $COMMAND in
    clean)
        rm "$HOME/.profile"
        rm "$HOME/.tmux_conf"
        rm "$HOME/.vimrc"
        rm "$HOME/.vim"
        ;;
    *)
        ln -snf "$PWD/profile" "$HOME/.profile"
        ln -snf "$PWD/tmux.conf" "$HOME/.tmux.conf"
        ln -snf "$PWD/vimrc" "$HOME/.vimrc"
        ln -snf "$PWD/vim" "$HOME/.vim"
esac

