# Aliases:
alias grep="grep --color"
if [ "$OS" =  "osx" ]; then
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

# du - sorted by size:
alias dus="du -hs * | gsort -h"

# Git aliases
alias ga='git add'
alias gco='git checkut'
alias gpull='git pull --rebase'
alias gpush='git push'
alias gl='git log'
alias gd='git diff'
alias gs='git status'
alias p='python'


if [[ `which ack-grep 2> /dev/null` != "" ]]; then
    alias ack='ack-grep'
fi

if [[ `which hub 2> /dev/null` != "" ]]; then
    alias git='hub'
fi
