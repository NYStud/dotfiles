export GIT_AUTHOR_EMAIL=pallih@kaninka.net
export GIT_AUTHOR_NAME='Páll Hilmarsson'
export GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL
export GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME

# PERL PATHS

export PERL_LOCAL_LIB_ROOT="/Users/pallih/perl5:$PERL_LOCAL_LIB_ROOT";
export PERL_MB_OPT="--install_base "/Users/pallih/perl5"";
export PERL_MM_OPT="INSTALL_BASE=/Users/pallih/perl5";
export PERL5LIB="/Users/pallih/perl5/lib/perl5:$PERL5LIB";
export PATH="/Users/pallih/perl5/bin:$PATH";

export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

export HISTFILE=~/.bash-history-${ITERM_SESSION_ID}

# DATAMARKET DROPBOX ROOTPATH:
export DM_DROPBOX_ROOTPATH="/Users/pallih/Dropbox-DataMarket/Dropbox"

#MYSQL PATH
export PATH="/usr/local/mysql/bin:$PATH"

#SPSS 20 python libs:
export DYLD_LIBRARY_PATH=DYLD_LIBRARY_PATH:/Applications/IBM/SPSS/Statistics/20/SPSSStatistics.app/Contents/lib

#Metasploit config
export MSF_DATABASE_CONFIG=/opt/msf/database.yml

#Color in terminal
export CLICOLOR=1

# various color stuff - grc - http://kassiopeia.juls.savba.sk/~garabik/software/grc/README.txt
source "`brew --prefix grc`/etc/grc.bashrc"

alias lstree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias tree="tree -NC"

export EDITOR='subl'

#export EDITOR="'/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl'"
alias subl="$EDITOR"
alias edit="$EDITOR"
# Open file in a real text editor,
# if you happen to type nano from your muscle memory
#alias pico="subl"
#alias edit="subl"

###ALIASES###

# IP addresses

# returns a list of IP addresses from given domain(s).
#
# Examples:
#  dns2ip google.com
#  dns2ip netflix.com movies.netflix.com
#
function dns2ip() {
  dig +short $* | sed "/[^0-9\.]/d" # use sed to remove non-IPv4 line e.g. alias
}

function mask(){

if [ -z $1 ]
then
  change="none"
elif [ -n $1 ]
then
# otherwise make first arg as our arg
  change=$1
fi

# use case statement
case $change in
   "host") NEWHOST=$(sed `perl -e "print int rand(99999)"`"q;d" /usr/share/dict/words)
    	echo "Changing hostname from: " $(hostname)
    	sudo scutil --set HostName "$NEWHOST"
    	sleep 2
    	echo "New hostname is:" $(hostname);;
   "mac") NEWMAC=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
    	echo "Changing MAC from: " $(ifconfig en0 | grep ether)
    	sudo ifconfig en0 ether $NEWMAC
    	echo "New MAC is:" $(ifconfig en0 | grep ether);;
   "all") NEWMAC=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
    echo "Changing MAC from: " $(ifconfig en0 | grep ether)
    sudo ifconfig en0 ether $NEWMAC
    echo "New MAC is:" $(ifconfig en0 | grep ether)
    NEWHOST=$(sed `perl -e "print int rand(99999)"`"q;d" /usr/share/dict/words)
    echo "Changing hostname from: " $(hostname)
    sudo scutil --set HostName "$NEWHOST"
    sleep 2
    echo "New hostname is:" $(hostname);;
   *) echo "Your MAC address"$(ifconfig en0 | grep ether)
	  echo "Your hostname: " $(hostname)
	  echo "Usage: mask host | mask mac | mask all";;
esac

}


alias ip="curl ifconfig.me"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"
alias dnsflush="sudo killall -HUP mDNSResponder"

# paths
alias path='echo -e ${PATH//:/\\n}'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Activate the screensaver
alias lockout='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine'

# Random password string. Pass integer for length
function randpass() {
  jot -r -c $* . z | rs -g 0 $*
}

# Custom TOR configs
alias torice="tor -f ~/.torrc/torrc-exit-iceland"
alias torall="tor -f ~/.torrc/torrc-exit-all"
# Make Iceland exit default
alias tor=torice

# Alias proxychains
alias proxy=proxychains4

# #virtualenv
#export WORKON_HOME=~/Envs
# THIS IS SLOOOOOOOOOW
#source /usr/local/bin/virtualenvwrapper.sh
# THIS IS BETTER:
#source ~/.bashrc.virtualenvwrapper

# @gf3’s Sexy Bash Prompt, inspired by “Extravagant Zsh Prompt”
# Shamelessly copied from https://github.com/gf3/dotfiles
# Screenshot: http://i.imgur.com/s0Blh.png

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
	tput sgr0
	if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
		MAGENTA=$(tput setaf 9)
		ORANGE=$(tput setaf 172)
		GREEN=$(tput setaf 190)
		PURPLE=$(tput setaf 141)
		WHITE=$(tput setaf 256)
	else
		MAGENTA=$(tput setaf 5)
		ORANGE=$(tput setaf 4)
		GREEN=$(tput setaf 2)
		PURPLE=$(tput setaf 1)
		WHITE=$(tput setaf 7)
	fi
	BOLD=$(tput bold)
	RESET=$(tput sgr0)
else
	MAGENTA="\033[1;31m"
	ORANGE="\033[1;33m"
	GREEN="\033[1;32m"
	PURPLE="\033[1;35m"
	WHITE="\033[1;37m"
	BOLD=""
	RESET="\033[m"
fi

export MAGENTA
export ORANGE
export GREEN
export PURPLE
export WHITE
export BOLD
export RESET

function parse_git_dirty() {
	[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch() {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

export PS1="\[${BOLD}${MAGENTA}\]\u \[$WHITE\]at \[$ORANGE\]\h \[$WHITE\]in \[$GREEN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\n\$ \[$RESET\]"

# Setting for the new UTF-8 terminal support in Lion - fixed git perl errors - http://blog.assimov.net/blog/2011/07/25/setting-locale-failed-with-git-after-mac-lion-upgrade/
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Put Postgresapp in command line tools in path (postgresapp.com)
PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"

#NODE PATH
export NODE_PATH=/usr/local/lib/node_modules

#RBENV
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export ARCHFLAGS="-arch x86_64"
export CC=/usr/local/bin/gcc-4.2
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"

##
# Your previous /Users/pallih/.bash_profile file was backed up as /Users/pallih/.bash_profile.macports-saved_2013-02-10_at_00:45:44
##

# MacPorts Installer addition on 2013-02-10_at_00:45:44: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/share/sqlmap:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

#DATAMARKET STUFF:

# source utilites

. ~/documents/code/github/datamarket/main/elam/etc/utils.bashrc

export PATH="$HOME/documents/code/github/datamarket/main/elam/bin:$PATH"


#Tunnel everything through datamarket
alias vpn_datamarket="sshuttle --dns -r  stimpy.datamarket.com 0/0"

# Tunnel everything through AWS instance
alias vpn_aws=". start-vpn.sh"

# Tunnel everything through shell.cjb.net
alias vpn_cjb="sshuttle --dns -r  shell.cjb.net 0/0"


########################
#EC2 STUFF for pallih@gogn.in account

export EC2_HOME=~/.ec2
export PATH=$PATH:$EC2_HOME/bin
export EC2_PRIVATE_KEY="/Users/pallih/.ec2/pk-K4PAOBMKEYPLWCPQPDZS654AHTJ3NFBB.pem"
export EC2_CERT="/Users/pallih/.ec2/cert-K4PAOBMKEYPLWCPQPDZS654AHTJ3NFBB.pem"
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/

###############


#echo "Last commit on this branch: "
#git_since_last_commit


# startup virtualenv-burrito
if [ -f $HOME/.venvburrito/startup.sh ]; then
    . $HOME/.venvburrito/startup.sh
fi

# BASH TAB COMPLETION

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi

