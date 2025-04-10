#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
#PS1='[\u@\h \W]\$ '
PS1='\[\e[91m\]\u\[\e[0m\] @ \[\e[96m\]\h\[\e[0m\] in \[\e[93m\]\w\[\e[0m\] \[\e[93m\]>\[\e[0m\] '
