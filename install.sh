
### DO NOT RUN ###

# DO
	# encrypt disk & lock BIOS
	# printing & bluetooth
	# https://wiki.archlinux.org/title/VirtualBox
	# https://wiki.archlinux.org/title/Cron
	# https://wiki.archlinux.org/title/Improving_performance
	# Systemd bootloader 
	# Pause media before screen lock 
	# Grub or tty screen resolution 
	# Wlr-randr
	# Links/stow
	# Log files
	# Background image
	# https://192.168.0.30:80/WebServices/Device
	# https://louwrentius.com/recycle-your-old-laptop-display-and-turn-it-into-a-monitor.html

ip a
rfkill list
timedatectl
# for wifi
iwctl
	device list
	station [device] scan
	station [device] get-networks
	station [device] connect [wifi name]
	# enter passphrase
	exit
ping archlinux.org
fdisk -l
setfont ter-132b	# setfont to undo
cat /sys/firmware/efi/fw_platform_size	# 64 or 32 for UEFI; nothing for Legacy BIOS
fdisk /dev/sda
# for UEFI
	d
	n
	+1000M
	t
	1
	n
	+8000M
	t
	19
	n
	w
# for Legacy BIOS
	d
	n
	+8000M
	t
	82	# ?
	n
	w
fdisk -l /dev/sda
# for UEFI
	mkfs.fat -F 32 /dev/sda1
	mkswap /dev/sda2
	swapon /dev/sda2
	mkfs.ext4 /dev/sda3
	mount /dev/sda3 /mnt
	mount --mkdir /dev/sda1 /mnt/boot
# for Legacy BIOS
	mkswap /dev/sda1
	swapon /dev/sda1
	mkfs.ext4 /dev/sda2
	mount /dev/sda2 /mnt
lsblk
pacstrap -K /mnt base linux linux-firmware intel-ucode helix grub efibootmgr reflector sudo networkmanager rsync xf86-video-intel terminus-font git
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/US/Pacific /etc/localtime
hwclock --systohc
helix /etc/locale.gen
	# uncomment "en_US.UTF-8 UTF-8"
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "FONT=ter-132b" >  /etc/vconsole.conf
echo "TVCom" > /etc/hostname	# or "KitCom"
# for UEFI
	grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot
	grub-mkconfig -o /boot/grub/grub.cfg
# for Legacy BIOS
	grub-install --target=i386-pc /dev/sda
	grub-mkconfig -o /boot/grub/grub.cfg
pacman -Syu
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
reflector -c "US" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist
passwd
useradd -m masonp # or family
passwd masonp	# or family
EDITOR=helix visudo /etc/sudoers
	# add "masonp ALL=(ALL:ALL) ALL" or "family ALL=(ALL:ALL) ALL"
systemctl enable NetworkManager.service
exit
shutdown now

ping archlinux.org
# for Wifi
	nmcli device wifi list
	nmcli device wifi connect [name] password [pw]
	nmcli connection show
	nmcli device
	ping archlinux.org
git clone https://github.com/Mason-Perdue/Linux-Config.git
cd Linux-Config
chmod +x config-KitCom.sh	# or config-TVCom.sh
./config-KitCom.sh > log.txt	# or config-TVCom.sh