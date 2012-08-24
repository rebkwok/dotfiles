# .bashrc

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

