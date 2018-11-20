# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history.
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# awesome globbing
shopt -s extglob

# set up platform specific stuff
case "$OSTYPE" in
  linux*)
    ;;

  darwin*)
    if [ -f /opt/local/etc/bash_completion ]; then
	. /opt/local/etc/bash_completion
    fi
    ;;

  cygwin*)
    ;;
esac

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
else
  color_prompt=
fi

if [ "$color_prompt" = yes -a -r ${HOME}/.shell_colors ]; then
  . ${HOME}/.shell_colors
  PS1="${COL_EMB}\u${COL_EMG}@${COL_EMW}\h ${COL_EMC}\W${COL_EMR}[\j]${COL_NONE}> "
else
  PS1='\u@\h \W[\j]> '
fi
PROMPT_COMMAND='history -a'

unset color_prompt

eval "$(direnv hook bash)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -f ~/.shell_common ]; then
  . ~/.shell_common
else
  echo "Error: ~/.shell_common does not exist"
fi

# If I'm at work, do worky things
if [ -f ~/.at_work ]; then
  if [ -f ~/.bash_work ]; then
    . ~/.bash_work
  else
    echo "Error: ~/.bash_work does not exist"
  fi
fi

if [ -f "~/.bash_$(hostname -s)" ]; then
  . "~/.bash_$(hostname -s)"
fi

