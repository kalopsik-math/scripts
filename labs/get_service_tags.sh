#!/bin/bash

DATE=`date +%Y%m%d%H%M%S`
OUTDIR="service_tags-$DATE-out.d"
OUTFILE="service_tags"
FLAG=$1


((I=4)); 
while (($I<=254)); do 
    IP="147.52.58.$I"
    COMMAND="echo $IP && dmidecode -s system-serial-number"
    #COMMAND="dmidecode -s system-serial-number"
    if [ ! -d $OUTDIR ]; then mkdir $OUTDIR; fi
    if [ $FLAG = 1 ];
    then
	    ssh -i ~/.ssh/id_rsa-labs-1502040018  -o "StrictHostKeyChecking no" root@147.52.58.$I "$COMMAND" >>$OUTDIR/$OUTFILE &
    elif [ $FLAG = 2 ];
    then
	    ssh -o "StrictHostKeyChecking no" root@147.52.58.$I "$COMMAND" >>$OUTDIR/$OUTFILE &
    elif [ $FLAG = 3 ];
    then
            ssh -p 4444 -i ~/.ssh/id_rsa-labs-20150319234517 -o "ConnectTimeout 1" -o "StrictHostKeyChecking no" root@147.52.58.$I "$COMMAND" >>$OUTDIR/$OUTFILE  
    else
            echo "nothing to do"
    fi
	((I=$I+1));
done
#done >> $OF 2>&1

