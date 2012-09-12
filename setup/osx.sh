#!/bin/bash

PYTHON=/usr/local/bin/python

brew install ack bash-completion python \
&& curl http://python-distribute.org/distribute_setup.py | $PYTHON \
&& curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py | $PYTHON \
&& sudo pip install -U distribute pip virtualenv virtualenvwrapper bpython ipython
