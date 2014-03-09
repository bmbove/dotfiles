#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ `tty` == '/dev/tty1' ]
then
    #eval $(ssh-agent)
    export MAKEFLAGS='-j 6'
    export XAUTHORITY=/home/brian/.Xauthority
    export EDITOR=/usr/local/bin/vim
    setleds -D +num
    $HOME/scripts/login_startup.sh
fi
