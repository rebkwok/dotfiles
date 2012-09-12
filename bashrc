# .bashrc
echo bashrc

PATH=$PATH:$HOME/bin
export PATH

source .dotfiles/lib/detect.sh

OS=`cur_os`

if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

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
export PS1="[${SEQ}\$(if [[ \`whoami\` == 'root' ]]; then echo -n '31;1m'; else echo -n '0m'; fi;)${END}\u${SEQ}0m${END}@${SEQ}1;33m${END}\h${SEQ}0m${END} ${SEQ}1;35m${END}\w${SEQ}0m${END}]$ "

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

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'$*'*' -ls ; }

# Import dev and devhome commands:
source ~/.dotfiles/lib/dev_support.sh

# Alias mvim to gvim
if [ -f /usr/local/bin/mvim ]; then
    alias gvim=mvim
fi

if [ $OS == "osx" ]; then
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

    alias myip="ifconfig | egrep 'inet ' | sed -En '/inet 127/d;s/.* ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+) .*/\1/g;p'"


    # Git autocomplete:
    [ -f /usr/local/git/contrib/completion/git-completion.bash ] && . /usr/local/git/contrib/completion/git-completion.bash
fi
