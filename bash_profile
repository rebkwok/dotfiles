# .bash_profile

# User specific environment and startup programs
PATH=$PATH:$HOME/bin
PATH=$PATH:/usr/local/share/npm/bin
export PATH

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
