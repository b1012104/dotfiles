#!/bin/zsh

dotdir=dotfiles
dotfiles=(.vim .vimrc .zshrc .tmux.conf)

function usage()
{
    echo "Usage: $0 [clean]"
}

function do_clean()
{
    for dotfile in ${dotfiles}
    do
        if [ -e $HOME/${dotfile} ]; then
            unlink $HOME/${dotfile}
        fi
    done
}

function do_link()
{
    for dotfile in ${dotfiles}
    do
        if [ ! -e $HOME/${dotfile} ]; then
            ln -s $HOME/${dotdir}/${dotfile} $HOME/${dotfile}
        fi
    done
}

cd

if [ $# -eq 0 ]; then
    do_link
    exit 0
fi

for arg in $@
do
    case $arg in
        link)
            do_link
            exit 0
            ;;
        clean)
            do_clean
            exit 0
            ;;
    esac
done
