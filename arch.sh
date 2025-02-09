
### DO NOT RUN ###

# DO
	# encrypt disk & lock BIOS
	# printing
	# https://wiki.archlinux.org/title/VirtualBox
	# https://wiki.archlinux.org/title/GNOME/Keyring
	# https://wiki.archlinux.org/title/Autostarting
	# https://wiki.archlinux.org/title/Cron
	# https://wiki.archlinux.org/title/Improving_performance
	# https://arewewaylandyet.com/
	# https://labwc.github.io/index.html

ip a
ping archlinux.org
rfkill list
timedatectl
# for wifi
	iwctl
	device list
	station [device] scan
	station [device] get-networks
	station [device] connect [wifi name]
	enter passphrase
	exit
	ping archlinux.org
fdisk -l
setfont ter-132b
# setfont to undo
cat /sys/firmware/efi/fw_platform_size # 64 or 32 for UEFI; nothing for Legacy BIOS
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
pacstrap -K /mnt base linux linux-firmware intel-ucode helix grub efibootmgr reflector man-pages man-db sudo networkmanager rsync cifs-utils xf86-video-intel dosfstools ntfsprogs exfat-utils terminus-font
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/US/Pacific /etc/localtime
hwclock --systohc
helix /etc/locale.gen
# uncomment "en_US.UTF-8 UTF-8"
locale-gen
helix /etc/locale.conf
# add LANG=en_US.UTF-8
helix /etc/vconsole.conf
# add FONT=ter-132b
helix /etc/hostname
# add "TVCom" or "KitCom"
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
sudo timedatectl set-timezone America/Los_Angeles
sudo timedateclt set-ntp true
sudo timedatectl status
sudo pacman -Syu
sudo pacman -S vlc ufw cups curl simple-scan foot thunar htop xorg-xwayland lftp # firefox spotify-launcher
# for Chrome
	mkdir /home/family/AUR/
	cd /home/family/AUR/
	curl -LO https://aur.archlinux.org/cgit/aur.git/snapshot/google-chrome.tar.gz
	tar -xvf google-chrome.tar.gz
	rm google-chrome.tar.gz
	cd google-chrome
	makepkg -sirc
	rm -r /home/family/AUR
mkdir ftp
cd ftp
lftp admin:admin@192.168.0.1/G/Mason/Linux
	ls
	mirror
	exit
cp ~/.bashrc ~/.bashrc.bak
mv ~/ftp/.bashrc ~/.bashrc
source ~/.bashrc
sudo ufw default deny incoming
sudo ufw default allow outgoing
# sudo ufw allow from 192.168.0.0/24 to any port 753 proto tcp
# sudo ufw allow CIFS
sudo ufw enable
sudo systemctl enable --now ufw
sudo systemctl status ufw
sudo ufw status verbose
sudo systemctl enable --now cups.service
# sudo systemctl enable --now bluetooth
mkdir ~/.config/helix
mv ~/ftp/config.toml ~/.config/helix/config.toml
mkdir ~/.config/foot
mv ~/ftp/foot.ini ~/.config/foot/foot.ini
	cat /usr/share/foot/themes
paclean
sudo reboot now
# labwc
	sudo pacman -S labwc
	sudo gpasswd -a masonp seat
	sudo systemctl enable --now seatd.service
	sudo reboot now
	sudo pacman -S alacrity
	mkdir ~/.config/alacritty/
	cp ~/ftp/Old/alacritty.toml ~/.config/alacritty/
	sudo pacman -Runs foot
	# windows+enter to open alacritty
	mkdir ~/.config/labwc
	# default configs in /usr/share/doc/labwc
	# add polkit agent to autostart?
	
