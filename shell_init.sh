
PATH=$HOME/bin:$PATH
PATH=/usr/local/share/npm/bin:$PATH:
export PATH

export EDITOR=vim

. ~/.dotfiles/lib/detect.sh

OS=`cur_os`

if [ -f ~/.local.sh ]; then
    . ~/.local.sh
fi

if [ -f ~/bin/fasd ]; then
    eval "$(~/bin/fasd --init auto)"
    alias v='f -e vim' # quick opening files with vim
fi

# Set a prompt that goes red when logged-in as root:
SEQ="\[\033["
END="\]"
# PROMPT_COMMAND=un_color
#export PS1="[${SEQ}\$(if [ \`whoami\` == 'root' ]; then echo -n '31;1m'; else echo -n '0m'; fi;)${END}\u${SEQ}0m${END}@${SEQ}1;33m${END}\h${SEQ}0m${END} ${SEQ}1;35m${END}\w${SEQ}0m${END}]
#$ "

### Misc

# Only show the current directory's name in the tab 
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

if [ "$OS" = "osx" ]; then
    # Alias mvim to gvim
    if [ $(which mvim 2> /dev/null) ]; then
        alias gvim=mvim
    fi

    # OSX Stuff:
    #
    # Enable Safari’s debug menu
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

    # Enable subpixel font rendering on non-Apple LCDs
    defaults write NSGlobalDomain AppleFontSmoothing -int 2

    # Disable the warning when changing a file extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

    # Enable AirDrop over Ethernet and on unsupported Macs running Lion
    defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

    alias myip="ifconfig | grep -e 'inet ' | sed -En '/inet 127/d;s/.* ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+) .*/\1/g;p'"

    alias full_volume='osascript -e "set Volume 10"'
    alias silence='osascript -e "set Volume 0"'

    alias ting='full_volume && afplay ~/.dotfiles/sound/ting.wav'
    alias airhorn='full_volume && afplay ~/.dotfiles/sound/airhorn.wav'
    alias fail='full_volume && afplay ~/.dotfiles/sound/fail.wav'
fi

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Xmx1g'

if [ -f $(which virtualenvwrapper_lazy.sh 2> /dev/null) ]; then
    . $(which virtualenvwrapper_lazy.sh 2> /dev/null)
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# added by travis gem
[ -f /Users/mark/.travis/travis.sh ] && . /Users/mark/.travis/travis.sh

# Pyenv config
if which pyenv 2>&1 > /dev/null; then
    export PYENV_ROOT=/usr/local/opt/pyenv
    eval "$(pyenv init -)"
fi

GPG_TTY=$(tty)
export GPG_TTY

. ~/.dotfiles/aliases.sh
