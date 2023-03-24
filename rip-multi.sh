#!/bin/bash

USAGE="usage: rip.sh device titles prefix names"

if [[ "$1" == "" ]]; then
		echo $USAGE
		exit 1
else
   DEV=$1
fi

if [[ "$2" == "" ]]; then
		echo $USAGE
		exit 1
else
   TITLES=$2
fi

if [[ "$3" == "" ]]; then
		echo $USAGE
		exit 1
else
   PREFIX=$3
fi

if [[ "$4" == "" ]]; then
		echo $USAGE
		exit 1
else
   NAMES=$4
fi

i=1
for TITLE in `echo $TITLES`; do 
		NAME=`echo $NAMES | cut -d ',' -f $i`
        FULLNAME="$PREFIX$NAME"
		HandBrakeCLI --subtitle-lang-list eng -i $DEV -t $TITLE -o "$FULLNAME.mp4"
		let i=i+1
done


# HandBrakeCLI -i $DEV -o "$TITLE.mp4"

