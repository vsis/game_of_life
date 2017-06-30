#!/bin/bash

if [ -n "$2" ]
then
    echo "Too many arguments" >&2
    exit 1
fi

if [ -z "$1" ]
then
    random="true"
fi

if [ "$random" == "true" ]
then
    map_file="/tmp/random.map"
    ./random_map.sh > $map_file
else
    map_file="$1"
fi
    ruby src/game_of_life.rb $map_file
