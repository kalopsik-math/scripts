#!/bin/bash

DATE=`date +%Y%m%d%H%M`
OUTDIR="g100-$DATE-out.d"
OUTFILE="service_tags"
COMMAND="dmidecode -s system-serial-number"
FLAG=$1


((I=4)); 
while (($I<=254)); do 
	if [ ! -d $OUTDIR ]; then mkdir $OUTDIR; fi
    if [ $FLAG = 1 ];
    then
	    ssh -i ~/.ssh/id_rsa-labs-1502040018  -o "StrictHostKeyChecking no" root@147.52.58.$I "$COMMAND" >>$OUTDIR/$OUTFILE &
    elif [ $FLAG = 2 ];
    then
	    ssh -o "StrictHostKeyChecking no" root@147.52.58.$I "$COMMAND" >>$OUTDIR/$OUTFILE &
    else
            echo "nothing to do"
    fi
	((I=$I+1));
done
#done >> $OF 2>&1

