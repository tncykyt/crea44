#!/bin/bash
port=30000
echo ""
users=`wc -l ip.list | cut -d ' ' -f1`
for i in `seq 1 $users`; do
echo -n "users "
sad=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13)
asd=$sad
    echo -n "sera$i:CL:${asd}"
    echo 207.246.105.197:$port:sera$i:${asd} >> /etc/3proxy/proxylist2.txt
        ((port+=1))
echo -e
    if [ $(( $i % 100 )) -eq 0 ] ; then
        echo 
    fi
done

port=30000
count=1
for i in `cat ip.list`; do
    echo "allow sera$count"
    echo "proxy -6 -n -a1 -DiINTERFACE -p$port -i207.246.105.197 -e$i"
    ((port+=1))
    ((count+=1))
    if [ $count -eq 10001 ]; then
        exit
    fi
done
echo ""
echo "admin -p3200"
echo ""
echo ""
