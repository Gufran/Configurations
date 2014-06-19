export ZSH=$HOME/.oh-my-zsh

set -W
set -o vi

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

ZSH_THEME="honukai"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh

export EDITOR=vim
export GIT_EDITOR=nvim
export NVIM_TUI_ENABLE_TRUE_COLOR=1

alias todo=togoo
alias project="./project.sh"

plugins=(git extract zsh-syntax-highlighting history)

[ -s "$HOME/.shell-secrets" ] && . "$HOME/.shell-secrets"
[ -s "$NVM_DIR/nvm.sh"  ] && . "$NVM_DIR/nvm.sh"
[ -f $HOME/.phpbrew/bashrc ] && . $HOME/.phpbrew/bashrc
[ -f ~/.rvm/scripts/rvm ] && . ~/.rvm/scripts/rvm
[ -f "${HOME}/.iterm2_shell_integration.zsh" ] && . "${HOME}/.iterm2_shell_integration.zsh"
[ -f $HOME/.opam/opam-init/init.zsh ] && . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
[ -f /usr/local/bin/google-cloud-sdk/path.zsh.inc ] && . '/usr/local/bin/google-cloud-sdk/path.zsh.inc'
[ -f /usr/local/bin/google-cloud-sdk/completion.zsh.inc ] && . '/usr/local/bin/google-cloud-sdk/completion.zsh.inc'


# Set $PATH in a separate file
[ -f "$HOME/.shell-path" ] && . "$HOME/.shell-path"

alias ls="ls -FGhl"

trim() {
    awk '{$1=$1};1'
}

# ZSH can invoke a shell script on CD
function chpwd() {
    [ -f "$HOME/bin/chdir-hook" ] && $HOME/bin/chdir-hook
}

# change to a directory and create it if it doesn't exist
function cddir() {
    if [ -z $1 ]; then
        cd ~
    else
        if [[ -d $1 || "$1" == "-" ]]; then
            cd $1
        else
            echo  "Directory $1 does not exists, do you want to create it ? "; 
            read answer

            case $answer in 
                [Yy]* ) mkdir $1 && cd $1;;
                [Nn]* ) echo "[Error: cd] Directory $1 does not exists";; 
            esac
        fi
    fi
}

alias cd="cddir"

typeset -Ag abbreviations
abbreviations=(
  "Im"    "| more"
  "Ia"    "| awk"
  "Ig"    "| grep"
  "Ieg"   "| egrep"
  "Iag"   "| agrep"
  "Igr"   "| groff -s -p -t -e -Tlatin1 -mandoc"
  "Ip"    "| $PAGER"
  "Ih"    "| head"
  "Ik"    "| keep"
  "It"    "| tail"
  "Is"    "| sort"
  "Iv"    "| ${VISUAL:-${EDITOR}}"
  "Iw"    "| wc"
  "Ix"    "| xargs"
)

magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
    zle self-insert
}

no-magic-abbrev-expand() {
  LBUFFER+=' '
}


zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand

bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand

bindkey -M isearch " " self-insert

