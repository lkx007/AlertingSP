#!/bin/bash
(
  flock -n -x 200
  if [ $? != "0" ]; then
    echo "secmap lock present.  Not executing the command." 
    exit 1
  fi
  NAS_DB=/nas /nas/bin/server_cifssupport ALL -secmap -list
) 200>/tmp/secmap.lock
