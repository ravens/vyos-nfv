FROM alpine:latest
MAINTAINER Yan Grunenberger <yan@grunenberger.net>
RUN apk add --no-cache qemu-system-x86_64 libvirt qemu-img bridge iproute2
WORKDIR /root
COPY build_qemu/vyos.img /root/vyos.img
COPY docker_run.sh /root/docker_run.sh
ENTRYPOINT ["/bin/sh","/root/run.sh"]