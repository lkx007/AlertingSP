#!/bin/bash


ARP_DIR="../../../emc-watch4net/trunk/blocks/generic-reports/templates/arp/"


function get-template-locs {
    RESULT=""
    #for d in $(find ../../../ -iname trunk -maxdepth 2 -mindepth 2 -type d | grep -v emc-watch4net); do
    #    ENTRY=$(find $d/blocks/reports/templates/arp/ -iname template.xml -maxdepth 2 -mindepth 2 -type f 2> /dev/null)
    #    echo $?
    #    if [ $? -ne 0 ]; then continue; fi
    #    RESULT+="$ENTRY"
    #    RESULT+=$'\n'
    #done
    RESULT=$(find ../../../ -iname trunk -maxdepth 2 -mindepth 2 -type d -exec find {}/blocks/reports/templates/arp/ -iname template.xml -maxdepth 2 -mindepth 2 -type f \; 2> /dev/null)
    RESULT+=$'\n'
    RESULT+=$(find $ARP_DIR -iname template.xml -type f 2> /dev/null)
    
    echo "$RESULT"
}


export W4N_TEMPLATES=$(get-template-locs)
