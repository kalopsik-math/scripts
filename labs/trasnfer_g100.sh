#!/bin/bash

DATE=`date +%Y%m%d%H%M`
OUTDIR="g100-$DATE-out.d"

FLAG=$1


((I=4)); 
while (($I<=254)); do 
	if [ ! -d $OUTDIR ]; then mkdir $OUTDIR; fi
        echo "===================================================================================" >>$OUTDIR/$I.out 2>&1;
        echo "============================= $DATE ===============================================" >>$OUTDIR/$I.out 2>&1;
	echo executing on 147.52.58.$I: $COMMAND >>$OUTDIR/$I.out 2>&1;
        if [ $FLAG = 1 ];
        then
	    scp -i ~/.ssh/id_rsa-labs-1502040018  -o "StrictHostKeyChecking no" $2 root@147.52.58.$I:/root/  >>$OUTDIR/$I.out 2>&1 & 
        elif [ $FLAG = 2 ];
        then
	    scp -o "StrictHostKeyChecking no" $2 root@147.52.58.$I:/root/ >>$OUTDIR/$I.out 2>&1 & 
        else
            echo "nothing to do"
        fi
        echo "===================================================================================" >>$OUTDIR/$I.out 2>&1;
        echo "===================================================================================" >>$OUTDIR/$I.out 2>&1;
	((I=$I+1)); 
done
