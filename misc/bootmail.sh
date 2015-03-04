#! /bin/sh
# /etc/init.d/exim4
#

### BEGIN INIT INFO
# Provides:          bootmail.py
# Required-Start:    $named $network $time
# Required-Stop:     $named $network
# Should-Start:
# Should-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Sends email on boot
# Description:       Sends email on boot
### END INIT INFO

set -e

test -x /usr/local/bin/bootmail.py || exit 0

#. /lib/lsb/init-functions

case "$1" in
  start)
    /usr/local/bin/bootmail.py start
    ;;
  stop)
    /usr/local/bin/bootmail.py stop
    ;;
  restart)
    ;;
  reload|force-reload)
    ;;
  status)
    ;;
  force-stop)
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|reload|status|what|force-stop}"
    exit 1
    ;;
esac

exit 0
