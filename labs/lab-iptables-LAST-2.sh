#!/bin/bash

RETVAL=1

case $1 in

    on)
        # Unmount nfs mounts before dropping by default
        # otherwise the computer will be deadlocked (or at least very slow)
        umount /home/math/ugrads
        umount /home/tem/ugrads

        # change ldap.conf in
        rm /etc/ldap.conf
        ln -s /etc/ldap-block.conf /etc/ldap.conf
	export DEBIAN_FRONTEND=none
        pam-auth-update --force
        /etc/init.d/nscd restart
        /etc/init.d/nslcd restart

        # Default policy for all traffic must be DROP
        iptables -P INPUT DROP
        iptables -P OUTPUT DROP
        iptables -P FORWARD DROP

        # Clear all rules (now everything must be blocked)
        iptables -F INPUT
        iptables -F OUTPUT
        iptables -F FORWARD

        # We should allow local interface
        iptables -A INPUT  -i lo -j ACCEPT
        iptables -A OUTPUT -o lo -j ACCEPT

        # Allow DNS
        ### In the current case we don't need it
        #iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
        #iptables -A INPUT -p udp --sport 53 -j ACCEPT
        #iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
        #iptables -A INPUT -p tcp --sport 53 -j ACCEPT

        # Allow ldap. Our ldap listens  to port 390
#        iptables -A OUTPUT -p udp --dport 390 -j ACCEPT
#        iptables -A INPUT -p udp --sport 390 -j ACCEPT
        iptables -A OUTPUT -p tcp -d 147.52.78.6 --dport 390 -j ACCEPT
        iptables -A INPUT -p tcp -s 147.52.78.6 --sport 390 -j ACCEPT

        # Allow web traffic from this machine
        #iptables -A INPUT -s 147.52.65.68 -p tcp --sport 80 -j ACCEPT
        #iptables -A INPUT -s 147.52.65.68 -p tcp --sport 443 -j ACCEPT
        #iptables -A OUTPUT -d 147.52.65.68 -p tcp --dport 80 -j ACCEPT
        #iptables -A OUTPUT -d 147.52.65.68 -p tcp --dport 443 -j ACCEPT

        # Allow all traffic from/to this machine too
	### turing:
        iptables -A INPUT  -s 147.52.67.72  -j ACCEPT
        iptables -A OUTPUT -d 147.52.67.72  -j ACCEPT
	### turing:
        iptables -A INPUT  -s 147.52.80.1  -j ACCEPT
        iptables -A OUTPUT -d 147.52.80.1  -j ACCEPT
	### euclid(courses):
        iptables -A INPUT  -s 147.52.82.50  -j ACCEPT
        iptables -A OUTPUT -d 147.52.82.50  -j ACCEPT
	### epoptes:
        iptables -A INPUT  -s 147.52.82.72  -j ACCEPT
        iptables -A OUTPUT -d 147.52.82.72  -j ACCEPT
	### mathjax:
        iptables -A INPUT  -s 104.25.204.18  -j ACCEPT
        iptables -A OUTPUT -d 104.25.204.18  -j ACCEPT
        iptables -A INPUT  -s 104.24.18.65  -j ACCEPT
        iptables -A OUTPUT -d 104.24.18.65  -j ACCEPT
        iptables -A INPUT  -s 104.24.19.65  -j ACCEPT
        iptables -A OUTPUT -d 104.24.19.65  -j ACCEPT
        iptables -A INPUT  -s 104.19.192.102  -j ACCEPT
        iptables -A OUTPUT -d 104.19.192.102  -j ACCEPT
        iptables -A INPUT  -s 104.19.193.102  -j ACCEPT
        iptables -A OUTPUT -d 104.19.193.102  -j ACCEPT
        iptables -A INPUT  -s 104.19.194.102  -j ACCEPT
        iptables -A OUTPUT -d 104.19.194.102  -j ACCEPT
        iptables -A INPUT  -s 104.19.195.102  -j ACCEPT
        iptables -A OUTPUT -d 104.19.195.102  -j ACCEPT
        iptables -A INPUT  -s 104.19.196.102  -j ACCEPT
        iptables -A OUTPUT -d 104.19.196.102  -j ACCEPT
	### mathjax:
        iptables -A INPUT  -s 104.25.205.18  -j ACCEPT
        iptables -A OUTPUT -d 104.25.205.18  -j ACCEPT
	### fourier:
        iptables -A INPUT  -s 147.52.65.68  -j ACCEPT
        iptables -A OUTPUT -d 147.52.65.68  -j ACCEPT
	### euler:
        iptables -A INPUT  -s 147.52.59.134 -j ACCEPT
        iptables -A OUTPUT -d 147.52.59.134 -j ACCEPT
	### mem331:
        iptables -A INPUT  -s 147.52.50.215 -j ACCEPT
        iptables -A OUTPUT -d 147.52.50.215 -j ACCEPT
	#### mail:
        #iptables -A INPUT  -s 147.52.82.100 -j ACCEPT
        #iptables -A OUTPUT -d 147.52.82.100 -j ACCEPT
	#
        #iptables -A INPUT -s 147.52.65.134 -j ACCEPT
        #iptables -A OUTPUT -d 147.52.65.134 -j ACCEPT
        #iptables -A INPUT -s 147.52.67.72 -p tcp --sport 22 -j ACCEPT
        #iptables -A OUTPUT -d 147.52.67.72 -p tcp --dport 22 -j ACCEPT
        #iptables -A INPUT -s 147.52.82.71 -j ACCEPT
        #iptables -A OUTPUT -d 147.52.82.71 -j ACCEPT

        # Allow incoming SSH only from a sepcific host
        #iptables -A INPUT -p tcp -s 147.52.67.72 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
        #iptables -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

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
	export DEBIAN_FRONTEND=none
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
