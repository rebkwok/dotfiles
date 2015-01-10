dotfiles
========

My dotfiles. Not much to see here yet. Carry on...

First check you have XCode and XCode command-line tools installed. Then...

Install with::

    curl https://raw.github.com/bedmondmark/dotfiles/master/setup/bootstrap.sh | bash -x

Install vim plugins with::

    git submodules init && git submodules update

ToDo
----

* Better backup of existing dotfiles (re-runs don't lose existing backups).
* Indempotent install/bootstrap scripts (unless deps have been updated).
* Automatic keygen, if necessary, and registration with github(?)
* Separation of scripts into separate files, joined on install/runtime based
  on selected profile. (Basically this becomes modularisation of the dotfiles.)
* Fedora-based systems complain about missing ack-grep (although this is just
  whining - everything still works as it should). This is because 'which' is
  noisy about missing binaries on these systems. I basically just need to pipe
  stderr to /dev/null
