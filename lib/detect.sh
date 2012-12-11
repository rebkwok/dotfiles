#!/bin/bash

function cur_os {

    # If we have /etc/issue then it's not OSX:
    if [[ -r '/etc/issue' ]] ; then
        # Make sure we have egrep
        EGREP_VER=`egrep --version | head -n 1`
        if [[ ! "$EGREP_VER" =~ "GNU grep" ]] ; then
            echo "egrep isn't installed, sorry."
            return 1
        fi

        # Run checks
        DEB_OS=`egrep -i 'Ubuntu|Debian' /etc/issue`
        RH_OS=`egrep -i 'CentOS|Red Hat' /etc/issue`
        if [[ ${#DEB_OS} -gt 0 ]] ; then
            CUR_OS="debian"
        elif [[ ${#RH_OS} -gt 0 ]] ; then
            CUR_OS="redhat"
        else
            CUR_OS="unknown"
        fi
    else
        unamestr=`uname`
        if [[ "$unamestr" =~ 'Darwin' ]]; then
            CUR_OS="osx"
        else
            CUR_OS="unknown"
        fi
    fi
    echo $CUR_OS
}
