# -*- mode: sh; eval: (sh-set-shell "zsh" nil nil) -*-

fpath=(${HOME}/.zsh.d/completions $fpath)

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl true


autoload -Uz colors && colors

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory extendedglob nomatch notify
bindkey -e
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word

function _my_prompt_color () {
  print "%{$fg_bold[$1]%}$2%{$reset_color%}"
}

TIMEFMT='%J
%U user %S system %P cpu %*E total %M MB'

PROMPT_USER=$(_my_prompt_color 'blue' '%n')
PROMPT_AT=$(_my_prompt_color 'green' '@')
PROMPT_MACHINE=$(_my_prompt_color 'white' '%m')
PROMPT_PWD=$(_my_prompt_color 'cyan' '%.')
PROMPT_JOBS=$(_my_prompt_color 'red' '%(1j.[%j].)')

PROMPT=''
PROMPT_ARRAY=($PROMPT_USER $PROMPT_AT $PROMPT_MACHINE ' ' $PROMPT_PWD $PROMPT_JOBS '> ')
PROMPT=${(j::)PROMPT_ARRAY}


if [[ -f ~/.shell_common ]]; then
  source ~/.shell_common
else
  echo "Error: ~/.shell_common does not exist"
fi

if [[ -f ~/.zshrc.$(hostname -s) ]]; then
  source ~/.zshrc.$(hostname -s)
fi

autoload -Uz compinit && compinit
