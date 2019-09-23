FROM alpine:latest
MAINTAINER Yan Grunenberger <yan@grunenberger.net>
RUN apk add --no-cache qemu-system-x86_64 libvirt qemu-img bridge iproute2 dnsmasq iptables
WORKDIR /root
COPY vyos.img /root/vyos.img
COPY docker_run.sh /root/run.sh
ENTRYPOINT ["/bin/sh","/root/run.sh"]
