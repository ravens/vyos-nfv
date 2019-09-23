#!/bin/sh

if [ ! -f "/root/download/vyos-1.2.1.ova" ];then
	echo "Fetching VyOS OVA image"
	curl -o ./download/vyos-1.2.1.ova https://cdn.vyos.io/1.2.1.15500/vyos-1.2.1.ova 
fi

if [ ! -f "/root/download/vyos-1.2-rolling.iso" ];then
	echo "Fetching VyOS rolling image"
	curl -o ./download/vyos-1.2-rolling.iso  `python3 vyos-rolling-release-fetch.py | head -n 1`
fi


tar xvf  ./download/vyos-1.2.1.ova
rm -Rf output_ova
7z x -ooutput_ova  vyos-1.2.1-disk1.vmdk
unsquashfs -f -d unsquashfs/ output_ova/boot/1.2.1/1.2.1.squashfs
mount -o loop /root/download/vyos-1.2-rolling.iso /root/original_iso # mount the rolling image ISO
rsync  -av /root/original_iso/ /root/iso/ # copy the content
umount /root/original_iso # unmount the ISO
cp output_ova/boot/1.2.1/1.2.1.squashfs iso/live/filesystem.squashfs
cp output_ova/boot/1.2.1/initrd.img iso/live/initrd.img
cp output_ova/boot/1.2.1/vmlinuz iso/live/vmlinuz
chroot unsquashfs dpkg -l > iso/live/packages.txt
chroot unsquashfs dpkg-query -W --showformat='${Package} ${Version}\n' > iso/live/filesystem.packages
find iso -type f -print0 | xargs -0 md5sum | sed "s@iso@.@" | grep -v md5sum.txt > iso/md5sum.txt
cd iso
xorriso -as mkisofs -o /root/output/vyos-1.2.iso -isohybrid-mbr /usr/lib/ISOLINUX/isohdpfx.bin  -R -J -T -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-boot -eltorito-alt-boot -e efi.img -no-emul-boot -c isolinux/boot.cat -b isolinux/isolinux.bin .
cd ..
qemu-img convert -f vmdk -O qcow2 vyos-1.2.1-disk1.vmdk output/vyos-1.2.1.qcow2

exit 0