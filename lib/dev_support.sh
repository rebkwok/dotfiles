# Assign the current directory as the active
# DEV_HOME, and run its .dev_activate script
function devhome ()
{
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
    if [ -f ~/.current_dev_dir ]; then
        devlook
        export DEV_HOME="`cat ~/.current_dev_dir`"
        cd "$DEV_HOME"
        dev_activate
    else
        echo "No dev home active!"
    fi
}

# Deactivate the current DEV_HOME environment.
function undev () {
    export -n DEV_HOME
    rm ~/.current_dev_dir
}

function dev_activate() {
    if [ -f .dev_activate ]; then
        echo 'Running .dev_activate file'
        source .dev_activate
    fi
}
