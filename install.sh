
### DO NOT RUN ###

# DO
	# https://wiki.archlinux.org/title/Improving_performance
	# https://wiki.archlinux.org/title/Kernel_parameters#Parameter_list
	# https://wiki.archlinux.org/title/VirtualBox/Install_Arch_Linux_as_a_guest

# download from https://mirrors.ocf.berkeley.edu/archlinux/iso
# sudo dd bs=4M if=archlinux-x86_46.iso of=/dev/disk/by-id/usb-_USB_DISK_...-0:0 conv=fsync oflag=direct status=progress
# VirtualBox: Arch Linux, ISO, 12GB Memory, 12 CPU, 50 GB HD (SSD), PS/2 Mouse, Bridged Adapter, USB 3.0, Full Screen
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
	g
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
	o
	n
	+8000M
	t
	82
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
pacstrap -K /mnt base linux linux-firmware intel-ucode vim reflector sudo networkmanager rsync xf86-video-intel terminus-font git # grub efibootmgr
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/US/Pacific /etc/localtime
hwclock --systohc
vim /etc/locale.gen
	# uncomment "en_US.UTF-8 UTF-8"
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo FONT=ter-132b > /etc/vconsole.conf
echo TVCom > /etc/hostname	# or "KitCom" or "masonVM" or "masonDT"
# systemd-boot
	ls /sys/firmware/efi/efivars
	bootctl install
	cat /boot/loader/loader.conf
	systemctl enable systemd-boot-update.service
# for UEFI
	grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot
	grub-mkconfig -o /boot/grub/grub.cfg
# for Legacy BIOS
	grub-install --target=i386-pc /dev/sda
	grub-mkconfig -o /boot/grub/grub.cfg
pacman -Syu
reflector -c "US" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist
passwd
useradd -m masonp # or family
passwd masonp	# or family
EDITOR=vim visudo /etc/sudoers
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
sudo timedatectl set-timezone America/Los_Angeles
sudo timedatectl set-ntp true
sudo timedatectl status
sudo pacman -Syu
sudo pacman -S ufw htop gvfs sshfs base-devel man-pages man-db cifs-utils dosfstools ntfsprogs exfat-utils stow # vlc cups simple-scan thunar xorg-xwayland alacritty fuzzel gnome-keyring grim hypridle labwc pamixer pulseaudio pulseaudio-bluetooth seahorse slurp swaybg swaylock waybar wlr-randr brightnessctl cups-pdf # firefox spotify-launcher veracrypt # openssh
git clone https://github.com/Mason-Perdue/Linux-Config.git
cd ~/Linux-Config
# https://aur.archlinux.org/packages/google-chrome
# curl -LO https://aur.archlinux.org/cgit/aur.git/snapshot/google-chrome.tar.gz
# tar -xvf google-chrome.tar.gz
# rm google-chrome.tar.gz
# cd google-chrome
# makepkg -sirc
# cd ~/Linux-Config
# rm -r google-chrome
cd ~/Linux-Config/dotconfig
rm ~/.bashrc
stow -t ~/ --restow --dotfiles * # bash vim
# change autostart in ~/.bashrc if necessary
sudo cp ~/Linux-Config/login /etc/pam.d/login
chmod +x ~/.config/labwc/scripts/*
# sudo vim /etc/ssh/sshd.config
	# Port 753
	# PermitRootLogin no
sudo ufw default deny incoming
sudo ufw default allow outgoing
# sudo ufw allow from 192.168.0.0/24 to any port 753 proto tcp
# sudo ufw allow CIFS
sudo ufw enable
sudo systemctl enable --now ufw.service
sudo systemctl status ufw.service
sudo ufw status verbose
sudo systemctl enable --now cups.service
sudo systemctl enable --now seatd.service
# sudo systemctl enable --now sshd.service
# sudo systemctl enable --now bluetooth
sudo gpasswd -a $USER seat
sudo gpasswd -a $USER video
sudo groupadd lpadmin
sudo gpasswd -a $USER lpadmin
# open cups > add printer > lpd://192.168.0.30/queue
# GRUB > c > videoinfo
# sudo vim /etc/default/grub
	# VM: GRUB_GFXMODE=1280x1024x32
	# GRUB_TIMEOUT=2
	# GRUB_TIMEOUT_STYLE=countdown
	# Use ESC to see GRUB Menu during countdown
# sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo reboot now
pactl list
pactl set-default-sink 0