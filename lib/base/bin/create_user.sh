#!/bin/bash

USAGE(){
    echo "   "
    echo "** USAGE: $0 ** "
    echo "** Using IDEATE_DIR/conf/machine/user.txt and ips.txt as configfile, each line: username password homedir usergroup **"
    echo "** Using IDEATE_DIR/conf/machine/hosts.txt as hosts file **"
    echo "   "
}

operator=`whoami`
users="$IDEATE_DIR/conf/machine/users.txt"
ips="$IDEATE_DIR/conf/machine/ips.txt"

if [ ! $operator == "root" ]; then
    echo "** ERROR : operator should be root ! "
    USAGE
    exit 1
fi

if [ ! -f "$ips" ]; then
    echo "** ERROR : need file $ips !"
    USAGE
    exit 1
fi

if [ ! -f "$users" ]; then
    echo "** ERROR : need file $users !"
    USAGE
    exit 1
fi

while read line
do
    echo $line | awk '{ print $1 }' | { 
    read ip ;

    while read line
    do
        echo $line | awk '{ print $1,$2,$3,$4 }' | {
        read username password homedir usergroup; 
        echo "*$ip Create User*  name:$username homedir:$homedir usergroup:$usergroup *** "
        expect ./gen_user.exp $ip $username $password $homedir $usergroup
        sleep 1
    } 
    done < $users
    
    }

done < $ips

exit 0
