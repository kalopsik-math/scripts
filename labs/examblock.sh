#!/bin/bash

# Init all tables and chains.
# By default, all open and clear.
init()
{
    iptables -t nat -F OUTPUT
    iptables -t nat -F PREROUTING
    iptables -t nat -F POSTROUTING
    iptables -t nat -X

    p_nat "ACCEPT"

    iptables -t mangle -F INPUT
    iptables -t mangle -F OUTPUT
    iptables -t mangle -F FORWARD
    iptables -t mangle -F PREROUTING
    iptables -t mangle -F POSTROUTING
    iptables -t mangle -X

    p_mangle "ACCEPT"
    

    iptables -t filter -F INPUT
    iptables -t filter -F OUTPUT
    iptables -t filter -F FORWARD
    iptables -t filter -X
    
    p_filter "ACCEPT"
}

p_filter()
{
    iptables -t filter -P INPUT $1
    iptables -t filter -P OUTPUT $1
    iptables -t filter -P FORWARD $1
}


p_nat()
{
    iptables -t nat -P OUTPUT $1
    iptables -t nat -P PREROUTING $1
    iptables -t nat -P POSTROUTING $1
}

p_mangle()
{
    iptables -t mangle -P INPUT $1
    iptables -t mangle -P OUTPUT $1
    iptables -t mangle -P FORWARD $1
    iptables -t mangle -P PREROUTING $1
    iptables -t mangle -P POSTROUTING $1
}

on()
{
    init

    p_filter DROP
    p_mangle DROP
    p_nat    DROP

    # Allow all traffic with localhost
    iptables -A INPUT  -i lo -j ACCEPT
    iptables -A OUTPUT -o lo -j ACCEPT


    # Allow outbound http/https to fourier.math.uoc.gr
    iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
    iptables -A OUTPUT -m state --state NEW,ESTABLISED,RELATED -p tcp -d 147.52.65.68 --dport 80,443 -j ACCEPT
    iptables -A INPUT  -m state --state ESTABLISED,RELATED -p tcp -s 147.52.65.68 --sport 80,443 -j ACCEPT

    iptables -A OUTPUT -m state --state NEW -p tcp --dport 443 -j ACCEPT

    #ssh:
    # we want to allow only incoming ssh from specific hosts
    #iptables -A OUTPUT -m state --state NEW -p tcp --dport 22 -j ACCEPT
    #iptables -A OUTPUT -d 147.52.67.72 -m state --state NEW,ESTABLISHED -p tcp --dport 22 -j ACCEPT
    #iptables -A INPUT -s 147.52.67.72 -m state --state NEW,ESTABLISHED -p tcp --dport 22 -j ACCEPT

    iptables -A OUTPUT -m state --state NEW,ESTABLISHED -p tcp -d 147.52.67.72 --dport 22 -j ACCEPT
    iptables -A INPUT  -m state --state ESTABLISHED     -p tcp -s 147.52.67.72 --sport 22 -j ACCEPT


    # Allow outbound DNS
    iptables -A OUTPUT -m state --state NEW,ESTABLISHED -p udp --dport 53 -j ACCEPT
    iptables -A INPUT  -m state --state ESTABLISHED      -p udp --sport 53 -j ACCEPT
    iptables -A OUTPUT -m state --state NEW,ESTABLISHED -p tcp --dport 53 -j ACCEPT
    iptables -A INPUT  -m state --state ESTABLISHED      -p tcp --sport 53 -j ACCEPT

}

off()
{
    p_filter "ACCEPT"
    p_nat "ACCEPT"
    p_mangle "ACCEPT"

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

