#!/bin/bash

ifconfig

apt-get update && apt-get install "gcc++" git make screen mc wget -y

sudo apt-get install net-tools

ipv6s=$(curl -6 -s ifconfig.co | cut -f1-4 -d':')

ipv4s=$(curl -4 -s ifconfig.co)

echo -e "\033[33;4m Port Adeti: \033[0m";read adet

echo -e "\033[33;4m Portlarin baslangici: 30000 - 40000 tarzi \033[0m";read port1

ip -6 addr add ${ipv6s}::2/64 dev lo

/sbin/ifconfig ens3 inet6 add ${ipv6s}::2/64

ip -6 addr add ${ipv6s}::2/64 dev ens3

cd ~
git clone https://github.com/z3APA3A/3proxy.git
cd /root/3proxy/
rm -r man
rm -r src
cd /root/3proxy/
wget --no-check-certificate https://github.com/giGurylsPro/best-friends/raw/master/frirarman.zip
unzip frirarman.zip
chmod +x bin/
touch bin/define.txt
echo "#define ANONYMOUS 1" > bin/define.txt
sed -i "31r bin/define.txt" bin/proxy.h
make -f Makefile.Linux

cd /root/3proxy/

wget --no-check-certificate https://raw.githubusercontent.com/Suryta6/sorpty/main/gen64.sh

chmod +x /root/3proxy/gen64.sh

sed -i 's/\r//' /root/3proxy/gen64.sh

sed -e "s/MAXCOUNT=500/MAXCOUNT=$adet/" /root/3proxy/gen64.sh > /root/3proxy/gene64.sh

chmod +x /root/3proxy/gene64.sh

sed -i 's/\r//' /root/3proxy/gene64.sh

sed -e "s/network=2001:19f0:5401:11d7/network=${ipv6s}/" /root/3proxy/gene64.sh > /root/3proxy/random2.sh

chmod +x /root/3proxy/random2.sh

sed -i 's/\r//' /root/3proxy/random2.sh

bash /root/3proxy/random2.sh > /root/3proxy/ip.list

bash /root/3proxy/ip.list2.sh

apt install unzip

apt install build-essential -y

apt install git

cd ~
git clone https://github.com/DanielAdolfsson/ndppd.git
cd ~/ndppd
make all && make install

cat > ndppd.conf << END
route-ttl 30000
proxy ens3 {
   router no
   timeout 500
   ttl 30000
   rule ${ipv6s}::/64 {
      static
   }
}
END

ndppd -d -c /root/ndppd/ndppd.conf

cat > /root/3proxy/3proxy.sh << END
#!/bin/bash

echo daemon
echo maxconn 20000
echo nserver 8.8.8.8
echo nserver 8.8.4.4
echo nserver 1.1.1.1
echo nscache 65536
echo timeouts 1 5 30 60 180 1800 15 60
echo setgid 65535
echo setuid 65535
echo stacksize 6000
echo flush
echo auth strong
echo users admin:CL:pass
echo allow admin

port=$port1
count=1
for i in `cat ip.list`; do
    echo "proxy -6 -n -a -ocUSE_TCP_FASTOPEN  -p$port -i${ipv4s} -e$i"
    ((port+=1))
    ((count+=1))
    if [ $count -eq 10001 ]; then
        exit
    fi
done
END

chmod +x /root/3proxy/3proxy.sh

bash /root/3proxy/3proxy.sh > /root/3proxy/3proxy.cfg

ulimit -n 600000
ulimit -u 600000

cat >> /etc/sysctl.conf << END
net.ipv6.conf.all.proxy_ndp = 1
net.ipv6.conf.default.forwarding = 1
net.ipv6.conf.all.forwarding = 1
net.ipv6.ip_nonlocal_bind = 1
net.ipv6.route.max_size = 409600
net.ipv4.tcp_max_syn_backlog = 4096
net.ipv6.neigh.default.gc_thresh3 = 102400
END

sysctl -p

cd

cat > 2proxy.sh << END
#!/bin/bash

portlarr=portt
cat > /root/2proxy.sh << END
#!/bin/bash
port=$port1
count=1
for i in `cat ip.list`; do
    echo "${}ipv4s:$port"
    ((port+=1))
    ((count+=1))
    if [ $count -eq 10001 ]; then
        exit
    fi
done
END

chmod +x /root/2proxy.sh

./2proxy.sh > /root/proxyler.txt

cat > /etc/rc.local << END
#!/bin/bash
ulimit -n 600000
ulimit -u 600000
cat > /etc/rc.local << END
#!/bin/bash
ulimit -n 600000
ulimit -u 600000
/sbin/ip -6 addr add $ipv6::2/64 dev ens3
/sbin/ip -6 route add default via $ipv6::1
/sbin/ip -6 route add local $ipv6::/64 dev lo
ip -6 addr add ${ipv6s}::2/64 dev lo
/sbin/ifconfig ens3 inet6 add ${ipv6s}::2/64
ip -6 addr add ${ipv6s}::2/64 dev ens3
/root/ndppd/ndppd -d -c /root/ndppd/ndppd.conf
/root/3proxy/bin/3proxy /root/3proxy/3proxy.cfg
exit 0
END


chmod +x /etc/rc.local
systemctl enable rc-local.service
systemctl start rc-local.service
/usr/sbin/service rc.local restart

cd

cd/root

URL=$(curl --upload-file ./proxyler.txt https://transfer.sh/proxyler.txt)

echo -e "\033[31;4mindirme linki: ${URL}\033[0m"

echo -e "\033[33;4mSuccessfully completed\033[0m"
