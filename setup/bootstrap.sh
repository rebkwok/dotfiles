#!/bin/bash

if [ `which apt-get` ]
then
	echo 'Going with a Debian-style install'
	sudo apt-get install -y git \
        && git clone git://github.com/bedmondmark/dotfiles.git ~/.dotfiles \
	&& . ~/.dotfiles/setup/debian.sh \
	&& mkdir /tmp/dotfile_backups \
	&& mv ~/.bashrc ~/.profile /tmp/dotfile_backups \
	&& . ~/.dotfiles/install.sh
elif [ `which yum` ]
then
	echo 'Going with a Fedora-style install'
	sudo yum install -y git \
        && git clone git://github.com/bedmondmark/dotfiles.git ~/.dotfiles \
	&& . ~/.dotfiles/setup/fedora.sh \
	&& mkdir /tmp/dotfile_backups \
	&& mv ~/.bashrc ~/.profile /tmp/dotfile_backups \
	&& . ~/.dotfiles/install.sh
else
	echo "Don't know what the hell OS this is"
fi
