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

reloadConfig() {
	cd ~/
	rm -rf Linux-Config
	git clone https://github.com/Mason-Perdue/Linux-Config.git
	cd ~/Linux-Config/config/
	stow -t ~/ --restow *
	cd ~/
}

totp(){
	oathtool -b --totp "$1"
}

pwEdit(){
	gpg --output ~/pw.txt --decrypt /mnt/d/Drive/PW/pw.txt.gpg
	vim ~/pw.txt
	gpg --output /mnt/d/Drive/PW/pw.txt.gpg --encrypt --sign --yes --recipient perduem08@gmail.com ~/pw.txt
	rm -f ~/pw.txt
}

rmGnomeExtras(){
	sudo apt purge -y vim-common vim-tiny gnome-games gnome-2048 gnome-chess gnome-klotski gnome-nibbles gnome-robots gnome-sudoku gnome-taquin gnome-tetravex gnome-mahjongg gnome-mines five-or-more aisleriot transmission* synaptic
	sudo apt autoremove --purge -y
}