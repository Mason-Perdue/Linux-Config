# DO
        # Secure Boot + BIOS Passwords + LUKS/LVM? + BTRFS? + Snapshots?
        # pass & gpg
        # BIOS Passwords
        # backup ssh keys on usb?
        # KitCom
		# alias pm='vim -c "set viminfo= nobackup nowritebackup noundofile noswapfile" ~/.passwords' or vim-redact-pass

# WSL
        # install
                # masonp
        # configure apt
                sudo apt update
                sudo apt upgrade
                sudo apt autoremove
                sudo apt edit-sources
                sudo apt update
        # remove software
                sudo apt purge vim-common vim-tiny
        # add software
                sudo apt install man kate git vim stow nmap texlive tree htop
        # config setup
                rm ~/.bashrc
                # copy ssh key files
                eval "$(ssh-agent -s)"
                ssh-add ~/.ssh/id_ed25519-GitHub
                git clone git@github.com:Mason-Perdue/Linux-Config.git
                cd ~/Linux-Config/config/
                stow -t ~/ --restow *
                source ~/.bashrc

# TVCom - HP Desktop - UEFI
        # install
                # https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.9.0-amd64-netinst.iso
                # TVCom
                # Joyful.House
                # Manual Partioning
                        # 1 GB EFI at Beginning
                        # 16 GB Swap at End
                        # EXT4 in Middle
                # masonp
        # configure apt
                sudo apt update
                sudo apt upgrade
                sudo apt autoremove
                sudo apt edit-sources
        # remove software
                sudo apt purge vim-common vim-tiny aisleriot evolution four-in-a-row hitori hoichess iagno libreoffice lightsoff lynx malcontent orca quadrapassel swell-foop synaptic tali
        # install software
                sudo apt install man vim git stow
                # https://www.spotify.com/us/download/linux/
        # remove home directories
                rmdir Desktop Documents Music Pictures Public Templates Videos
        # config setup
                git clone https://github.com/Mason-Perdue/Linux-Config.git
                cd ~/Linux-Config/config/
                stow -t ~/ --restow *
        # configure gdm
                # after setting display resolution in gnome settings
                sudo cp ~/.config/monitors.xml /var/lib/gdm3/.config/

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

# pass
    sudo apt install pass pass-otp
    gpg --full-generate-key    
    gpg --list-keys
    gpg --export --armor --output public-key.asc
    gpg --import public-key.asc
    gpg --export-secret-keys --armor --output private-key.asc
    gpg --import private-key.asc
    gpg --edit-key [key-id]
        # trust
        # 5
        # quit
    pass init "perduem08@gmail.com"
    pass git remote add origin git@github.com:Mason-Perdue/Passwords.git
    git push -u origin main    

