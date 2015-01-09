#!/bin/python2.7

import fileinput
import json
import subprocess
from subprocess import check_output

def run_cmd(name, button):
    if name == "speaker_volume":
        change_volume("speaker", button)
    if name == "headset_volume":
        change_volume("headset", button)

    return 1

def change_volume(dev, button):
    if dev == "speaker":
        #device = "alsa_output.pci-0000_00_1b.0.analog-surround-51"
        device = "alsa_output.pci-0000_00_1b.0.analog-stereo"
    if dev == "headset":
        device = "alsa_output.usb-Plantronics_Plantronics_GameCom_780-00-P780.analog-stereo"
    if button == "4":
        direction = "increase"
    if button == "5":
        direction = "decrease"

    if (button == "4") or (button == "5"):
        check_output(["ponymix --device \"" + device + "\" " + direction + " 1"], stderr=subprocess.STDOUT, shell=True)

    if button == "2":
        check_output(["ponymix --device \"" + device + "\" toggle"], stderr=subprocess.STDOUT, shell=True)

def main():

    line = ""
    for line in fileinput.input():
        line = line.strip()
        line = line.lstrip(",")
        if line != "":
            line = "[" + line + "]"
        pass

    if line != "":
        try:
            command = json.loads(line)
        except:
            #check_output(["xmessage", "Error with line " + line])
            exit(1)

        if "name" in command[0]:
            command[0]['button'] = str(command[0]['button'])
            run_cmd(command[0]["name"], command[0]["button"])
            exit(0)

if __name__ == "__main__":
    main()
