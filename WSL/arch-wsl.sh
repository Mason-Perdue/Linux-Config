
# Install archlinux for WSL2 on Windows 11
# https://wiki.archlinux.org/title/Install_Arch_Linux_on_WSL

# DO: usbipd, git, ssh

# change wsl networking mode to mirrored
# wsl --update
# wsl --list --online
# wsl --install archlinux
# wsl --list --verbose
# wsl
pacman -Syu
pacman -S vim
useradd -m masonp
passwd
passwd masonp
vim /etc/wsl.conf
exit
# wsl --terminate archlinux
# wsl -u root
vim /mnt/c/Users/perdu/.wslconfig
vim /etc/tmpfiles.d/wslg.conf
vim /etc/profile.d/wslg.sh
exit
# wsl --terminate archlinux
# wsl -u root
pacman -S mesa vulkan-dzn vulkan-icd-loader
ln -s /usr/lib/libedit.so /usr/lib/libedit.so.2
ip a
ping archlinux.org
pacman -S sudo rsync reflector git
ls -sf /usr/share/zoneinfo/US/Pacific /etc/localtime
vim /etc/locale.gen
# uncomment "en_US.UTF-8 UTF-8"
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo archWSL > /etc/hostname
reflector -c "US" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist
EDITOR=vim visudo /etc/sudoers
# add "masonp ALL=(ALL:ALL) ALL" or "family ALL=(ALL:ALL) ALL"
exit
# wsl --terminate archlinux
# wsl
sudo timedatectl status
sudo pacman -S ufw htop gvfs sshfs base-devel man-pages man-db cifs-utils dosfstools ntfsprogs exfat-utils stow tree
git clone https://github.com/Mason-Perdue/Linux-Config.git
cd ~/Linux-Config/dotconfig
rm ~/.bashrc
stow -t ~/ --restow --dotfiles bash vim
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
sudo systemctl enable --now ufw.service
sudo systemctl status ufw.service
sudo ufw status verbose
# wsl
pacup
paclean
reloadConfig
bashUp
ssh-keygen -t ed25519 -C "perduem08@gmail.com"
chmod 400 ~/.ssh/id_*
cat ~/.ssh/*.pub
# GitHub.com > Settings > SSH & GPG Keys
# add twice (auth and sign)
ssh -vT git@github.com  # -i [path to key]
# start repo from github
git clone git@github.com:Mason-Perdue/[repo name].git
gitCommit [comment]
git log
git pull origin main
# start new repo
git init
git remote add origin git@github.com:Mason-Perdue/[repo name].git
# force signing
git config --local commit.gpgsign true