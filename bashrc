#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias la='ls -lah --color=auto'
alias vi='vim'
alias get='git'

#PS1='\u@\h:$PWD\$ '
EDITOR=/usr/bin/vim
XAUTHORITY=/home/brian/.Xauthority
PATH=$PATH:~/.gem/ruby/2.2.0/bin
export LESS=-RFX
export LIBVA_DRIVER_NAME=vdpau
export VDPAU_DRIVER=r600
export KICAD_PTEMPLATES='~/.kicadlib/KiCad-Libraries'
export KISYS3DMOD='/usr/share/kicad/modules/packages3d'
export KISYSMOD='/usr/share/kicad/modules'


function color_my_prompt {
    NORMAL="\[\033[0m\]"
    RED="\[\033[31;1m\]"
    local __user_and_host="\[\033[0;31m\]\u@\h"
    if [[ $EUID -ne 0 ]]; then
        local __user_and_host="\[\033[01;32m\]\u@\h"
    fi
    local __cur_location="\[\033[01;35m\]\w"
    local __git_branch_color="\[\033[31m\]"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\033[00m\]"
    SMILEY="${WHITE}:)${NORMAL}"
    FROWNY=" ${RED}error${NORMAL}"
    SELECT="if [ \$? = 0 ]; then echo -e ''; else echo -e \"${FROWNY}\"; fi"
    test="\$?"
    export PS1="$test\`${SELECT}\` $__user_and_host $__cur_location $__git_branch_color$__git_branch\n$__prompt_tail$__last_color "
}
color_my_prompt
