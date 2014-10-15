# .bash_profile


# User specific environment and startup programs
PATH=$PATH:$HOME/bin
PATH=$PATH:/usr/local/share/npm/bin
PATH="$PATH:/usr/local/heroku/bin"

GOPATH="$HOME/Documents/Development/go"
GOROOT="/usr/local/go"
PATH="$PATH:$GOPATH/bin"

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 

export PATH
export GOPATH
export GOROOT
