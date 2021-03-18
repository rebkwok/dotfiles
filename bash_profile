# .bash_profile


# User specific environment and startup programs

PATH=$PATH:$HOME/bin

# Setting PATH for Python
# The original version is saved in .bash_profile.pysave
PATH=$(pyenv root)/shims:$PATH
export PATH

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi


export PATH
