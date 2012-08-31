#!/bin/bash

ln -s ~/.dotfiles/bashrc ~/.bashrc
ln -s ~/.dotfiles/bash_profile ~/.bash_profile
ln -s ~/.dotfiles/gitconfig ~/.gitconfig

if [[ ! -e ~/bin ]]; then
	ln -s ~/.dotfiles/bin ~/bin
fi

ln -s ~/.dotfiles/vimrc ~/.vimrc
if [[ ! -e ~/.vim ]]; then
	ln -s ~/.dotfiles/vim ~/.vim
fi
