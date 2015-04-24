#!/bin/zsh

dotdir=dotfiles
dotfiles=(.vim .vimrc .zshrc .tmux.conf)
cd

#if [ $# -ge 1 && ${1} == "clean" ]; then
#if [ "$1" = "clean" ]; then
#	rm -f ${dotfiles}
#	exit 0
#fi

for arg in $@
do
	case $arg in
		clean) rm -f ${dotfiles} && exit 0;;
	esac
done

for dotfile in ${dotfiles}
do
	if [ ! -e ${dotfile} ]; then
		ln -s ${dotdir}/${dotfile} ${dotfile}
	fi
done
