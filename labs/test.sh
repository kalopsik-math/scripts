#!/bin/bash

DATE=`date +%Y%m%d%H%M`
OUTDIR="g100-$DATE-out.d"
OUTFILE="service_tags"
COMMAND="dmidecode -s system-serial-number"
FLAG=$1


((I=4)); 
while (($I<=254)); do 
    echo "Checking 147.52.58.$I"
    if [ $FLAG = 1 ];
    then
	    ssh -f -i ~/.ssh/id_rsa-labs-1502040018  -o "ConnectTimeout 1" -o "StrictHostKeyChecking no" root@147.52.58.$I "$COMMAND"  &
    elif [ $FLAG = 2 ];
    then
	    ssh -f -o "ConnectTimeout 1" -o "StrictHostKeyChecking no" root@147.52.58.$I "$COMMAND"  &
    else
            echo "nothing to do"
    fi
	((I=$I+1));
done
#done >> $OF 2>&1

