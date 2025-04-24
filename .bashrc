#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias projector='xrandr --output HDMI-A-0 --same-as eDP'
#PS1='[\u@\h \W]\$ '
PS1='\[\e[91m\]\u\[\e[0m\] @ \[\e[96m\]\h\[\e[0m\] in \[\e[93m\]\w\[\e[0m\] \[\e[93m\]>\[\e[0m\] '

PATH="$HOME/.local/bin/:$PATH"

