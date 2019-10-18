#!/bin/bash

#./g100_all.sh "/root/lab-iptables.sh $1; echo 'last_command: ' `mydate.py` >> /etc/last_command_date"
./g100_all.sh "/root/lab-iptables.sh $1"
./b203.sh     "/root/lab-iptables.sh $1"
