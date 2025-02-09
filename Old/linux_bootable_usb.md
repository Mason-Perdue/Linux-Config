Edit checksum file to be just correct sha256sum
sha25sum -c sha256sums.txt archlinux-####.##.##-x86_64.iso
look in /dev/disk/by-id for usb id
dd if=archlinux-####.##.##-x86_64.iso of=/dev/disk/by-id/usb-#################### bs= 1M conv=fsync
lsblk to find USB drive
mount /dev/sdc1 /root/mntUSB
Edit checksum file to be just correct sha256sum
sha25sum -c sha256sums.txt archlinux-####.##.##-x86_64.iso
look in /dev/disk/by-id for usb id
dd if=archlinux-####.##.##-x86_64.iso of=/dev/disk/by-id/usb-#################### bs= 1M conv=fsync
umount /root/mntUSB