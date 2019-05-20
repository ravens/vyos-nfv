#!/bin/sh

# by default the network is setup up to be like eth0 with a random RFC1918 from docker networking
# create a bridge, unset the IP put it to the bridge and put tap0 and eth0 under the same bridge

# recover current IPv4
IPV4=`ip -4 addr show dev eth0 | grep inet | tr -s " " | cut -d" " -f3 | head -n 1`

echo "IPv4 assigned by Docker : $IPV4"

# create a br0 bridge
ip link add name br0 type bridge

# delete IP address
#ip addr flush dev eth0
# ip link set eth0 promisc on
# ip link set eth0 master br0

# create a tap0 interface for QEMU
ip tuntap add mode tap tap0

# add tap0 to br0
ip link set tap0 master br0

# raise all interface
ip link set dev br0 up
ip link set dev tap0 up
# ip link set dev eth0 up

#ip addr add ${IPV4} dev br0
ip addr add 192.168.99.1/30 dev br0

echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -t nat -A PREROUTING -i eth0 -p tcp -m tcp --dport 22 -j DNAT --to-destination 192.168.99.2:22

dnsmasq -i br0 --dhcp-range=192.168.99.2,192.168.99.2,255.255.255.252,24h

# launch QEMU
/usr/bin/qemu-system-x86_64 -serial telnet:0.0.0.0:1234,server,nowait -device virtio-net,netdev=network0,mac=52:55:00:d1:55:01 -netdev tap,id=network0,ifname=tap0,script=no,downscript=no -m 512 -smp 1 -machine type=pc,accel=kvm -drive file=/root/vyos.img,if=virtio,cache=writeback,discard=ignore,format=qcow2 -boot once=d