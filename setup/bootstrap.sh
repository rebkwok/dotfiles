#!/bin/bash

function cur_os {
    # If we have /etc/issue then it's not OSX:
    if [[ -r '/etc/issue' ]] ; then
        # Make sure we have egrep
        EGREP_VER=`egrep --version | head -n 1`
        if [[ ! "$EGREP_VER" =~ "GNU grep" ]] ; then
	    echo "egrep isn't installed, sorry."
	    return 1
        fi

        # Run checks
        DEB_OS=`egrep -i 'Ubuntu|Debian' /etc/issue`
        RH_OS=`egrep -i 'CentOS|Red Hat|Fedora' /etc/issue`
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

if [ $DEBUG ];
then
    CLONE='cp -r /dotfiles .dotfiles'
else
    CLONE='git clone git://github.com/rebkwok/dotfiles.git ~/.dotfiles'
fi

now=$(date +"%Y-%m-%d-%s")
BACKUP_DIR="/tmp/dotfile_backups.$now"

function backup {
    for src in $@; do
        if [ -f $src ]; then
            echo 'backing up' $src to $BACKUP_DIR/$(basename $src)
        fi
    done
    exit
}

if [[ "$OS" == "debian" ]]
then
	echo 'Going with a Debian-style install'
	sudo apt-get install -y git \
        &&  $CLONE \
	&& . ~/.dotfiles/setup/debian.sh \
	&& mkdir $BACKUP_DIR \
    && backup ~/.bashrc ~/.profile ~/.bash_profile \
	&& . ~/.dotfiles/install.sh
elif [[ "$OS" == "redhat" ]]
then
	echo 'Going with a Fedora-style install'
	sudo yum install -y git \
        && $CLONE \
	&& . ~/.dotfiles/setup/fedora.sh \
	&& mkdir $BACKUP_DIR \
    && backup ~/.bashrc ~/.profile ~/.bash_profile \
	&& . ~/.dotfiles/install.sh
elif [[ "$OS" == "osx" ]]
then
	echo 'Going with a OSX-style install'
	
	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)" \
	&& brew install git \
        && $CLONE \
	&& . ~/.dotfiles/setup/osx.sh \
	&& mkdir $BACKUP_DIR \
    && backup ~/.bashrc ~/.profile ~/.bash_profile \
	&& . ~/.dotfiles/install.sh
else
	echo "Don't know what the hell OS this is"
fi
