#!/bin/bash


function show_help {
    echo "Retrieves the node ID for an anchored link or a template file"
    echo "  Syntax: $0 <UID of node>"
    echo "  Syntax: $0 -t <Template to grab singleNodeID from>"
}


function acquire_params {
    if [ $# -eq 2 ] ; then
        if [ "$1" != "-t" ] ; then
            echo "Bad switch..."
            show_help
            exit 1
        fi
        IS_TEMPLATE=true
        LINK="$2"
    elif [ $# -eq 1 ] ; then
        IS_TEMPLATE=false
        LINK="$1"
    else
        echo "Wrong number of arguments... ($#)"
        show_help
        exit 1
    fi
}


function get-parent-id {
    # If the template.xml is one long string we must use lazy-matching
    # to ensure we only get the first match of singleNodeId, unfortunately
    # sed doesn't support lazy-matching.  Use perl instead.
    if [ $(which perl) ] ; then
        echo $(grep 'singleNodeId' "$1" | head -n 1 | perl -pe 's:^.*?singleNodeId="([^"]+)".*$:\1:')
    else
        # If we have to though.. use this complicated statement:
        #  1) Split the file at the end of every node "><"
        #  2) Find each line which defines a singleNodeId
        #  3) Used head to grab only the first one
        #     now we are guaranteed to only have 1 singleNodeId and thus
        #     will not have to use lazy-matching
        #  4) Use sed to clear the whole string except the node ID
        echo $(sed -re 's:><:\n:g' "$1" | grep 'singleNodeId' | head -n 1 | sed -re 's:^.*singleNodeId="([^"]+)".*$:\1:g')
    fi
}



function get-node-id {
    local LINK="$1"
    # W4N_TEMPLATES is defined in export-template-locations, don't
    # reinitialize each time because it is expensive to do so.
    if [ -z "$W4N_TEMPLATES" ]; then
        source ./export-template-locations.sh 2>&1 /dev/null
    fi
    IFS=$'\n'
    local LINES=$(for d in "$W4N_TEMPLATES"; do grep uid=\"$LINK\" $d | grep 'node name'; done)


    # Check for failure
    if [[ -z $LINES ]]; then exit 1; fi

    # Check for more than one result too
    local COUNT=$(echo "$LINES" | wc -l)
    if [ $COUNT -ne 1 ] ; then exit $COUNT; fi

    local TEMPLATE=$(echo "$LINES" | cut -d':' -f1)
    echo $(get-parent-id "$TEMPLATE")
}



# Meat and potatoes
# TODO: does not work with -t when the path has spaces
acquire_params "$@"
if $IS_TEMPLATE ; then
    ID=$(get-parent-id "$LINK")
else
    ID=$(get-node-id "$LINK")
    RES=$?
    if [ $RES -ne 0 ]; then exit $RES; fi
fi



echo -e "$ID"

