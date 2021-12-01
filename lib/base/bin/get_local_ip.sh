#!/bin/bash

## get local ip ,eth1 first , then eth0
## return OK :  ip_addr  ret:0
## return Err:  "GetIpErr"  ret:1

temp="$IDEATE_DIR/temp_dir/temp.ip"
rm -rf $temp

ifconfig eth1 > $temp

if [ $? -eq 0 ]; then
   ip=`cat $temp |grep 'inet'| grep -v 'inet6' |awk '{print $2}' `
   if [ ! $ip == "" ]; then
        echo $ip
        exit 0
   fi

else
   ifconfig eth0 > $temp
   if [ $? -eq 0 ]; then
       ip=`cat $temp |grep 'inet'| grep -v 'inet6' |awk '{print $2}' `
       if [ ! $ip == "" ]; then
           echo $ip
           exit 0
       fi
   fi

fi

echo "error"

rm -rf $temp

exit 1 

