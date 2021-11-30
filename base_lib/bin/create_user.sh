echo "   "
echo "** USAGE: $0 ** "
echo "** Using user.txt as configfile, each line: username password homedir usergroup **"
echo "** Using hosts.txt as hosts file **"
echo "   "

operator=`whoami`
users="users.txt"
ips="ips.txt"

if [ ! $operator == "root" ]; then
    echo "** ERROR : operator should be root ! "
    exit 1
fi

if [ ! -f "$ips" ]; then
    echo "** ERROR : need file $ips !"
    exit 1
fi

if [ ! -f "$users" ]; then
    echo "** ERROR : need file $users !"
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

echo "*** Finished ***"

