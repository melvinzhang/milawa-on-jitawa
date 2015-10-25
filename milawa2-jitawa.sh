#!/bin/sh

set -e

if [ $# -ne 1 ]
then
    echo "Usage: milawa2-jitawa.sh file.events"
    exit 1
fi

if [ "`hostname`" == "killeen.centtech.com" ]
then
    echo "Refusing to run on killeen."
    exit 1
fi

JITAWA=`which jitawa`

EVENTS=$1

TEMP=`mktemp` || exit 1

# Copy the core.lisp file into temp, dropping comments with sed.
cat core.lisp | sed 's/;.*$//' > $TEMP
echo "(milawa-main '" >> $TEMP
cat $EVENTS >> $TEMP
echo ")" >> $TEMP

$JITAWA large < $TEMP

rm $TEMP