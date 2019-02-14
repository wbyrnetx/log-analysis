#!/bin/bash

DEFAULT_LOG="/var/log/nginx/access.log"
HOURS="01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23"
YEAR=2019

if [[ -z "$1" ]]
then
    logfile="$DEFAULT_LOG"
else
    logfile="$1"
fi

if [[ ! -f "$logfile" ]]
then
    echo "Log file does not exist: $logfile"
    exit 1
fi

echo -e "Hour" '\t' "Count"
for n in $HOURS
do
    ntotal=$(egrep -v '\.(css|js|gif|jpg|ico)' "$logfile" | grep $YEAR:$n | wc -l)

    if [[ "$ntotal" -gt 0 ]]
    then
        echo -e "$n" '\t' "$ntotal"
    fi
done
