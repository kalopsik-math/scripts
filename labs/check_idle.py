#!/usr/bin/env python3

import sys
import subprocess

#print("hello world")

timeout  = 30
margin   = 300
locker   = "/sbin/poweroff"
notifier = "/home/kalopsik/PycharmProjects/CheckIdle/my_notifier.py"
#notifier = "/usr/bin/notify-send"
summary  = "\"Ο υπολογιστής κλείνει σε 5min\""
message  = "\"Ο υπολογιστής είναι ανενεργός για μισή ώρα· αν δεν κουνήσετε το ποντίκι ή αν δε \
πατήσετε κάποιο πλήκτρο, θα κλείσει σε 5 λεπτά.\""

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