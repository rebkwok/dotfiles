#!/bin/bash
sudo apt-get -y install openssh-server openssh-client ack bash-completion vim python-pip \
&& sudo pip install -U distribute pip virtualenv virtualenvwrapper bpython ipython
