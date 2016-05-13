# .bashrc

PATH=$HOME/bin:$PATH
PATH=/usr/local/share/npm/bin:$PATH:
export PATH

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/projects
source /usr/local/bin/virtualenvwrapper.sh

export EDITOR=vim

. ~/.dotfiles/lib/detect.sh

OS=`cur_os`

if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

# Source global definitions
if [[ -f /etc/bashrc ]]; then
    . /etc/bashrc
fi
# Ubuntu:
if [[ -f /etc/bash.bashrc ]]; then
    . /etc/bash.bashrc
fi

. ~/.dotfiles/shell_init.sh

if [[ -f ~/.local.sh ]]; then
    . ~/.local.sh
fi


### Prompt Colors 
# Modified version of @gf3’s Sexy Bash Prompt 
# (https://github.com/gf3/dotfiles)
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
        export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
        export TERM=xterm-256color
fi

if tput setaf 1 >/dev/null 2>1; then
        tput sgr0
        if [ $(tput colors) -ge 256 ] 2>/dev/null; then
                BLACK=$(tput setaf 190)
                MAGENTA=$(tput setaf 9)
                ORANGE=$(tput setaf 172)
                GREEN=$(tput setaf 2)
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

# Git branch details
function parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}
function parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Mercurial branch details
function hg_branch() {
    hg branch 2> /dev/null | awk '{print $1}'
}
function hg_bookmark() {
    hg bookmarks 2> /dev/null | awk '/\*/ { print $2 }'
}

# Change this symbol to something sweet.
# (http://en.wikipedia.org/wiki/Unicode_symbols)
symbol="➤ "

export PS1="\[${BOLD}${MAGENTA}\]\u \[$WHITE\]in "
export PS1="$PS1\[$GREEN\]\w\[$WHITE\]\$([[ -n \$((git branch 2> /dev/null) || (hg branch 2> /dev/null)) ]] && echo \" on \")"
export PS1="$PS1\[$PURPLE\]\$(parse_git_branch)\$([[ -n \$(git branch 2> /dev/null) ]] && echo \"(git) \")"
export PS1="$PS1\[$ORANGE\]\$(hg_branch)\$([[ -n \$(hg branch 2> /dev/null) ]] && echo \" (hg)\")\[$WHITE\]\$([[ -n \$(hg_bookmark) ]] && echo \" at \")\[$MAGENTA\]\$(hg_bookmark)"
export PS1="$PS1\[$WHITE\]\n$symbol\[$RESET\]"


### Misc

# Only show the current directory's name in the tab
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'
# Bash options:
if [ "$SHELL" = "/bin/bash" ]; then
    if [ "$OS" =  "osx" ]; then
        shopt -s extglob nocaseglob
    else
        shopt -s globstar extglob autocd nocaseglob
    fi
fi

# Import dev and devhome commands:
. ~/.dotfiles/lib/dev_support.sh

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
elif [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Aliases
. ~/.aliases.sh

# ----------------------------------------------------------------------------
# Port to zsh:
#
# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'$*'*' -ls ; }

# Import dev and devhome commands:
. ~/.dotfiles/lib/dev_support.sh
