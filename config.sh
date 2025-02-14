
# Configuration Script

echo "// Starting Configuration Script //"

echo "// Configuring Time and Date //"
sudo timedatectl set-timezone America/Los_Angeles
sudo timedatectl set-ntp true
sudo timedatectl status
echo ""

echo "// Installing Packages //"
sudo pacman -Syu
sudo pacman -S vlc ufw cups simple-scan thunar htop xorg-xwayland alacritty fuzzel gnome-keyring grim gvfs hypridle labwc pamixer pulseaudio pulseaudio-bluetooth seahorse slurp sshfs swaybg swaylock waybar wlr-randr base-devel man-pages man-db cifs-utils dosfstools ntfsprogs exfat-utils brightnessctl

echo "// Install Firefox and Spotify (y/n): "
read check
if [ $check == "y" ]
then
        echo "// Installing Firefox and Spotify //"
        sudo pacman -S firefox spotify-launcher
fi
echo ""

cd ~/Linux-Config

echo "// Chrome Repository: https://aur.archlinux.org/packages/google-chrome //"
echo "// Install Chrome (y/n): "
read check
if [ $check == "y"]
then
        echo "// Installing Chrome //"
        curl -LO https://aur.archlinux.org/cgit/aur.git/snapshot/google-chrome.tar.gz
        tar -xvf google-chrome.tar.gz
        rm google-chrome.tar.gz
        cd google-chrome
        makepkg -sirc
        cd ~/Linux-Config
        rm -r google-chrome
fi
echo ""

echo "// Moving Configuration Files //"
cp ~/Linux-Config/dotbashrc ~/.bashrc
sudo cp ~/Linux-Config/login /etc/pam.d/login
mkdir ~/.config/
mkdir ~/.config/alacritty/
cp ~/Linux-Config/dotconfig/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
mkdir ~/.config/fuzzel/
cp ~/Linux-Config/dotconfig/fuzzel/fuzzel.ini ~/.config/fuzzel/fuzzel.ini
mkdir ~/.config/helix/
cp ~/Linux-Config/dotconfig/helix/config.toml ~/.config/helix/config.toml
mkdir ~/.config/hypr/
cp ~/Linux-Config/dotconfig/hypr/hypridle.conf ~/.config/hypr/hypridle.conf
mkdir ~/.config/labwc/
cp -r ~/Linux-Config/dotconfig/labwc/scripts ~/.config/labwc/scripts
chmod +x ~/.config/labwc/scripts/*
cp ~/Linux-Config/dotconfig/labwc/autostart ~/.config/labwc/autostart
echo "// Edit ~/.config/labwc/autostart to Change Screen Resolution //"
cp ~/Linux-Config/dotconfig/labwc/menu.xml ~/.config/labwc/menu.xml
cp ~/Linux-Config/dotconfig/labwc/rc.xml ~/.config/labwc/rc.xml
mkdir ~/.config/waybar/
cp ~/Linux-Config/dotconfig/waybar/config.jsonc ~/.config/waybar/config.jsonc
cp ~/Linux-Config/dotconfig/waybar/style.css ~/.config/waybar/style.css
cp ~/Linux-Config/Background.jpg ~/.config/Background.jpg
echo ""

echo "// Configuring Firewall Rules //"
sudo ufw default deny incoming
sudo ufw default allow outgoing
echo "// Run "sudo ufw allow from 192.168.0.0/24 to any port 753 proto tcp" to Allow SSH //"
echo "// Run "sudo ufw allow CIFS" to allow Samba //"
sudo ufw enable
sudo systemctl enable --now ufw
sudo systemctl status ufw
sudo ufw status verbose
echo ""

echo "// Enabling Services //"
sudo systemctl enable --now cups.service
sudo systemctl enable --now seatd.service
echo "// Run "sudo systemctl enable --now bluetooth" to Enable Bluetooth //"
echo ""

echo "// Adding User to Groups //"
sudo gpasswd -a $USER seat
sudo gpasswd -a $USER video
echo ""

echo "// Restarting Now (y/n): "
read check
if [ $check == "y" ]
then
        echo "// Restarting //"
        sudo reboot now
fi