#!/bin/bash

iptables -F INPUT
iptables -F OUTPUT
iptables -F FORWARD

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p udp --sport 53 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -A INPUT -p tcp --sport 53 -j ACCEPT

iptables -A INPUT -s 147.52.65.68 -j ACCEPT
iptables -A OUTPUT -d 147.52.65.68 -j ACCEPT
iptables -A INPUT -s 147.52.67.72 -j ACCEPT
iptables -A OUTPUT -d 147.52.67.72 -j ACCEPT

#iptables -A INPUT -i eth0 -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
#iptables -A OUTPUT -o eth0 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

#iptables -A OUTPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
#iptables -A INPUT  -p tcp --sport 22 -m state --state ESTABLISHED,RELATED -j ACCEPT

