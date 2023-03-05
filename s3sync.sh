#!/bin/bash

OIFS="$IFS"
IFS=$'\n'
for file in `find /mnt/usb* -type f `  
do
     echo "file = $file"
     CACHEFILE=`echo '$file' | md5sum`
     s3cmd -rv --cache-file=/home/pi/.s3md5/$CACHEFILE sync "$file" s3://infuse-videos 
     read line
done
IFS="$OIFS"
