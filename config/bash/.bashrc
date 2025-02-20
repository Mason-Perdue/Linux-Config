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
# alias fontUp='setfont ter-132b'
# alias fontDown='setfont'

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

gitCommit(){
	git add .
	git commit -m "$1"
	git push -u origin main;
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
	cd ~/Linux-Config/dot-config/
	stow -t ~/ --restow --dotfiles *
	cd ~/
}

# completion
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

