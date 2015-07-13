# _dev_addhome key homedir
_dev_addhome()
{
    local key value
    key="$1"
    value="$2"
    awk '
    {
        pairs[$1]=$2;
    }
    END {
        pairs["'$key'"] = "'$value'";
        for (k in pairs) {
            print k, pairs[k];
        }
    }
    ' ~/.devhomes > ~/._devhomes \
        && mv ~/._devhomes ~/.devhomes
}

# _dev_gethome key -> homedir
_dev_gethome()
{
    key="$1"
    awk '{
        if ($1 == "'$key'") {
            print $2
        }
    }' ~/.devhomes
}

# Assign the current directory as the active
# DEV_HOME, and run its .dev_activate script
function devhome ()
{
    if [[ -n "$1" ]]; then
        _dev_addhome "$1" "$(pwd)"
    fi
    pwd > ~/.current_dev_dir
    touch .dev_activate
    dev
}

# Print out the location of the current DEV_HOME
function devlook () {
    if [ -f ~/.current_dev_dir ]; then
        echo "Dev home: `cat ~/.current_dev_dir`"
    else
        echo "No dev home active!"
    fi
}

# Move to the current DEV_HOME directory and
# run its local .dev_activate script.
function dev () {
    if [[ -n $1 ]]; then
        home=$(_dev_gethome "$1")
        if [[ -n "$home" ]]; then
            echo $home > ~/.current_dev_dir \
                && dev
        else
            echo "Unknown dev name!"
        fi
    elif [[ -f ~/.current_dev_dir ]]; then
        devlook
        export DEV_HOME="`cat ~/.current_dev_dir`"
        cd "$DEV_HOME"
        devactivate
    else
        echo "No dev home active!"
    fi
}

# Deactivate the current DEV_HOME environment.
function undev () {
    export -n DEV_HOME
    rm ~/.current_dev_dir
}

# Activate the current directory.
function devactivate() {
    if [[ -f ".dev_activate" ]]; then
        echo 'Running .dev_activate file'
        source .dev_activate
    fi
}

# List the named dev directories
function devlist() {
    awk '
    BEGIN {
        keylen = 0
    }
    {
        keys[$1] = $2
        if (length($1) > keylen) {
            keylen = length($1)
        }
    }
    END {
        fmt = "%%-%ds  %%s\n"
        fmt = sprintf(fmt, keylen)
        for (k in keys) {
            printf(fmt, k, keys[k])
        }
    }
    ' ~/.devhomes | sort
}

# Bash completion function:
_dev()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(awk '{ print $1 }' ~/.devhomes)

    COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
    return 0
}
[[ "$SHELL" == "/bin/bash" ]] && complete -F _dev dev
