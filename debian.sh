# DO
    # Secure Boot + BIOS Passwords + LUKS/LVM? + BTRFS? + Snapshots?
    # Debian on KitCom
    # Add PIN to Passwords
    # SD Card
    # Uninstall Wine & Check Packages on TVCom and FireWall

# make bootable usb
    # https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.9.0-amd64-netinst.iso
    # linux
        sha25sum -c sha256sums.txt *.iso
        dd if=*.iso of=/dev/disk/by-id/usb-#################### bs= 1M conv=fsync

# WSL
    # install
        # masonp
    # configure apt
        sudo apt update
        sudo apt upgrade
        sudo apt autoremove
        sudo apt edit-sources
        # add contrib non-free non-free-firmware
        sudo apt update
    # remove software
        sudo apt purge vim-common vim-tiny
    # add software
        sudo apt install man git vim stow nmap texlive tree htop oathtool gnupg
    # config setup
        rm ~/.bashrc
        eval "$(ssh-agent -s)"
        ssh-add /mnt/d/Projects/GitHub/key/id_ed25519-GitHub
        cd ~/
        git clone git@github.com:Mason-Perdue/Linux-Config.git
        cd ~/Linux-Config/config/
        stow -t ~/ --restow *
        source ~/.bashrc
    # gpg password file
        # to generate keys
            gpg --full-generate-key
            gpg --list-keys
            gpg --export --armor --output public-key.asc
            gpg --export-secret-keys --armor --output private-key.asc
        # to import keys
            gpg --import public-key.asc
            gpg --inport private-key.asc
            gpg --edit-key [key-id]
                # trust
                # 5
                # quit
            gpg --list-keys

# git
    # generate key pair
        ssh-keygen -t ed25519 -C "perduem08@gmail.com"
        chmod 400 ~/.ssh/id_*
    # add public key to github
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

# TVCom or KitCom
    # install
        # TVCom or KitCom
        # Joyful.House
        # Manual Partioning
            # 1 GB EFI at Beginning
            # 16 GB Swap at End
            # EXT4 in Middle
        # masonp or family
    # configure apt
        sudo apt update
        sudo apt upgrade
        sudo apt autoremove
        sudo apt edit-sources
    # remove software
        sudo apt purge vim-common vim-tiny aisleriot evolution four-in-a-row hitori hoichess iagno libreoffice lightsoff lynx malcontent orca quadrapassel swell-foop synaptic tali
    # install software
        sudo apt install man vim git stow tree htop
        # https://www.spotify.com/us/download/linux/
        # https://www.google.com/intl/en_uk/chrome/?platform=linux
    # remove home directories
        rmdir Desktop Documents Music Pictures Public Templates Videos
    # config setup
        cd ~/
        rm ~/.bashrc
        git clone https://github.com/Mason-Perdue/Linux-Config.git
        cd ~/Linux-Config/config/
        stow -t ~/ --restow *
    # configure gdm
        # after setting display resolution in gnome settings
        sudo cp ~/.config/monitors.xml /var/lib/gdm3/.config/
    # firewall
        sudo ufw enable
        sudo systemctl enable --now ufw.service
        sudo systemctl status ufw.service
        sudo ufw status verbose
