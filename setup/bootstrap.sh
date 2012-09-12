#!/bin/bash

function cur_os {
    # Make sure we have egrep
    EGREP_VER=`egrep --version | head -n 1`
    if [[ ! "$EGREP_VER" =~ "GNU grep" ]] ; then
        echo "egrep isn't installed, sorry."
        return 1
    fi

    # If we have /etc/issue then it's not OSX:
    if [[ -r '/etc/issue' ]] ; then
        # Run checks
        DEB_OS=`egrep -i 'Ubuntu|Debian' /etc/issue`
        RH_OS=`egrep -i 'CentOS|Red Hat' /etc/issue`
        if [[ ${#DEB_OS} -gt 0 ]] ; then
            CUR_OS="debian"
        elif [[ ${#RH_OS} -gt 0 ]] ; then
            CUR_OS="redhat"
        else
            CUR_OS="unknown"
        fi
    else
        unamestr=`uname`
        if [[ "$unamestr" =~ 'Darwin' ]]; then
            CUR_OS="osx"
        else
            CUR_OS="unknown"
        fi
    fi
    echo $CUR_OS
}

OS=`cur_os`

if [[ "$OS" == "debian" ]]
then
	echo 'Going with a Debian-style install'
	sudo apt-get install -y git \
        && git clone git://github.com/bedmondmark/dotfiles.git ~/.dotfiles \
	&& . ~/.dotfiles/setup/debian.sh \
	&& mkdir /tmp/dotfile_backups \
	&& mv ~/.bashrc ~/.profile /tmp/dotfile_backups \
	&& . ~/.dotfiles/install.sh
elif [[ "$OS" == "redhat" ]]
then
	echo 'Going with a Fedora-style install'
	sudo yum install -y git \
        && git clone git://github.com/bedmondmark/dotfiles.git ~/.dotfiles \
	&& . ~/.dotfiles/setup/fedora.sh \
	&& mkdir /tmp/dotfile_backups \
	&& mv ~/.bashrc ~/.profile /tmp/dotfile_backups \
	&& . ~/.dotfiles/install.sh
elif [[ "$OS" == "redhat" ]]
then
	echo 'Going with a OSX-style install'
	
	ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go) \
	&& brew install git \
        && git clone git://github.com/bedmondmark/dotfiles.git ~/.dotfiles \
	&& . ~/.dotfiles/setup/osx.sh \
	&& mkdir /tmp/dotfile_backups \
	&& mv ~/.bashrc ~/.profile /tmp/dotfile_backups \
	&& . ~/.dotfiles/install.sh
else
	echo "Don't know what the hell OS this is"
fi
