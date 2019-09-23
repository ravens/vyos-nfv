#!/bin/sh

ip link add name br0 type bridge
ip tuntap add mode tap tap0
ip link set tap0 master br0
ip link set dev br0 up
ip link set dev tap0 up

ip addr add 192.168.99.1/30 dev br0

echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -t nat -A PREROUTING -i eth0 -p tcp -m tcp --dport 22 -j DNAT --to-destination 192.168.99.2:22

dnsmasq -i br0 --dhcp-range=192.168.99.2,192.168.99.2,255.255.255.252,24h

# launch QEMU -serial telnet:0.0.0.0:1234,server,nowait 
/usr/bin/qemu-system-x86_64 -nographic -serial mon:stdio -device virtio-net,netdev=network0,mac=52:55:00:d1:55:01 -netdev tap,id=network0,ifname=tap0,script=no,downscript=no -m 512 -smp 1 -machine type=pc,accel=kvm -drive file=/root/vyos.img,if=virtio,cache=writeback,discard=ignore,format=qcow2 -boot once=d