#!/bin/bash

ipv6s=$(curl -6 -s ifconfig.co | cut -f1-4 -d':')

ipv4s=$(curl -4 -s ifconfig.co)

echo -e "\033[33;4m Port Adeti: \033[0m";read adet

echo -e "\033[33;4m Portlarin baslangici: 30000 - 40000 tarzi \033[0m";read port1

wget --no-check-certificate https://raw.github.com/barankilic/3proxy/master/3proxyinstaller.sh
chmod +x 3proxyinstaller.sh
./3proxyinstaller.sh

/sbin/ip -6 addr add ${ipv6s}::2/64 dev ens3
/sbin/ip -6 route add default via ${ipv6s}::2
/sbin/ip -6 route add local ${ipv6s}::/64 dev lo
ip -6 addr add ${ipv6s}::2/64 dev lo
/sbin/ifconfig ens3 inet6 add ${ipv6s}::2/64
ip -6 addr add ${ipv6s}::2/64 dev ens3
/sbin/ip -6 addr add ${ipv6s}::1/64 dev ens3
/sbin/ifconfig ens3 inet6 add ${ipv6s}::1/64

sudo apt-get install nano

sudo apt-get install net-tools

apt install build-essential -y

apt install git

cd /root

wget --no-check-certificate https://raw.githubusercontent.com/Suryta6/sorpty/main/gen64.sh

chmod +x gen64.sh

sed -i 's/\r//' gen64.sh

sed -e "s/MAXCOUNT=500/MAXCOUNT=$adet/" /root/gen64.sh > /root/gene64.sh

chmod +x gene64.sh

sed -i 's/\r//' gene64.sh

sed -e "s/network=2001:19f0:5401:11d7/network=${ipv6s}/" /root/gene64.sh > /root/random2.sh

chmod +x random2.sh

sed -i 's/\r//' random2.sh

bash random2.sh > /etc/3proxy/ip.list

cd /root

chmod +x ip.list2.sh

bash ip.list2.sh

cat >> /etc/sysctl.conf << END
net.ipv6.ip_nonlocal_bind = 1
fs.file-max = 700000
net.ipv4.tcp_timestamps=1
net.ipv4.tcp_max_tw_buckets=1440000
net.ipv4.ip_local_port_range = 512 65535
net.core.somaxconn = 61440
net.core.rmem_max = 12582912
net.core.wmem_default = 31457280
net.core.wmem_max = 12582912
net.ipv4.tcp_keepalive_time = 300
net.ipv4.tcp_keepalive_probes = 5
net.ipv4.tcp_keepalive_intvl = 15
net.ipv4.tcp_fin_timeout = 15
net.ipv4.tcp_rfc1337 = 1
net.core.optmem_max = 25165824
net.ipv4.tcp_mem = 65536 131072 262144
net.ipv4.udp_mem = 65536 131072 262144
net.ipv4.tcp_rmem = 8192 87380 16777216
net.ipv4.udp_rmem_min = 66384
net.ipv4.tcp_wmem = 8192 65536 16777216
net.ipv4.udp_wmem_min = 76384
net.ipv4.xfrm4_gc_thresh = 52768
net.netfilter.nf_conntrack_tcp_timeout_established=200
kernel.threads-max = 220000
kernel.pid_max = 200000
END

sysctl -p

cat > /etc/rc.local << END
#!/bin/bash
ulimit -n 600000
ulimit -u 600000
echo 600000 > /proc/sys/vm/max_map_count
echo 200000 > /proc/sys/kernel/pid_max
truncate -s0 /etc/resolv.conf && echo 'nameserver 127.0.0.1' >> /etc/resolv.conf
/sbin/ip -6 addr add 2001:19f0:6c01:262a::2/64 dev ens3
/sbin/ip -6 route add default via fe80::1
/sbin/ip -6 route add local 2001:19f0:6c01:262a::/64 dev lo
/root/ndppd/ndppd -d -c /root/ndppd/ndppd.conf
bash /root/ip.list2.sh
END

cd /etc/3proxy

rm -rf /etc/3proxy/3proxy.cfg

cd /etc/3proxy/ && wget 'https://raw.githubusercontent.com/Suryta6/sorpty/main/3proxy.cfg'

cd /etc/3proxy/ && wget 'https://raw.githubusercontent.com/Suryta6/sorpty/main/3proxy.sh'

chmod +x /etc/3proxy/3proxy.sh

sed -i 's/\r//' /etc/3proxy/3proxy.sh

nano /etc/3proxy/3proxy.sh

apt install libproxy-tools

bash /etc/3proxy/3proxy.sh > sda.sh

URL=$(curl --upload-file ./proxylist2.txt https://transfer.sh/proxylist2.txt)

echo -e "\033[31;4mindirme linki: ${URL}\033[0m"

chmod +x /etc/3proxy/sda.sh

sed -i 's/\r//' /etc/3proxy/sda.sh

cat sda.sh >> /etc/3proxy/3proxy.cfg

/etc/init.d/3proxyinit start

/etc/init.d/3proxyinit restart

cd /etc/3proxy/

echo -e "\033[32;4mSuccessfully completed\033[0m"
