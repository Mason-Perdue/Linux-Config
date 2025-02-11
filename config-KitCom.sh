
# Configuration Script for KitCom

sudo timedatectl set-timezone America/Los_Angeles
sudo timedatectl set-ntp true
sudo timedatectl status
sudo pacman -Syu
sudo pacman -S vlc ufw cups simple-scan thunar htop xorg-xwayland alacritty fuzzel gnome-keyring grim gvfs hypridle labwc pamixer pulseaudio pulseaudio-bluetooth seahorse slurp sshfs swaybg swaylock waybar wlr-randr base-devel man-pages man-db cifs-utils dosfstools ntfsprogs exfat-utils # firefox spotify-launcher
cd /home/family/Linux-Config
# https://aur.archlinux.org/packages/google-chrome
curl -LO https://aur.archlinux.org/cgit/aur.git/snapshot/google-chrome.tar.gz
tar -xvf google-chrome.tar.gz
rm google-chrome.tar.gz
cd google-chrome
makepkg -sirc
cd /home/family/Linux-Config
rm -r google-chrome
cp /home/family/Linux-Config/dotbashrc /home/family/.bashrc
sudo cp /home/family/Linux-Config/login /etc/pam.d/login
mkdir /home/family/.config/
mkdir /home/family/.config/alacritty/
cp /home/family/Linux-Config/dotconfig/alacritty/alacritty.toml /home/family/.config/alacritty/alacritty.toml
mkdir /home/family/.config/fuzzel/
cp /home/family/Linux-Config/dotconfig/fuzzel/fuzzel.ini /home/family/.config/fuzzel/fuzzel.ini
mkdir /home/family/.config/helix/
cp /home/family/Linux-Config/dotconfig/helix/config.toml /home/family/.config/helix/config.toml
mkdir /home/family/.config/hypr/
cp /home/family/Linux-Config/dotconfig/hypr/hypridle.conf /home/family/.config/hypr/hypridle.conf
mkdir /home/family/.config/labwc/
cp -r /home/family/Linux-Config/dotconfig/labwc/scripts /home/family/.config/labwc/scripts
chmod +x /home/family/.config/labwc/scripts/*
cp /home/family/Linux-Config/dotconfig/labwc/autstart /home/family/.config/labwc/autostart
# change screen resolution from --preferred to --mode 1366x768@59.790001Hz if needed
cp /home/family/Linux-Config/dotconfig/labwc/menu.xml /home/family/.config/labwc/menu.xml
cp /home/family/Linux-Config/dotconfig/labwc/rc.xml /home/family/.config/labwc/rc.xml
mkdir /home/family/.config/waybar/
cp /home/family/Linux-Config/dotconfig/waybar/config.jsonc /home/family/.config/waybar/config.jsonc
cp /home/family/Linux-Config/dotconfig/waybar/style.css /home/family/.config/waybar/style.css
cp /home/family/Linux-Config/Background.jpg /home/family/.config/Background.jpg
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
sudo gpasswd -a masonp seat
sudo systemctl enable --now seatd.service
pamixer --unmute
sudo reboot now