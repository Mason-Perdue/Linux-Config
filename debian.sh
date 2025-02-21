# DO
        # Secure Boot + BIOS Passwords + LUKS/LVM? + BTRFS? + Snapshots?
        # pass & gpg
        # BIOS Passwords
        # backup ssh keys & git config - share ssh keys? on usb?
        # KitCom

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
                sudo apt install man kate git vim stow nmap
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
                sudo apt purge vim-common vim-tiny
        # install software
                sudo apt install man vim git stow
                # https://www.spotify.com/us/download/linux/
        # remove home directories
                rmdir Desktop Documents Music Pictures Public Templates Videos
        # config setup
                git clone https://github.com/Mason-Perdue/Linux-Config.git
                cd ~/Linux-Config/config/
                stow -t ~/ --restow *
	# configure grub
                sudo vim /etc/default/grub
                        # GRUB_TIMEOUT=2
                        # GRUB_GFXMODE=640x480
                        # GRUB_GFXPAYLOAD=keep  # works?
                sudo update-grub

# git
        # generate key pair
                ssh-keygen -t ed25519 -C "perduem08@gmail.com"
                chmod 400 ~/.ssh/id_*
        # start ssh-agent and add key
                eval "$(ssh-agent -s)"
                ssh-add ~/.ssh/id_ed25519-GitHub
        # add public key to github
                cat ~/.ssh/*.pub
                # GitHub.com > Settings > SSH & GPG Keys
                # add twice (auth and sign)
                ssh -vT git@github.com  # -i [path to key]
        # configure git
                git config --global user.name "Mason-Perdue"
                git config --global user.email "perduem08@gmail.com"
                git config --global core.editor vim
                git config --global init.defaultBranch main
                git config --global gpg.format ssh
                git config --global user.signingkey ~/.ssh/id_ed25519-GitHub.pub
                git config --list
        # start repo from github
                # git clone git@github.com:Mason-Perdue/[repo name].git
                # git add .
                # git commit -S -m "[comment]"
                # git push -u origin main
                # git log
                # git pull origin main
        # start new repo
                # git init
                # git remote add origin git@github.com:Mason-Perdue/repo.git
