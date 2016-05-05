#!/bin/sh
#===============================================================================
# Solution pack builder
#===============================================================================

SOLUTION_PACK="$1"
JAR_FILE="build-solutionpack-cli.jar"

cd "`dirname "$0"`/.."
if [ -z "$SOLUTION_PACK" -o ! -d "../../$SOLUTION_PACK" ] ; then
  echo "Syntax: $0 <solution pack name>"
  exit
fi

java -jar $JAR_FILE "../../$SOLUTION_PACK/trunk" "$SOLUTION_PACK"

RETCODE=$?
if [ $RETCODE == 0 ] ; then
  echo "---- Build of $SOLUTION_PACK successful ----"
else
  echo "!!!! Build of $SOLUTION_PACK failed !!!!" >&2
fi
exit $RETCODE
