#!/bin/bash

nmap -sn 147.52.58.4-254 2>&1 > ./g100_nmap_status-`date +%Y%m%d%H%M%S`
