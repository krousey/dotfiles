#!/bin/bash

SKIP_FILES=('install.sh' 'README' '.git' '.' '..' '.gitignore' '.emacs.d' 'terminfo')

FILTER=$(IFS="|" ; echo "${SKIP_FILES[*]}")
FILTER="!(${FILTER})"

INSTALL_FILES=$(shopt -s dotglob extglob; echo $PWD/$FILTER)
cp -vrs $INSTALL_FILES ${HOME} 2>&1 | grep -v "are the same file"
ln -fs ${PWD}/.emacs.d ${HOME} 
find terminfo -name '*.ti' -exec tic {} \;
