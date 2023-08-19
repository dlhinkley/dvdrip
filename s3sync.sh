#!/bin/bash

# Find all files with most recently modified first
find /mnt/usb* -type f | while read file_path
do

   current_hour=$(date +%-H)
   bucket_name="infuse-videos"

   if [[ "$current_hour" -ge  22  || "$current_hour" -lt 7 ]]; then

       file_name=$(basename "$file_path")
       existing_file=$(aws s3 ls "s3://$bucket_name/$file_name" 2>&1)

       if [[ $existing_file == *"NoSuchKey"* ]]; then
           local_size=$(wc -c < "$file_path")
           s3_size=$(aws s3 ls "s3://$bucket_name/$file_name" | awk '{print $3}')

           if [[ "$local_size" -eq "$s3_size" ]]; then
               aws s3 cp "$file_path" "s3://$bucket_name/"
               echo "File uploaded successfully."
           else
               echo "File exists in S3 but sizes don't match. Skipping upload."
           fi
       else
           echo "File already exists in S3. Skipping upload."
       fi
   else
       echo "Upload restricted to the specified time window (11 pm - 6 am)."
       break
   fi
done
