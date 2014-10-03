#!/bin/bash

PYTHON=/usr/local/bin/python

brew install ack bash-completion python ssh-copy-id\
&& sudo pip install -U distribute pip virtualenv virtualenvwrapper bpython ipython awscli \
&& brew install macvim

# Install Homebrew Cask:
brew tap phinze/cask \
&& brew install brew-cask && (
    # Essentials:
    brew cask install iterm2 google-chrome keepassx dropbox 

    # Utilities:
    brew cask install adium calibre caffeine cyberduck flux tor-browser transmission truecrypt vlc

    # Dev Tools:
    brew cask install pycharm-pro diffmerge virtualbox vagrant

    # Graphics:
    brew cask install xquartz inkscape gimp

    # Quick Look Plugins:
    brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch
    brew cask install quicklook-csv betterzipql webp-quicklook suspicious-package
)
