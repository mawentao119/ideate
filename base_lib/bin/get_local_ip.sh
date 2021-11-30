#!/bin/bash

## get local ip ,eth1 first , then eth0
## return OK :  ip_addr  ret:0
## return Err:  "GetIpErr"  ret:1

rm -rf temp.ip

ifconfig eth1 > temp.ip

if [ $? -eq 0 ]; then
   ip=`cat temp.ip |grep 'inet'| grep -v 'inet6' |awk '{print $2}' `
   if [ ! $ip == "" ]; then
        echo $ip
        exit 0
   fi

else
   ifconfig eth0 > temp.ip
   if [ $? -eq 0 ]; then
       ip=`cat temp.ip |grep 'inet'| grep -v 'inet6' |awk '{print $2}' `
       if [ ! $ip == "" ]; then
           echo $ip
           exit 0
       fi
   fi

fi

echo "GetIpErr"

rm -rf temp.ip

exit 1 

