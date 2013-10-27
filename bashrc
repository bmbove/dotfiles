#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias la='ls -lah --color=auto'
alias vi='vim'
PS1='\u@\h:$PWD\$ '
EDITOR=vim
