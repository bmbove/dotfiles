#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# run systemd as user instance
# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
#exec startfluxbox
#exec awesome
exec sabnzbd &
exec python2 $HOME/.sickbeard/Sick-Beard/SickBeard.py &
exec mediatomb > /dev/null 2>&1 &
exec thunar --daemon &
exec i3
