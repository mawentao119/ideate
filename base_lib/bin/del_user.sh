echo "   "
echo "** USAGE: $0 username "
echo "** Using hosts.txt as hosts file **"
echo "   "

if [ $# != 1 ]; then
    echo "** ERROR: Parameter error , need username "
    echo "** USAGE: $0 username "
    exit 1
fi

username=$1
operator=`whoami`

if [ ! $operator == "root" ]; then
    echo "** ERROR : operator should be root ! "
    exit 1
fi

if [ ! -f "hosts.txt" ]; then
    echo "** ERROR : need file hosts.txt !"
    exit 1
fi

while read line
do
    echo $line | awk '{ print $1,$2,$3,$4 }' | { 
    read ip user password homedir ;
    echo "* Delete user ip: $ip user: $username "
    ssh root@$ip "userdel $username -r "
    sleep 1 
    }

done < "hosts.txt"

echo "*** Finished ***"

