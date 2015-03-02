#!/bin/bash

DATE=`date +%Y%m%d%H%M`
OUTDIR="$0-$DATE-out.f"
#OF=total_scommand_`date +%Y%m%d%H%M`.out
#echo "Command: $1" > $OF

#COMMAND="DEBIAN_FRONTEND=noninteractive $2"
COMMAND="$2"
FLAG=$1


((I=4)); 
while (($I<=254)); do 
        echo "===================================================================================" >>$I.out 2>&1;
        echo "============================= $DATE ===============================================" >>$I.out 2>&1;
	echo executing on 147.52.58.$I: $COMMAND >>$I.out 2>&1;
	mkdir $OUTDIR
        if [ $FLAG = 1 ];
        then
	    ssh -i ~/.ssh/id_rsa-labs-1502040018  -o "StrictHostKeyChecking no" root@147.52.58.$I "$COMMAND" >>$OUTDIR/$I.out 2>&1 & 
        elif [ $FLAG = 2 ];
        then
	    ssh -o "StrictHostKeyChecking no" root@147.52.58.$I "$COMMAND" >>$OUTDIR/$I.out 2>&1 & 
        else
            echo "nothing to do"
        fi
        echo "===================================================================================" >>$I.out 2>&1;
        echo "===================================================================================" >>$I.out 2>&1;
	((I=$I+1)); 
done
#done >> $OF 2>&1

