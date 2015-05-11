#!/bin/zsh

dotdir=dotfiles
dotfiles=(.vim .vimrc .zshrc .tmux.conf)

function usage()
{
    echo "Usage: $0 [clean]"
}

function do_clean()
{
    rm -f ${dotfiles}
}

function do_link()
{
    for dotfile in ${dotfiles}
    do
        if [ ! -e ${dotfile} ]; then
            ln -s ${dotdir}/${dotfile} ${dotfile}
        fi
    done
    exit 0
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
