#!/usr/bin/env python3

import sys
import subprocess

notifier = "/usr/bin/notify-send"
summary  = "Ο υπολογιστής κλείνει σε 5min"
message  = "Ο υπολογιστής είναι ανενεργός για μισή ώρα· αν δεν κουνήσετε το ποντίκι ή αν δε \
πατήσετε κάποιο πλήκτρο, θα κλείσει σε 5 λεπτά."

command = [notifier, summary, message]

popen = subprocess.Popen(command,
                         stderr=subprocess.PIPE,
                         stdout=subprocess.PIPE)

(stdout,stderr) = popen.communicate()
