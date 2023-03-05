#!/bin/bash

find /mnt/usb* -type f | while read f
do
    echo "Copy '$f'"
    CACHE=`echo '$f' | md5sum | cut -d ' ' -f 1`
    s3cmd -rv --cache-file=/home/pi/.s3md5/$CACHE sync \'$f\' s3://infuse-videos
done

