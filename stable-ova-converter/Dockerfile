FROM ubuntu:18.04
RUN apt-get -qy update
RUN apt-get -qy install syslinux isolinux xorriso mkisofs squashfs-tools p7zip-full python3-pip curl qemu rsync
WORKDIR /root
COPY vyos-rolling-release-fetch.py /root/vyos-rolling-release-fetch.py
COPY requirements.txt /root/requirements.txt
RUN pip3 install --user --requirement requirements.txt
RUN mkdir unsquashfs/ original_iso/ iso/ output/ download/
COPY download_iso.sh /root/download_iso.sh
ENTRYPOINT ["/bin/sh","/root/download_iso.sh"]