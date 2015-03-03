#!/usr/bin/env python3

# This program is intended to run in a cron schedule.
# If there is no action from user within 30mins the computer powers off.
# The action is detected through X by invoking xautolock(1).
# If xautolock is running already the process doesn't start.

# Dependencies:
#
#       Linux OS
#       python
#       xautolock must be installe
#       my_notifier.py must be in /usr/local/bin

import sys
import subprocess

# Minutes
timeout  = 30

# Seconds
margin   = 300

# Program to run when timeout is reached
locker   = "/sbin/poweroff"

# Program to run $margin seconds before timeout
# notifier = "/usr/local/bin/ny_notifier.py"
notifier = "/home/kalopsik/PycharmProjects/scripts/labs/my_notifier.py"

# #notifier = "/usr/bin/notify-send"
# summary  = "\"Ο υπολογιστής κλείνει σε 5min\""
# message  = "\"Ο υπολογιστής είναι ανενεργός για μισή ώρα· αν δεν κουνήσετε το ποντίκι ή αν δε \
# πατήσετε κάποιο πλήκτρο, θα κλείσει σε 5 λεπτά.\""

# xautolock executable
xautolock = "/usr/bin/xautolock"

opts = []
opts.append("-time")
opts.append("%d" %timeout)
opts.append("-notify")
opts.append("%d" % margin)
opts.append("-notifier")
opts.append("%s " % notifier)
opts.append("-locker")
opts.append("%s" % locker)
opts.append("-secure")
opts.append("-detectsleep")

commandlist = []
commandlist.append(xautolock)

# command = xautolock
# for s in opts:
#     command = command + s
#
# print(command)

#print(subprocess.Popen(command+opts, stdout=subprocess.PIPE).communicate()[0])
print(commandlist+opts)
popen = subprocess.Popen(commandlist+opts,
                         stdout=subprocess.PIPE,
                         stderr=subprocess.PIPE)

stdout,stderr = popen.communicate()

print(stdout,stderr)