# Download https://mirrors.ocf.berkeley.edu/archlinux/iso/2025.02.01/archlinux-bootstrap-x86_64.tar.zst
# Open Windows Terminal > Pwsh 7
# wsl --install
# wsl
# set username and password
cd /mnt/d/Downloads
sudo apt install zstd
sudo tar --zstd -xvf archlinux-bootstrap-x86_64.tar.zst
cd root.x86_64
sudo vim etc/pacman.d/mirrorlist
# uncomment: mirrors.ocf.berkeley.edu
sudo tar -czvf root.tar.gz *
mkdir -p /mnt/d/Projects/WSL/Exports
sudo mv root.tar.gz /mnt/d/Projects/WSL/Exports/
exit
# wsl --unregister Ubuntu
# mkdir D:\Projects\WSL\Imports
# wsl --import ArchLinux D:\Projects\WSL\Imports\ArchLinux D:\Projects\WSL\Exports\root.tar.gz
# wsl -l -v
# wsl
pacman-key --init
pacman-key --populate archlinux
pacman-key --refresh-keys
pacman -Sy archlinux-keyring
pacman -Syu
pacman -S base vim reflector sudo rsync git htop base-devel man-pages man-db stow nmap
ln -sf /usr/share/zoneinfo/US/Pacific /etc/localtime
hwclock --systohc
vim /etc/locale.gen
	# uncomment "en_US.UTF-8 UTF-8"
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo FONT=ter-132b > /etc/vconsole.conf
echo TVCom > /etc/hostname
reflector -c "US" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist
passwd
useradd -m masonp # or family
passwd masonp	# or family
EDITOR=vim visudo /etc/sudoers
	# add "masonp ALL=(ALL:ALL) ALL" or "family ALL=(ALL:ALL) ALL"
exit
# wsl --shutdown
# wsl -u masonp
ping archlinux.org
sudo timedatectl set-timezone America/Los_Angeles
sudo timedatectl set-ntp true
sudo timedatectl status
git clone https://github.com/Mason-Perdue/Linux-Config.git
cd ~/Linux-Config/dotconfig
rm ~/.bashrc
stow -t ~/ --restow --dotfiles bashrc vim







sudo nano /etc/wsl.conf
[user]
default = masonp