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
alias gadd='git add'
alias gcom='git commit'
alias gco='git commit'
alias gpull='git pull --rebase'
alias gpush='git push'
alias gl='git log'
alias gd='git diff'

alias glog='gl'
alias gs='git status'
alias gstat='gs'
alias ga='gadd'
alias gcm='gcom'
alias p='python'
alias p3='python3'


# Mercurial aliases
alias hbrev='hg bookmark --rev'
alias horig='hg purge -I **/*.orig --all'
alias hd='hg diff'
alias ha='hg add'
alias hlogb='hg log --limit 10 --only-branch'
alias houtb='hg outgoing -b'
alias hpushb='hg push -b'

if [ -f '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' ]; then
    alias browser='open -a "Google Chrome.app"'
fi

if [[ `which ack-grep 2> /dev/null` != "" ]]; then
    alias ack='ack-grep'
fi

if [[ `which hub 2> /dev/null` != "" ]]; then
    alias git='hub'
fi
