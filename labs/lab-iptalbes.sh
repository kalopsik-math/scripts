#!/bin/bash

RETVAL=1

case $1 in

    on)
#        umount /home/math/ugrads
#        umount /home/tem/ugrads

#        iptables -P INPUT DROP
#        iptables -P OUTPUT DROP
#        iptables -P FORWARD DROP
        iptables -P INPUT ACCEPT
        iptables -P OUTPUT ACCEPT
        iptables -P FORWARD ACCEPT
        
        iptables -F INPUT
        iptables -F OUTPUT
        iptables -F FORWARD
    
        iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
        iptables -A INPUT -p udp --sport 53 -j ACCEPT
        iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
        iptables -A INPUT -p tcp --sport 53 -j ACCEPT

        iptables -A OUTPUT -p udp --dport 390 -j DROP
        iptables -A INPUT -p udp --sport 390 -j DROP
        iptables -A OUTPUT -p tcp --dport 390 -j DROP
        iptables -A INPUT -p tcp --sport 390 -j DROP
            
#        iptables -A INPUT -s 147.52.65.68 -j ACCEPT
#        iptables -A OUTPUT -d 147.52.65.68 -j ACCEPT
#        iptables -A INPUT -s 147.52.67.72 -j ACCEPT
#        iptables -A OUTPUT -d 147.52.67.72 -j ACCEPT
#        iptables -A INPUT -s 147.52.82.71 -j ACCEPT
#        iptables -A OUTPUT -d 147.52.82.71 -j ACCEPT
        ;;

    off)
        iptables -P INPUT ACCEPT
        iptables -P OUTPUT ACCEPT
        iptables -P FORWARD ACCEPT

        iptables -F INPUT
        iptables -F OUTPUT
        iptables -F FORWARD

#        mount -a
        ;;
    
    status)
        iptables-save
        ;;

    *)
        echo $"Usage: $0 {on|off|status}"
	RETVAL=1
        ;;
esac

exit $RETVAL
