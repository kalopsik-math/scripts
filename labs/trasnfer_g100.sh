#!/bin/bash

FLAG=$1


((I=4)); 
while (($I<=254)); do 
        echo "===================================================================================" >>$I.out 2>&1;
        echo "============================= $DATE ===============================================" >>$I.out 2>&1;
	echo executing on 147.52.58.$I: $COMMAND >>$I.out 2>&1;
        if [ $FLAG = 1 ];
        then
	    scp -i ~/.ssh/id_rsa-labs-1502040018  -o "StrictHostKeyChecking no" $1 root@147.52.58.$I:/root/  >>$I.out 2>&1 & 
        elif [ $FLAG = 2 ];
        then
	    scp -o "StrictHostKeyChecking no" $1 root@147.52.58.$I:/root/ >>$I.out 2>&1 & 
        else
            echo "nothing to do"
        fi
        echo "===================================================================================" >>$I.out 2>&1;
        echo "===================================================================================" >>$I.out 2>&1;
	((I=$I+1)); 
done
