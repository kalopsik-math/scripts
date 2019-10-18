#!/bin/bash

DATE=`date +%Y%m%d%H%M%S`
OUTDIR="b203-$DATE-out.d"
#OF=total_scommand_`date +%Y%m%d%H%M`.out
#echo "Command: $1" > $OF

COMMAND="DEBIAN_FRONTEND=noninteractive $1"
#COMMAND="$2"

function get_location ()
{
    ssh -p 4444 -i ~/.ssh/id_rsa-labs-20150319234517 -o "StrictHostKeyChecking no" -o "ConnectTimeout 2" root@$IP
}
   

((I=4)); 
while (($I<=254)); do 
	if [ ! -d $OUTDIR ]; then mkdir $OUTDIR; fi
	ssh -p 4444 -i ~/.ssh/id_rsa-labs-20150319234517 -o "StrictHostKeyChecking no" root@147.52.51.$I "$COMMAND" >>$OUTDIR/$I.out 2>&1 & 

	((I=$I+1)); 
done
#done >> $OF 2>&1

[ -h last-output-b203 ] && rm last-output-b203
ln -s $OUTDIR ./last-output-b203

