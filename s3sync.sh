#!/bin/bash

bucket_name="infuse-videos"
aws s3 ls "s3://$bucket_name" > dir.txt

# Find all files with most recently modified first
find /mnt/usb* -type f | while read file_path
do

   current_hour=$(date +%-H)

   if [[ "$current_hour" -ge  22  || "$current_hour" -lt 9 ]]; then

       file_name=$(basename "$file_path")
       existing_file=$(egrep "[0-9]+ $file_name\$" dir.txt 2>&1)

       # if found
       if [[ "$existing_file" != "" ]]; then
           local_size=$(wc -c < "$file_path")
           s3_size=$(echo $existing_file | awk '{print $3}')

           # If different size
           if [[ "$local_size" -ne "$s3_size" ]]; then
               echo "Different size Uploading."
               aws s3 cp "$file_path" "s3://$bucket_name/"
           else
               echo "File exists in S3 but sizes match. Skipping upload."
           fi
       else
           echo "File missing in S3. Uploading."
           aws s3 cp "$file_path" "s3://$bucket_name/"
       fi
   else
       echo "Upload restricted to the specified time window (11 pm - 6 am)."
       break
   fi
done
