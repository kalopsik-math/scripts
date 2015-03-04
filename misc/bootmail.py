#!/usr/bin/env python3

# __author__ = 'kalopsik'

import sys
import smtplib
from email.mime.text import MIMEText

message = "TEST"
msg = MIMEText(message)
msg['Subject'] = '[g100-boot] %s' % message[:20]
msg['From'] = "g100-boot@math.uoc.gr"
msg['To'] = "sysadmin@math.uoc.gr"
msg['Cc'] = "kalopsik@math.uoc.gr"

s = smtplib.SMTP('mta.uoc.gr')
s.sendmail("sysadmin@math.uoc.gr", "sysadmin@math.uoc.gr", msg.as_string())
s.quit()