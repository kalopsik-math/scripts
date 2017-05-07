#!/usr/bin/python

import sys
import time
import os
import subprocess

def main(arg):
    
    for i in range(5,255):
        localCommand = ['ssh', '-i', '/home/kalopsik/.ssh/id_rsa-labs-20150319234517', '-o', "StrictHostKeyChecking no", 'root@147.52.58'+str(i)]
        remoteCommand = [ "R --version" ]

        subprocess.Popen(localCommand+remoteCommand, stdout=subprocess.PIPE).communicate()[0]


main('')
