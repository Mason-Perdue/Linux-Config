
# Configuration Script

echo "// Starting Configuration Script //"

echo "// Configuring Time and Date //"
sudo timedatectl set-timezone America/Los_Angeles
sudo timedatectl set-ntp true
sudo timedatectl status
echo ""

echo "// Installing Packages //"
sudo pacman -Syu
sudo pacman -S vlc ufw cups simple-scan thunar htop xorg-xwayland alacritty fuzzel gnome-keyring grim gvfs hypridle labwc pamixer pulseaudio pulseaudio-bluetooth seahorse slurp sshfs swaybg swaylock waybar wlr-randr base-devel man-pages man-db cifs-utils dosfstools ntfsprogs exfat-utils brightnessctl stow

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

echo "// Stowing Configuration Files //"
cd ~/Linux-Config/dotconfig
stow *
sudo cp ~/Linux-Config/login /etc/pam.d/login
chmod +x ~/.config/labwc/scripts/*
echo "// Edit ~/.config/labwc/autostart to Change Screen Resolution //"
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