#!/bin/bash

USAGE(){
    echo "   "
    echo "** USAGE: $0 username [sudo]"
    echo "** Using hosts.txt as hosts file **"
    echo "   "
}

if [ $# == 0 ]; then
    echo "====  ERROR: Parameter Error ==== "
    USAGE
    exit 1
fi

hostfile="$IDEATE_DIR/conf/machine/hosts.txt"
if [ ! -f "$hostfile" ];then
    echo "==== ERROR: cannot find file:$hostfile ===="
    exit 1
fi

operator=`whoami`
if [ $# == 1 ]; then
    username=$1
    if [ ! $operator == "root" ]; then
        echo "==== ERROR : operator should be root OR add sudo parameter ==== "
        exit 1
    fi

    while read line
    do
        echo $line | awk '{ print $1,$2,$3,$4 }' | { 
        read ip user password homedir ;
        echo "* Delete user ip: $ip user: $username "
        ssh ${operator}@${ip} "userdel $username -r "
        sleep 1 
        }
    done < $hostfile
    exit 0
fi

if [ $# == 2 ]; then
    username=$1
    if [ $2 == "sudo" ];then
        while read line
        do
            echo $line | awk '{ print $1,$2,$3,$4 }' | {
            read ip user password homedir ;
            echo "* Delete user ip: $ip user: $username "
            ssh ${operator}@${ip} "sudo userdel $username -r "
            sleep 1 
            }
        done < $hostfile
        exit 0
    else
        echo "====  ERROR: Parameter Error ==== "
        USAGE
        exit 1
    fi
fi

exit 1
