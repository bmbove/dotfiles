#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ `tty` == '/dev/tty1' ]
then
    setleds -D +num
    $HOME/scripts/login_startup.sh
fi
