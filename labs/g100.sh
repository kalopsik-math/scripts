#!/bin/bash

DATE=`date +%Y%m%d%H%M%S`
OUTDIR="g100-$DATE-out.d"
#OF=total_scommand_`date +%Y%m%d%H%M`.out
#echo "Command: $1" > $OF

#COMMAND="DEBIAN_FRONTEND=noninteractive $2"
COMMAND="$2"
FLAG=$1


((I=5)); 
while (($I<=254)); do 
	if [ ! -d $OUTDIR ]; then mkdir $OUTDIR; fi
        echo "===================================================================================" >>$OUTDIR/$I.out 2>&1;
        echo "============================= $DATE ===============================================" >>$OUTDIR/$I.out 2>&1;
	echo executing on 147.52.58.$I: $COMMAND >>$OUTDIR/$I.out 2>&1;
        if [ $FLAG = 1 ];
        then
	    ssh -i ~/.ssh/id_rsa-labs-1502040018  -o "StrictHostKeyChecking no" root@147.52.58.$I "$COMMAND" >>$OUTDIR/$I.out 2>&1 & 
        elif [ $FLAG = 2 ];
        then
	    ssh -o "StrictHostKeyChecking no" root@147.52.58.$I "$COMMAND" >>$OUTDIR/$I.out 2>&1 & 
        elif [ $FLAG = 3 ];
        then
	    ssh -i ~/.ssh/id_rsa-labs-20150319234517 -o "StrictHostKeyChecking no" root@147.52.58.$I "$COMMAND" >>$OUTDIR/$I.out 2>&1 & 
        else
            echo "nothing to do"
        fi
        #echo "===================================================================================" >>$OUTDIR/$I.out 2>&1;
        #echo "===================================================================================" >>$OUTDIR/$I.out 2>&1;
	((I=$I+1)); 
done
#done >> $OF 2>&1

