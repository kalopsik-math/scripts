#!/usr/bin/python3

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


try:
    import subprocess

    # Maximum minutes of no X user activity (30)
    timeout  = 30

    # Seconds before shutdown (300)
    margin   = 300

    # Program to run when timeout is reached
    locker   = "/sbin/poweroff"
    #locker = "/bin/ls"

    # Program to run $margin seconds before timeout
    notifier = "/usr/local/bin/my_notifier.py"
    #notifier = "./my_notifier.py"
    #import os
    #if os.path.isfile(notifier):  print("lala")

    logfile = "/var/log/check_idle.log"
    log = open(logfile,"a")

    # xautolock executable
    xautolock = "/usr/bin/xautolock"

    opts = []
    opts.append("-time")
    opts.append("%d" %timeout)

    import os
    if os.path.isfile(notifier):
        opts.append("-notify")
        opts.append("%d" % margin)
        opts.append("-notifier")
        opts.append("%s " % notifier)
    else:
        log.write("Warning! Notifier (/usr/local/bin/my_notifier.py) not found.\n")
    opts.append("-locker")
    opts.append("%s" % locker)
    opts.append("-secure")
    opts.append("-detectsleep")

    commandlist = []
    commandlist.append(xautolock)

    log.write("Executing: %s\n" % " ".join(commandlist+opts))
    popen = subprocess.Popen(commandlist+opts,
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE)

    stdout,stderr = popen.communicate()

    log.write("%s || %s\n" % (stdout,stderr))
    log.close()
    raise()

except:

    import sys
    import smtplib
    from email.mime.text import MIMEText

    message = "ERROR: %s" % sys.exc_info()[0]
    msg = MIMEText(message)
    msg['Subject'] = '[check_idle] %s' % message[:20]
    msg['From'] = "check_idle@math.uoc.gr"
    msg['To'] = "sysadmin@math.uoc.gr"

    s = smtplib.SMTP('mta.uoc.gr')
    s.sendmail("sysadmin@math.uoc.gr", "sysadmin@math.uoc.gr", msg.as_string())
    s.quit()