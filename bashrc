# .bashrc

PATH=$HOME/bin:$PATH
PATH=/Users/mark.smith/.gem/ruby/1.8/bin:$PATH
PATH=/usr/local/Cellar/ruby/2.0.0-p353/bin/:$PATH
PATH=/usr/local/share/npm/bin:$PATH:
export PATH

export EDITOR=vim

source ~/.dotfiles/lib/detect.sh

OS=`cur_os`

if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Ubuntu:
if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
fi

if [ -f ~/.local.sh ]; then
    . ~/.local.sh
fi

if [ -f ~/bin/fasd ]; then
    eval "$(~/bin/fasd --init auto)"
    alias v='f -e vim' # quick opening files with vim
fi

if [ -f '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' ]; then
    alias browser='open -a "Google Chrome.app"'
fi

# Set a prompt that goes red when logged-in as root:
SEQ="\[\033["
END="\]"
# PROMPT_COMMAND=un_color
#export PS1="[${SEQ}\$(if [[ \`whoami\` == 'root' ]]; then echo -n '31;1m'; else echo -n '0m'; fi;)${END}\u${SEQ}0m${END}@${SEQ}1;33m${END}\h${SEQ}0m${END} ${SEQ}1;35m${END}\w${SEQ}0m${END}]
#$ "

### Prompt Colors 
# Modified version of @gf3’s Sexy Bash Prompt 
# (https://github.com/gf3/dotfiles)
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
        export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
        export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
        tput sgr0
        if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
                BLACK=$(tput setaf 190)
                MAGENTA=$(tput setaf 9)
                ORANGE=$(tput setaf 172)
                GREEN=$(tput setaf 190)
                PURPLE=$(tput setaf 141)
                WHITE=$(tput setaf 0)
        else
                BLACK=$(tput setaf 190)
                MAGENTA=$(tput setaf 5)
                ORANGE=$(tput setaf 4)
                GREEN=$(tput setaf 2)
                PURPLE=$(tput setaf 1)
                WHITE=$(tput setaf 7)
        fi
        BOLD=$(tput bold)
        RESET=$(tput sgr0)
else
        BLACK="\033[01;30m"
        MAGENTA="\033[1;31m"
        ORANGE="\033[1;33m"
        GREEN="\033[1;32m"
        PURPLE="\033[1;35m"
        WHITE="\033[1;37m"
        BOLD=""
        RESET="\033[m"
fi

export BLACK
export MAGENTA
export ORANGE
export GREEN
export PURPLE
export WHITE
export BOLD
export RESET

# Git branch details
function parse_git_dirty() {
        [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}
function parse_git_branch() {
        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Change this symbol to something sweet. 
# (http://en.wikipedia.org/wiki/Unicode_symbols)
symbol="💩  "

export PS1="\[${BOLD}${MAGENTA}\]\u \[$WHITE\]in \[$GREEN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\n$symbol\[$RESET\]"
export PS2="\[$ORANGE\]→ \[$RESET\]"


### Misc

# Only show the current directory's name in the tab 
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'


# echo "OS = $OS"
# Bash options:
if [[ $SHELL == *bash ]]; then
    if [[ $OS ==  "osx" ]]; then
        shopt -s extglob nocaseglob
    else
        shopt -s globstar extglob autocd nocaseglob
    fi
fi

# Aliases:
alias grep="grep --color"
if [[ $OS ==  "osx" ]]; then
    alias ls="ls -G"
else
    alias ls="ls --color=auto"
fi
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias ..="cd .."
alias ...="cd ../.."
alias svnignore="svn propedit svn:ignore ."
alias curl_json="curl -H 'Accept: application/json'"

if [[ $(which ack-grep) ]]; then
    alias ack='ack-grep'
fi
# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'$*'*' -ls ; }

# Import dev and devhome commands:
source ~/.dotfiles/lib/dev_support.sh

if [ $OS == "osx" ]; then
    # Alias mvim to gvim
    if [ $(which mvim) ]; then
        alias gvim=mvim
    fi

    source $(brew --prefix)/bin/virtualenvwrapper.sh
    # echo 'mac'

    # Mac utility functions:

    # posd - output the dir of the forefront finder window
    function posd() {
        thePath="$( osascript<<END
        try
        tell application "Finder" to set the source_folder to (folder of the front window) as alias
        on error -- no open folder windows
        set the source_folder to path to desktop folder as alias
        end try

        set thePath to (POSIX path of the source_folder as string)
        set result to thePath
END
        )"



        if [[ -n "${thePath%/*}" ]]; then

            if [[ -d "$thePath" ]]; then
                echo "${thePath%/}"
            else 
                echo "${thePath%/*}"
            fi
        else 
            echo "/" 
        fi 
    }

    # CD to the foreground finder window directory:
    function cdf {
        cd "$(posd)"
        pwd
    }

    # Change foreground directory to current dir:
    function fdc {
        if [ -n "$1" ]; then
            if [ "${1%%/*}" = "" ]; then
                thePath="$1"
            else
                thePath=`pwd`"/$1"
            fi
        else
            thePath=`pwd`
        fi

        osascript<<END
        set myPath to ( POSIX file "$thePath" as alias )
        try
        tell application "Finder" to set the (folder of the front window) to myPath
        on error -- no open folder windows
        tell application "Finder" to open myPath
        end try
END
    }

    # Change both pwd and foreground finder window to dir:
    function cdd { command cd "$@" ; ( fdc >|/dev/null & ) }
      
    # OSX Stuff:
    #
    # Disable the Ping sidebar in iTunes
    defaults write com.apple.iTunes disablePingSidebar -bool true

    # Disable all the other Ping stuff in iTunes
    defaults write com.apple.iTunes disablePing -bool true

    # Enable Safari’s debug menu
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

    # Enable subpixel font rendering on non-Apple LCDs
    defaults write NSGlobalDomain AppleFontSmoothing -int 2

    # Disable the warning when changing a file extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

    # Enable AirDrop over Ethernet and on unsupported Macs running Lion
    defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

    alias myip="ifconfig | grep -e 'inet ' | sed -En '/inet 127/d;s/.* ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+) .*/\1/g;p'"

    if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    elif [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi

    # Git autocomplete:
    # TODO: This may not be necessary:
    [ -f $(brew --prefix)/git/contrib/completion/git-completion.bash ] \
        && . $(brew --prefix)/git/contrib/completion/git-completion.bash

fi

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Xmx1g'

source /usr/local/bin/virtualenvwrapper_lazy.sh

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Git aliases
alias gadd='git add'
alias gcom='git commit'
alias gpul='git pull --rebase'
alias gpus='git push'
alias gl='git lg'

export CHROME_BIN="/Applications/Google Chrome Beta.app/Contents/MacOS/Google Chrome"

# alias pirate='ssh -C2qTnN -D 9999 server & && /Applications/Firefox.app/Contents/MacOS/firefox -new-instance -safe-mode http://thepiratebay.se'
complete -C aws_completer aws

alias glog='gl'
alias gs='git status'
alias gstat='gs'

# Fix for vagrant not coming up after restart:
alias fix-vagrant='sudo /Library/StartupItems/VirtualBox/VirtualBox restart'

