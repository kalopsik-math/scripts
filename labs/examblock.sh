#!/bin/bash


on()
{
    iptables -F INPUT
    iptables -F OUTPUT
    iptables -F FORWARD

    iptables -P INPUT DROP
    iptables -P OUTPUT DROP
    iptables -P FORWARD DROP

    #iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
    #iptables -A OUTPUT -m state --state NEW -p tcp --dport 80 -j ACCEPT
    #iptables -A OUTPUT -m state --state NEW -p tcp --dport 443 -j ACCEPT

    iptables -A OUTPUT -m state --state NEW,ESTABLISHED -p tcp -d 147.52.65.68 --dport 80 -j ACCEPT
    iptables -A INPUT  -m state --state ESTABLISHED     -p tcp -s 147.52.65.68 --sport 80 -j ACCEPT
    iptables -A OUTPUT -m state --state NEW,ESTABLISHED -p tcp -d 147.52.65.68 --dport 443 -j ACCEPT
    iptables -A INPUT  -m state --state ESTABLISHED     -p tcp -s 147.52.65.68 --sport 443 -j ACCEPT

    #ssh:
    # we want to allow only incoming ssh from specific hosts
    #iptables -A OUTPUT -m state --state NEW -p tcp --dport 22 -j ACCEPT
    #iptables -A OUTPUT -d 147.52.67.72 -m state --state NEW,ESTABLISHED -p tcp --dport 22 -j ACCEPT
    #iptables -A INPUT -s 147.52.67.72 -m state --state NEW,ESTABLISHED -p tcp --dport 22 -j ACCEPT

    iptables -A OUTPUT -m state --state NEW,ESTABLISHED -p tcp -d 147.52.67.72 --dport 22 -j ACCEPT
    iptables -A INPUT  -m state --state ESTABLISHED     -p tcp -s 147.52.67.72 --sport 22 -j ACCEPT


    # Allow outbound DNS
    iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
    iptables -A INPUT  -p udp --sport 53 -j ACCEPT

    iptables -A INPUT  -p tcp --sport 53 -j ACCEPT
    iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
}

off()
{
    iptables -P INPUT ACCEPT
    iptables -P OUTPUT ACCEPT
    iptables -P FORWARD ACCEPT

    iptables -F INPUT
    iptables -F OUTPUT
    iptables -F FORWARD
}

start()
{
    on
}

stop()
{
    off
}

status()
{
    iptables-save
}

case $1 in

    on)
             on
             ;;

    off)
	     off
	     ;;

    restart)
	     off
	     on
	     ;;

    status)
	     status
	     ;;

    *)
             echo $"Usage: $0 {on|off|status}"
	     RETVAL=1

esac

exit $RETVAL

