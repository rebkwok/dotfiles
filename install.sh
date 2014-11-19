#!/bin/bash

ln -s ~/.dotfiles/bashrc ~/.bashrc
ln -s ~/.dotfiles/bash_profile ~/.bash_profile
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/gitignore ~/.gitignore
ln -s ~/.dotfiles/hushlogin ~/.hushlogin

if [[ ! -e ~/bin ]]; then
	ln -s ~/.dotfiles/bin ~/bin
fi

ln -s ~/.dotfiles/vimrc ~/.vimrc
if [[ ! -e ~/.vim ]]; then
	ln -s ~/.dotfiles/vim ~/.vim
fi

#-----------------------------------------------------------------------------
# Link all binaries into ~/bin
#-----------------------------------------------------------------------------

dotfiles_home=${HOME}/.dotfiles

# If using the old symlink ~/bin -> ~/.dotfiles/bin, delete and replace:
if [ -L ~/bin ] && [ $(readlink ~/bin) == "${dotfiles_home}/bin" ]; then
    echo 'Removing ~/bin symlink'
    rm ~/bin &&  mkdir ~/bin
fi

for f in $(ls ${dotfiles_home}/bin); do
    ln -s "${dotfiles_home}/bin/$f" "${HOME}/bin"
done


