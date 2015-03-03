#!/bin/bash

RETVAL=1

case $1 in

    on)
        umount /home/math/ugrads
        umount /home/tem/ugrads

        rm /etc/ldap.conf
        ln -s /etc/ldap-block.conf /etc/ldap.conf
        pam-auth-update --force
        /etc/init.d/ncsd restart
        /etc/init.d/nslcd restart

        iptables -P INPUT DROP
        iptables -P OUTPUT DROP
        iptables -P FORWARD DROP
#        iptables -P INPUT ACCEPT
#        iptables -P OUTPUT ACCEPT
#        iptables -P FORWARD ACCEPT


        iptables -F INPUT
        iptables -F OUTPUT
        iptables -F FORWARD
    
        iptables -A INPUT  -i lo -j ACCEPT
        iptables -A OUTPUT -o lo -j ACCEPT

#        iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
#        iptables -A INPUT -p udp --sport 53 -j ACCEPT
#        iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
#        iptables -A INPUT -p tcp --sport 53 -j ACCEPT

#        iptables -A OUTPUT -p udp --dport 390 -j ACCEPT
#        iptables -A INPUT -p udp --sport 390 -j ACCEPT
        iptables -A OUTPUT -p tcp -d 147.52.78.6 --dport 390 -j ACCEPT
        iptables -A INPUT -p tcp -s 147.52.78.6 --sport 390 -j ACCEPT
            
        iptables -A INPUT -s 147.52.65.68 -p tcp --sport 80 -j ACCEPT
        iptables -A INPUT -s 147.52.65.68 -p tcp --sport 443 -j ACCEPT
        iptables -A OUTPUT -d 147.52.65.68 -p tcp --dport 80 -j ACCEPT
        iptables -A OUTPUT -d 147.52.65.68 -p tcp --dport 443 -j ACCEPT

        iptables -A INPUT -s 147.52.67.72 -j ACCEPT
        iptables -A OUTPUT -d 147.52.67.72 -j ACCEPT
#        iptables -A INPUT -s 147.52.67.72 -p tcp --sport 22 -j ACCEPT
#        iptables -A OUTPUT -d 147.52.67.72 -p tcp --dport 22 -j ACCEPT
#        iptables -A INPUT -s 147.52.82.71 -j ACCEPT
#        iptables -A OUTPUT -d 147.52.82.71 -j ACCEPT

        # 5. Allow incoming SSH only from a sepcific network
#        iptables -A INPUT -p tcp -s 147.52.67.5 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
#        iptables -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
#        iptables -A INPUT -p tcp -s 147.52.67.72 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
#        iptables -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

        ;;

    off)
        iptables -P INPUT ACCEPT
        iptables -P OUTPUT ACCEPT
        iptables -P FORWARD ACCEPT

        iptables -F INPUT
        iptables -F OUTPUT
        iptables -F FORWARD

        rm /etc/ldap.conf
        ln -s /etc/ldap-default.conf /etc/ldap.conf
        pam-auth-update --force
        /etc/init.d/nscd restart
        /etc/init.d/nslcd restart

        mount -a
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
