#!/bin/bash

DATE=`date +%Y%m%d%H%M%S`
OUTDIR="transfer-b203-$DATE-out.d"

((I=4)); 
while (($I<=254)); do 
	if [ ! -d $OUTDIR ]; then mkdir $OUTDIR; fi
	echo executing on 147.52.58.$I: $COMMAND >>$OUTDIR/$I.out 2>&1;
	scp -l 2024 -P 4444 -i ~/.ssh/id_rsa-labs-20150319234517 -o "StrictHostKeyChecking no" $1 root@147.52.51.$I:/root/ >>$OUTDIR/$I.out 2>&1 & 
	((I=$I+1)); 
done
