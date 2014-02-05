#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ `tty` == '/dev/tty1' ]
then
    export MAKEFLAGS='-j 6'
    setleds -D +num
    $HOME/scripts/login_startup.sh
fi
