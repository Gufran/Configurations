export ZSH=$HOME/.oh-my-zsh

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

ZSH_THEME="honukai"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh

setopt vi

export EDITOR=vim
export NVIM_TUI_ENABLE_TRUE_COLOR=1

plugins=(git extract zsh-syntax-highlighting history)

[ -s "$HOME/.shell-secrets" ] && . "$HOME/.shell-secrets"
[ -s "$HOME/.shell-functions" ] && . "$HOME/.shell-functions"
[ -s "$HOME/.shell-aliases" ] && . "$HOME/.shell-aliases"
[ -s "$NVM_DIR/nvm.sh"  ] && . "$NVM_DIR/nvm.sh"
[ -f $HOME/.phpbrew/bashrc ] && . $HOME/.phpbrew/bashrc
[ -f ~/.rvm/scripts/rvm ] && . ~/.rvm/scripts/rvm
[ -f $HOME/.opam/opam-init/init.zsh ] && . $HOME/.opam/opam-init/init.zsh 
[ -f /usr/local/bin/google-cloud-sdk/path.zsh.inc ] && . '/usr/local/bin/google-cloud-sdk/path.zsh.inc'
[ -f /usr/local/bin/google-cloud-sdk/completion.zsh.inc ] && . '/usr/local/bin/google-cloud-sdk/completion.zsh.inc'


# Set $PATH in a separate file
[ -f "$HOME/.shell-path" ] && . "$HOME/.shell-path"

# Load shell abbreviations
[ -f "$HOME/.shell-abbr" ] && . "$HOME/.shell-abbr"

eval $(opam config env)
complete -F _ssh_complete ssh

if [ -f $HOME/.fzf.zsh ]; then
    source $HOME/.fzf.zsh
    export FZF_COMPLETION_TRIGGER=''
    bindkey '^T' fzf-completion
    bindkey '^I' $fzf_default_completion
fi

# Search history with up or down key {{{
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search
# }}}

# Edit command line in $EDITOR {{{
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
# }}}

bindkey "^[m" copy-prev-shell-word

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
