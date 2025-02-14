
### DO NOT RUN ###

# DO
	# encrypt disk & lock BIOS
	# printing & bluetooth
	# https://wiki.archlinux.org/title/VirtualBox
	# https://wiki.archlinux.org/title/Cron
	# https://wiki.archlinux.org/title/Improving_performance
	# Pause media before screen lock
	# Grub or tty screen resolution
	# Log files
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
echo "TVCom" > /etc/hostname	# or "KitCom" or "masonVM"
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
sudo timedatectl set-timezone America/Los_Angeles
sudo timedatectl set-ntp true
sudo timedatectl status
sudo pacman -Syu
sudo pacman -S vlc ufw cups simple-scan thunar htop xorg-xwayland alacritty fuzzel gnome-keyring grim gvfs hypridle labwc pamixer pulseaudio pulseaudio-bluetooth seahorse slurp sshfs swaybg swaylock waybar wlr-randr base-devel man-pages man-db cifs-utils dosfstools ntfsprogs exfat-utils brightnessctl stow # firefox spotify-launcher
# https://aur.archlinux.org/packages/google-chrome
curl -LO https://aur.archlinux.org/cgit/aur.git/snapshot/google-chrome.tar.gz
tar -xvf google-chrome.tar.gz
rm google-chrome.tar.gz
cd google-chrome
makepkg -sirc
cd ~/Linux-Config
rm -r google-chrome
cd ~/Linux-Config/dotconfig
stow -t ~/ --restow *
sudo cp ~/Linux-Config/login /etc/pam.d/login
chmod +x ~/.config/labwc/scripts/*
sudo ufw default deny incoming
sudo ufw default allow outgoing
# sudo ufw allow from 192.168.0.0/24 to any port 753 proto tcp
# sudo ufw allow CIFS
sudo ufw enable
sudo systemctl enable --now ufw
sudo systemctl status ufw
sudo ufw status verbose
sudo systemctl enable --now cups.service
sudo systemctl enable --now seatd.service
# sudo systemctl enable --now bluetooth
sudo gpasswd -a $USER seat
sudo gpasswd -a $USER video
sudo reboot now