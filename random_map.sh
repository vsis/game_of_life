#!/bin/bash

if [ -n "$1" ]
then
    rows=$1
else
    rows="96"
fi

if [ -n "$2" ]
then
    cols=$2
else
    cols="96"
fi

for i in $(seq $rows)
do
    cat /dev/urandom | tr -dc "012345" | tr "2345" "0" | head -c $cols && printf "\n"
done
