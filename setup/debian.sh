#!/bin/bash
sudo apt-get -y install openssh-server openssh-client ack-grep bash-completion vim python-pip tree \
&& sudo pip install -U distribute pip virtualenv virtualenvwrapper bpython ipython awscli
