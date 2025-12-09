#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
#alias projector='xrandr --output HDMI-A-0 --mode 1920x1080'
alias projector='xrandr --output HDMI-A-0 --mode 1920x1080 --same-as eDP'
alias nvim-dots='cd ~/Documents/dotfiles && nvim'
PS1='\[\e[40m\] \[\e[36;40m\]\w\[\e[0;40m\] \[\e[0m\] \[\e[40m\] \[\e[33;40m\]\\$\[\e[0;40m\] \[\e[0m\] '

PATH="$HOME/.local/bin/:$PATH"
PATH="$HOME/.local/share/nvim/mason/bin/:$PATH"
export EDITOR=nvim
