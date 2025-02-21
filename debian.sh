# DO
        # secure boot
        # nmap
        # skanlite vs simple-scan
        # https://wiki.debian.org/LXQt
        # pass & gpg
        # harden ssh
        # BIOS Passwords
        # Drive Encryption (LUKS) at Install + LVM?
        # btrfs or snapshots?
        # backup ssh keys & git config

# wsl
        # masonp
        sudo apt update
        sudo apt upgrade
        sudo apt autoremove
        sudo apt edit-sources
        sudo apt update
        sudo apt purge vim-common vim-tiny
        sudo apt install man kate git vim stow
		rm ~/.bashrc
        stow -t ~/ --restow --dotfiles vim bash
        source ~/.bashrc
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
                git config --global gpg.format ssh
                git config --global user.signingkey ~/.ssh/id_ed25519-GitHub.pub
                git config --list
                # git init
                # git clone git@github.com:Mason-Perdue/repo.git
                # git add .
                # git commit -S -m "comment"
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
        # masonp
	sudo apt update
	sudo apt upgrade
	sudo apt autoremove
	sudo apt edit-sources
	sudo apt purge vim-common vim-tiny
	sudo apt install man vim kate git stow
	rmdir Desktop Documents Music Pictures Public Templates Videos
	git clone https://github.com/Mason-Perdue/Linux-Config.git
	cd Linux-Config/config/
	stow -t ~/ --restow *
	curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt-get update && sudo apt-get install spotify-client
        sudo vim /etc/default/grub
                # GRUB_TIMEOUT=2
                # GRUB_GFXMODE=640x480
                # GRUB_GFXPAYLOAD=keep
        sudo update-grub
