export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

#############################################################
eval `ssh-agent -s` >> /dev/null 
ssh-add
#############################################################

# Path to the oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="blinks"
COMPLETION_WAITING_DOTS="true"


plugins=(git ruby zsh-syntax-highlighting coffee autojump command-not-found colored-man composer extract history laravel python tmux)

source $ZSH/oh-my-zsh.sh

export TERM="xterm-256color"

export EDITOR="vim"


#####################################################################
#                   Enable Vi mode on terminal                      #
#####################################################################


set -o vi


#####################################################################
#                           INTIATE RVM                             #
#####################################################################

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

#####################################################################
#                           INITITATE TMUX                          #
#####################################################################

if [[ "$COLORTERM" -eq "gnome-terminal" ]]; then
    if [ -z $TMUX ]; then
        exec tmux
   fi
fi


######################################################################
#           CREATE A DIRECTORY IF NOT EXISTS AND CD INTO IT          #
######################################################################

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

#####################################################################################
#           Initialize all othe personalized config in external file                #
#####################################################################################

if [ -f "$HOME/.term-config" ]; then 

    source "$HOME/.term-config"

fi
