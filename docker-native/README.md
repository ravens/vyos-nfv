# Docker-based VyOS

This dockerfile build a VyOS run as native container. Highly riskly and untested.

```
curl -o vyos-1.2.1.ova https://cdn.vyos.io/1.2.1.15500/vyos-1.2.1.ova # stable 1.2 
tar xvf  vyos-1.2.1.ova
7z x -ooutput_ova  vyos-1.2.1-disk1.vmdk
mkdir unsquashfs/ 
sudo unsquashfs -f -d unsquashfs/ output_ova/boot/1.2.1/1.2.1.squashfs
sudo tar -C unsquashfs -c . | docker import - vyos
docker-compose build
docker-compose up
```

