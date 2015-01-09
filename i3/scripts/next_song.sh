#!/bin/bash
ps -C 'pianobar' > /dev/null

if [ $? -ne 0 ]; then
    mpc next
else
    /home/brian/scripts/remote_pianobar.sh next
fi
