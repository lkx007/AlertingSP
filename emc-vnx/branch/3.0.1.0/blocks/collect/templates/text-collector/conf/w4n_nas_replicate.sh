#!/bin/bash
#Make sure we have the license
NAS_DB=/nas /nas/bin/nas_replicate -list 1> /dev/null 2> /dev/null
if [ $? == 0 ]; then
(
    flock -n -x 200
    if [ $? != "0" ]; then
    	echo "nas_replicate lock present.  Not executing the command." 
        exit 1
    fi    
    NAS_DB=/nas /nas/bin/nas_replicate -report
) 200>/tmp/w4n_nas_replicate.lock
fi
