#!/bin/bash

USAGE(){
    echo "** USAGE: $0 ** "
    echo "** Using hosts.txt, each line with '1.2.3.4 user password /home/user' formate. Can Run repeately. **"
    echo "   "
}

sleep 2

hosts="$IDEATE_DIR/conf/machine/hosts.txt"
currdir="$IDEATE_DIR/temp_dir"

if [ ! -f "$hosts" ]; then
    echo "* ERROR: Cannot find $hosts , please create it. *"
    USAGE
    exit 1
fi

rm -rf $currdir/ssh_out
rm -rf $currdir/authorized_keys

while read line
do
    echo $line | awk '{ print $1,$2,$3,$4 }' | { 
    read ip user password homedir ; 

    echo "*** Gen auth ... IP:$ip USER:$user PASS:$password HOME_DIR:$homedir"
    expect ./gen_auth.exp $ip $user $password $homedir 
    sleep 2
    
    }

done < $hosts

if [ ! -f "~/.ssh/id_rsa.pub" ];then
    ssh-keygen -P "" -f ~/.ssh/id_rsa
fi

if [ ! -f "~/.ssh/id_rsa.pub" ];then
    echo "* ERROR: cannot find id_rsa.pub ,maybe ssh-keygen command fail *"
    exit 1 
fi

cat ~/.ssh/id_rsa.pub > $currdir/authorized_keys

while read line
do
    echo $line | awk '{ print $1,$2,$3,$4 }' | { 
    read ip user password homedir ; 

    echo "*** SCP auth ... IP:$ip USER:$user PASS:$password HOME_DIR:$homedir"
    expect ./scp_auth.exp $ip $user $password $homedir
    sleep 2
    
    }

done < $hosts

rm -rf $currdir/ssh_out
rm -rf $currdir/authorized_keys

echo "*** Finished ***"

exit 0

