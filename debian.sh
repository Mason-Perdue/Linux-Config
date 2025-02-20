# DO
        # https://docs.github.com/en/authentication/connecting-to-github-with-ssh/managing-deploy-keys
        # Kate
        # secure boot
        # nmap
        # skanlite vs simple-scan
        # https://wiki.debian.org/LXQt
        # pass & gpg
        # harden ssh
        # BIOS Passwords
        # Drive Encryption (LUKS) at Install + LVM?
        # systemd-boot vs grub
        # btrfs or snapshots?
        # backup ssh keys

# wsl
        # masonp
        # ChromePhone%02
        sudo apt update
        sudo apt upgrade
        sudo apt autoremove
        sudo apt edit-sources
        sudo apt update
        sudo apt purge vim-common vim-tiny
        sudo apt install man kate git vim stow
        rm ~/.bashrc
        stow -t ~/ --restow --dotfiles vim bash
        # git setup
                ssh-keygen -t ed25519 -C "perduem08@gmail.com"
                eval "$(ssh-agent -s)"
                ssh-add ~/.ssh/id_ed25519-GitHub
                cat ~/.ssh/*.pub
                # GitHub.com > Settings > SSH & GPG Keys
                ssh -vT git@github.com # -i [key]
                git config --global user.name "Mason-Perdue"
                git config --global user.email "perduem08@gmail.com"
                git config --global core.editor vim
                git config --global init.defaultBranch main
                git config --list
                # git init
                # git clone git@github.com:Mason-Perdue/repo.git
                # git add .
                # git commit -m "comment"
                # git log
                # git remote add origin git@github.com:Mason-Perdue/repo.git
                # git push -u origin main
                # git pull origin main
                

# UEFI HP Desktop
        # https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.9.0-amd64-netinst.iso
        # TVCom
        # Joyful.House
        # Manual Partioning
                # 1 GB EFI at Beginning
                # 16 GB Swap at End
                # Fill Rest with ext4
        