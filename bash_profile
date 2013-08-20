export GIT_AUTHOR_EMAIL=pallih@kaninka.net
export GIT_AUTHOR_NAME='Páll Hilmarsson'
export GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL
export GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME


export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

#Color in terminal
export CLICOLOR=1

# various color stuff - grc - http://kassiopeia.juls.savba.sk/~garabik/software/grc/README.txt
source "`brew --prefix grc`/etc/grc.bashrc"

alias ls="ls -la"

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

alias ip="curl ifconfig.me"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"

# #DataMarket
alias datamarket="cd /Users/pallih/documents/code/github/datamarket/main/elam/src; echo Last commit on this branch:; git_since_last_commit"
alias whichdb="printenv | grep 'datamarket_DBURL'"
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

alias mount_boxer_dropbox="sshfs boxer.datamarket.com:/var/db/dropbox/Dropbox /tmp/ssh/boxer -ovolname=boxer -oBatchMode=yes -oworkaround=rename,noappledouble"

# celery import log on boxer
alias celery_log="grc ssh -t boxer.datamarket.net tail -f /var/log/celeryd/live.log"

export PATH="$HOME/documents/code/github/datamarket/main/elam/bin:$PATH"

#DM TEST DB URL is our default
export datamarket_DBURL=postgresql://devpallih@hulk.datamarket.net/dm_test
# Run against dm_test - use with dm_test
alias dm_test=". dm_test.sh"
# Run against dm_live - use with dm_live
alias dm_live=". dm_live.sh"
# Run against dm_live when a ssh tunnel is in place for postgres- use with dm_test_ssh
alias dm_test_ssh=". dm_test_ssh.sh"
# Run against dm_live when a ssh tunnel is in place for postgres- use with dm_live_ssh
alias dm_live_ssh=". dm_live_ssh.sh"

#Tunnel everything through datamarket
alias ssh_datamarket="sshuttle --dns -r  stimpy.datamarket.com 0/0"

# Tunnel everything through AWS instance

alias aws_vpn=". start-vpn.sh"

#BASE36 ENCODE AND DECODE
base36encode() { ruby -e "puts Integer('$1').to_s(36)"; }
base36decode() { python -c "print int('$1', 36)"; }

# run a import defined in importall.py

function importall() { PYTHONPATH=$PYTHONPATH:. DJANGO_SETTINGS_MODULE=datamarket.settings_local python importall.py "$@" ;}


########################
#EC2 STUFF for pallih@gogn.in account

export EC2_HOME=~/.ec2
export PATH=$PATH:$EC2_HOME/bin
export EC2_PRIVATE_KEY="/Users/pallih/.ec2/pk-K4PAOBMKEYPLWCPQPDZS654AHTJ3NFBB.pem"
export EC2_CERT="/Users/pallih/.ec2/cert-K4PAOBMKEYPLWCPQPDZS654AHTJ3NFBB.pem"
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/

###############

function git_since_last_commit {
    now=`date +%s`;
    last_commit=$(git log --pretty=format:%at -1 2> /dev/null) || return;
    seconds_since_last_commit=$((now-last_commit));
    minutes_since_last_commit=$((seconds_since_last_commit/60));
    hours_since_last_commit=$((minutes_since_last_commit/60));
    minutes_since_last_commit=$((minutes_since_last_commit%60));

    echo "${hours_since_last_commit} hours ${minutes_since_last_commit} minutes ";
}

echo "Last commit on this branch: "
git_since_last_commit


# startup virtualenv-burrito
if [ -f $HOME/.venvburrito/startup.sh ]; then
    . $HOME/.venvburrito/startup.sh
fi

# BASH TAB COMPLETION

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
