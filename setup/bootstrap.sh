#!/bin/bash

if [ `which apt-get` ]
then
	echo 'Going with a Debian-style install'
	sudo apt-get install -y curl git \
	&& curl -f -o /tmp/dotfiles_setup.sh https://raw.github.com/bedmondmark/dotfiles/master/setup/debian.sh \
	&& . /tmp/dotfiles_setup.sh \
        && git clone git://github.com/bedmondmark/dotfiles.git ~/.dotfiles \
	&& mkdir /tmp/dotfile_backups \
	&& mv ~/.bashrc ~/.profile /tmp/dotfile_backups \
	&& . ~/.dotfiles/install.sh
elif [ `which yum` ]
then
	echo 'Going with a Fedora-style install'
	yum install -y curl git \
	&& curl -f -o /tmp/dotfiles_setup.sh https://raw.github.com/bedmondmark/dotfiles/master/setup/fedora.sh \
	&& . /tmp/dotfiles_setup.sh \
        && git clone git://github.com/bedmondmark/dotfiles.git ~/.dotfiles \
	&& mkdir /tmp/dotfile_backups \
	&& mv ~/.bashrc ~/.profile /tmp/dotfile_backups \
	&& . ~/.dotfiles/install.sh
else
	echo "Don't know what the hell OS this is"
fi
