#!/bin/bash

DATE=`date +%Y%m%d%H%M%S`
OUTDIR="trasnfer-g100-$DATE-out.d"

FLAG=$1


((I=4)); 
while (($I<=254)); do 
	if [ ! -d $OUTDIR ]; then mkdir $OUTDIR; fi
        echo "===================================================================================" >>$OUTDIR/$I.out 2>&1;
        echo "============================= $DATE ===============================================" >>$OUTDIR/$I.out 2>&1;
	echo executing on 147.52.58.$I: $COMMAND >>$OUTDIR/$I.out 2>&1;
        if [ $FLAG = 1 ];
        then
	    scp -r -i ~/.ssh/id_rsa-labs-1502040018  -o "StrictHostKeyChecking no" $2 root@147.52.58.$I:/root/  >>$OUTDIR/$I.out 2>&1 & 
        elif [ $FLAG = 2 ];
        then
	    scp -r -o "StrictHostKeyChecking no" $2 root@147.52.58.$I:/root/ >>$OUTDIR/$I.out 2>&1 & 
        elif [ $FLAG = 3 ];
        then
	    scp -r -i ~/.ssh/id_rsa-labs-20150319234517 -o "StrictHostKeyChecking no" $2 root@147.52.58.$I:/root/ >>$OUTDIR/$I.out 2>&1 & 
        else
            echo "nothing to do"
        fi
	((I=$I+1)); 
done
