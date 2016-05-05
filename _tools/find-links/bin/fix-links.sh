#!/bin/bash

DEBUG=false

function fix_links() {

    TARGET=$1

    # Get all anchored links in the given file
    local LINES=$(grep -E 'linkID="[^:]*:#[^"]+"' $TARGET)
    local LINKS=$(echo "$LINES" | sed -re 's/^.*linkID="[^:]*:#([^"]+).*$/\1/' | sort | uniq)

    # Get the ID of the parent node
    PARENT_NODE=$(./get-node-id.sh -t $TARGET)

    # Backup the given file
    cp $TARGET $TARGET.bck

    # For each link...
    for LINK in $LINKS
    do
      echo
      echo Fixing link \<$LINK\>:
      
      # Get the node ID of this link
      # We can use eval to create a variable using the TARGET and setting
      # it to its node ID.  This way, multiple checks against the same
      # LINK do not have to repeatedly call ./get-node-id.sh
      KEY=$(echo $LINK | sed 's:-:_:g')
      if $DEBUG ; then
          echo -e "\tStored link val = $(eval \"echo \$$KEY\")"
      fi
      RES=0
      if [ -z $(eval "echo \$$KEY") ]; then
          if $DEBUG ; then
              echo -e "\tSearching for node ID..."
          fi
          ID=$(./get-node-id.sh $LINK)
          RES=$?
          eval "$KEY=\"$ID\""
      else
          if $DEBUG ; then
              echo -e "\tUnpacking existing node ID for $KEY"
          fi
          ID=$(eval "echo \$$KEY")
      fi
      if [ $RES -ne 0 ]; then
          if [ $RES -eq 1 ] ; then
              echo -e " !\tCould not find template <$LINK>"
              ERRORS+="Could not find template <$LINK>\n"
              continue
          else
              echo -e " !\tTemplate <$LINK> defined multiple times: ($RES)"
              ERRORS+="Template <$LINK> defined multiple times: ($RES)\n"
              continue
          fi
      fi
      
      # Create the new node ID using the correctly referenced parent node
      # (If the link is located in the same template
      #  the ID is not required, remove that here)
      if [ "$ID" == "$PARENT_NODE" ]; then
          NEW_LINK=':#'$LINK
      else
          NEW_LINK=$ID':#'$LINK
      fi
      echo -e "\t$NEW_LINK"
      
      # Use sed to replace all occurrences of the link with the proper node ID
      if $DEBUG ; then
          echo -e "\tReplacing all occurances"
      fi
      sed -i -re 's/linkID="[^:*]*:#'$LINK'"/linkID="'$NEW_LINK'"/g' $TARGET
    done
}



# Finding all template locations is costly, lets source the
# template locations script so we only have to call it once
source ./export-template-locations.sh 2>&1 /dev/null


# Check inputs...
FILE="$1"

if [ -z "$FILE" ] ; then
  echo "Syntax: $0 <File/Directory to correct links for>"
  exit 1
fi


# If a directory is given...
ERRORS=""
if [ -d $FILE ] ; then
    IFS=$'\n'
    FILES="`find $FILE -iname template.xml`"
    for f in $FILES; do
        fix_links $f
    done
else
    fix_links $FILE
fi

echo
echo ==============================================
echo Error Summary:
echo ==============================================
ERRORS=$(echo -e "$ERRORS" | sort | uniq | grep -v '^$')
echo "$ERRORS"

