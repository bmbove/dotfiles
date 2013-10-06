#!/bin/python2.7

import fileinput
import json

for line in fileinput.input():
    with open("test.txt", "a") as myfile:
        line = line.strip()
        line = line.lstrip(",")
        if line != "":
            line = "[" + line + "]"
            line = line + "\n"
            myfile.write(line)
    pass
