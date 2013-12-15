#
# ~/.bash_logout
#
if [ `tty` == '/dev/tty1' ]
then
    killall sabnzbd
    killall python2
    killall transmission-daemon
    killall urxvtd
    killall thunar
    killall mediatomb
fi
