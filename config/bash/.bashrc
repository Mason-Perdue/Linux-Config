# not running interactively
case $- in
	*i*) ;;
	  *) return;;
esac

# history config
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# update window size
shopt -s checkwinsize

# bash prompt
PS1='\[\e[32m\]\u\[\e[38;5;26m\]@\h\[\e[0m\] \[\e[38;5;220m\][\w]\[\e[0m\] \[\e[92m\]\$\[\e[0m\] '

# variables
export EDITOR='vim'

# aliases
alias bashUp='source ~/.bashrc'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -la'
alias ip='ip -c'
alias la='ls -a'
alias cu='cd ..'
alias mkdir='mkdir -p'
alias debUp='sudo apt update && sudo apt upgrade -y && sudo apt autoremove --purge -y'
alias pacup='sudo pacman -Syu'
alias paclean='sudo pacman -Scc && sudo pacman -R $(pacman -Qdtq)'
alias packey='sudo pacman -S archlinux-keyring'
alias msg='echo "Enter Message: " && read msg && curl -d "$msg" ntfy.sh/A76bd4Z5Ijvc672'
alias fontUp='setfont ter-132b'
alias fontDown='setfont'
alias productKey='echo "y" | sudo pacman -S acpica && sudo acpidump -n MSDM && echo "\n//Last five sets of five letters/numbers//\n"'
alias chromeInstall='cd ~/src && curl -LO https://aur.archlinux.org/cgit/aur.git/snapshot/google-chrome.tar.gz && tar -xvf google-chrome.tar.gz && rm google-chrome.tar.gz && cd google-chrome && makepkg -sirc && cd ~/src && rm -r google-chrome && cd'

# functions
jexe(){
	javac "$1.java"
	java "$1"
	rm *.class
}

lexe(){
	pdflatex "$1.tex"
}

bexe(){
	chmod +x "$1.sh"
	./"$1.sh"
}

gitKey(){
	eval "$(ssh-agent -s)"
	ssh-add /mnt/d/Projects/GitHub/key/id_ed25519-GitHub
}

gitCommit(){
	git add .
	git commit -S -m "$1"
	git push -u origin main
}

runASM() {
	if [[ $1 == "c" ]]
	then
		nasm -felf64 $2.asm
		gcc $2.o
		./a.out
		rm $2.o $2
	else
		nasm -felf64 $1.asm
		ld $1.o -o $1
		./$1
		rm $1.o $1
	fi
}

reloadConfig() {
	cd ~/
	rm -rf Linux-Config
	git clone https://github.com/Mason-Perdue/Linux-Config.git
	cd ~/Linux-Config/config/
	stow -t ~/ --restow *
	cd ~/
}

#debian
rmGnomeExtras(){
	sudo apt purge -y vim-common vim-tiny gnome-games gnome-2048 gnome-chess gnome-klotski gnome-nibbles gnome-robots gnome-sudoku gnome-taquin gnome-tetravex gnome-mahjongg gnome-mines five-or-more aisleriot transmission* synaptic
	sudo apt autoremove --purge -y
}