#!/bin/bash

# Init all tables and chains.
# By default, all open and clear.
init()
{
    echo "AAAAAAAAAAAAAAAAAAAAAAAAAAAA"

    iptables -t nat -F OUTPUT
    iptables -t nat -F PREROUTING
    iptables -t nat -F POSTROUTING
    iptables -t nat -X
    iptables -t nat -P OUTPUT ACCEPT
    iptables -t nat -P PREROUTING ACCEPT
    iptables -t nat -P POSTROUTING ACCEPT

    iptables -t mangle -F INPUT
    iptables -t mangle -F OUTPUT
    iptables -t mangle -F FORWARD
    iptables -t mangle -F PREROUTING
    iptables -t mangle -F POSTROUTING
    iptables -t mangle -X
    iptables -t mangle -P INPUT ACCEPT
    iptables -t mangle -P OUTPUT ACCEPT
    iptables -t mangle -P FORWARD ACCEPT
    iptables -t mangle -P PREROUTING ACCEPT
    iptables -t mangle -P POSTROUTING ACCEPT
    

    iptables -t filter -F INPUT
    iptables -t filter -F OUTPUT
    iptables -t filter -F FORWARD
    iptables -t filter -X
    iptables -t filter -P INPUT ACCEPT
    iptables -t filter -P OUTPUT ACCEPT
    iptables -t filter -P FORWARD ACCEPT
}

p_filter()
{
    echo "AAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    iptables -t filter -P INPUT $1
    iptables -t filter -P OUTPUT DROP
    iptables -t filter -P FORWARD DROP
}


drop_nat()
{
    iptables -t nat -P OUTPUT DROP
    iptables -t nat -P PREROUTING DROP
    iptables -t nat -P POSTROUTING DROP
}

drop_mangle()
{
    iptables -t mangle -P INPUT DROP
    iptables -t mangle -P OUTPUT DROP
    iptables -t mangle -P FORWARD DROP
    iptables -t mangle -P PREROUTING DROP
    iptables -t mangle -P POSTROUTING DROP
}

on()
{
    
    
    echo "AAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    init

    p_filter "ACCEPT"

    # Allow all traffic with localhost
    iptables -A INPUT  -i lo -j ACCEPT
    iptables -A OUTPUT -o lo -j ACCEPT


    iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
    iptables -A OUTPUT -m state --state NEW -p tcp --dport 80 -j ACCEPT
    iptables -A OUTPUT -m state --state NEW -p tcp --dport 443 -j ACCEPT

    #ssh:
    # we want to allow only incoming ssh from specific hosts
    #iptables -A OUTPUT -m state --state NEW -p tcp --dport 22 -j ACCEPT
    #iptables -A OUTPUT -d 147.52.67.72 -m state --state NEW,ESTABLISHED -p tcp --dport 22 -j ACCEPT
    #iptables -A INPUT -s 147.52.67.72 -m state --state NEW,ESTABLISHED -p tcp --dport 22 -j ACCEPT

    iptables -A OUTPUT -m state --state NEW,ESTABLISHED -p tcp -d 147.52.67.72 --dport 22 -j ACCEPT
    iptables -A INPUT  -m state --state ESTABLISHED     -p tcp -s 147.52.67.72 --sport 22 -j ACCEPT


    # Allow outbound DNS
    iptables -A OUTPUT -m state --state NEW, ESTABLISHED -p udp --dport 53 -j ACCEPT
    iptables -A INPUT  -m state --state ESTABLISHED      -p udp --sport 53 -j ACCEPT
    iptables -A OUTPUT -m state --state NEW, ESTABLISHED -p tcp --dport 53 -j ACCEPT
    iptables -A INPUT  -m state --state ESTABLISHED      -p tcp --sport 53 -j ACCEPT

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
             echo "AAAAAAAAAAAAA"
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

