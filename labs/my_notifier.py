#!/usr/bin/env python3

try:
    import subprocess

    notifier = "/usr/bin/notify-send"
    summary  = "Ο υπολογιστής κλείνει σε 5min"
    message  = "Ο υπολογιστής είναι ανενεργός για μισή ώρα· αν δεν κουνήσετε το ποντίκι ή αν δεν πατήσετε κάποιο πλήκτρο, θα κλείσει σε 5 λεπτά."

    command = [notifier, summary, message]

    popen = subprocess.Popen(command,
                             stderr=subprocess.PIPE,
                             stdout=subprocess.PIPE)

    (stdout,stderr) = popen.communicate()
except:

    import sys
    import smtplib
    from email.mime.text import MIMEText

    message = "ERROR: %s" % sys.exc_info()[0]
    msg = MIMEText(message)
    msg['Subject'] = '[check_idle] %s' % message[:20]
    msg['From'] = "my_notifier@math.uoc.gr"
    msg['To'] = "sysadmin@math.uoc.gr"

    s = smtplib.SMTP('mta.uoc.gr')
    s.sendmail("sysadmin@math.uoc.gr", "sysadmin@math.uoc.gr", msg.as_string())
    s.quit()