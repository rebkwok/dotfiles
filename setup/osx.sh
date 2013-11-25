#!/bin/bash

PYTHON=/usr/local/bin/python

brew install ack bash-completion python \
&& sudo pip install -U distribute pip virtualenv virtualenvwrapper bpython ipython awscli \
&& brew install macvim
