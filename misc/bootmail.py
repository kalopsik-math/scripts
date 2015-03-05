#!/usr/bin/env python3

# __author__ = 'kalopsik'

import sys
import smtplib
import subprocess
import sys
import time

from email.mime.text import MIMEText
from uuid import getnode as get_mac

# get mac address
mac = get_mac()

import socket

# get ip address
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(('8.8.8.8', 0))  # connecting to a UDP address doesn't send packets
ip_address = s.getsockname()[0]

#get serial number
command = "dmidecode -s system-serial-number"
popen = subprocess.Popen(command.split(),
                             stderr=subprocess.PIPE,
                             stdout=subprocess.PIPE)

#(stdout,stderr) = popen.communicate()
stag = popen.communicate()[0].strip()
print("command name %s " % sys.argv[0])
ss = ""
if len(sys.argv) >= 2 and sys.argv[1].strip() == "start":
    ss = "Booting up"
elif len(sys.argv) >= 2 and sys.argv[1].strip() == "stop":
    ss = "Shutting down"
else :
    ss = "Oops. Nor starting neither stopping..."

t = time.strftime("%Y%m%d%H%M%S").rstrip('\n')
message = t + ":: " + ss + " computer with ip %s, mac address %s and service tag: %s " % \
                           (ip_address, hex(mac), stag)

msg = MIMEText(message)
msg['Subject'] = '[g100-boot] %s, %s' % (ss,stag)
msg['From'] = "g100-boot@math.uoc.gr"
msg['To'] = "sysadmin@math.uoc.gr"
msg['Cc'] = "kalopsik@math.uoc.gr kolount@gmail.com"
#msg['BCc'] = "kalopsik@gmail.com"
to = [msg['To']] + msg['Cc'].split()
fr = msg['From']
s = smtplib.SMTP('mta.uoc.gr')
s.sendmail(fr, to, msg.as_string())
s.quit()