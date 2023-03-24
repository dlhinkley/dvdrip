#!/bin/bash

WDIR='/mnt/usb2/House'

cd $WDIR && nohup  ~/dvdrip/rip-multi.sh /dev/sr0 "01 04 05 06 07 08" "House - Season 2 - Disc 6 - " "01,04,05,06,07,08" > ~/dvdrip/sr0.out &

#~/dvdrip/rip-multi.sh /dev/sr1 "01 02 03 04" "House - Season 2 - Disc 5 - " "E00 - All In,E01 - Slipping Dogs Lie,E02 - House vs God,E03 - Euphoria - Part 1" > ~/dvdrip/sr1.out
 
cd $WDIR && nohup ~/dvdrip/rip-multi.sh /dev/sr1 "03 04" "House - Season 2 - Disc 5 - " "E02 - House vs God,E03 - Euphoria - Part 1" > ~/dvdrip/sr1.out &

cd $WDIR && nohup ~/dvdrip/rip-multi.sh /dev/sr2 "01 02 03 04" "House - Season 2 - Disc 4 - " "E01 - Skin Deep,E01 - Sex Kills,E02 - Clueless,E03 - Safe" > ~/dvdrip/sr2.out &

