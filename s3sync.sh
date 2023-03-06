#!/bin/bash

find /mnt/usb* -type f | while read f
do
    echo "Copy '$f'"
    #FILE=`echo $f | sed -e 's/ /\\\\ /g' -e 's/-/\\\\-/g'`
    CACHE=`echo '$f' | md5sum | cut -d ' ' -f 1`
    #s3cmd -rv --cache-file=/home/pi/.s3md5/$CACHE sync "'$f'" s3://infuse-videos
    find "$f" -type f -exec s3cmd -rv --no-delete-removed  --cache-file=/home/pi/.s3md5/$CACHE sync "{}" s3://infuse-videos  \;
done

