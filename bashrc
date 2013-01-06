# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -atlF'
alias la='ls -A'
alias l='ls -CF'
alias c='clear'
alias v='vim'
alias r='rails'

# Edit bashrc
alias bashrc='vim ~/.bashrc'

# Edit vhosts
alias httpd='sudo vim /etc/apache2/httpd.conf'

# Edit vimrc
alias vimrc='vim ~/.vimrc'

# Edit php.ini file
alias phpini='sudo vim /etc/php5/apache2/php.ini'

# Log in to mysql console
alias my='mysql -u root -p'

# Edit hosts file
alias hosts='sudo vim /etc/hosts'

# Restart apache
alias res='sudo service apache2 restart'

# Run dbeaver (db manager)
alias dbeaver='/usr/share/dbeaver/dbeaver'

# Go to src
alias src='cd ~/src/'

# Generate ctags
alias makectags='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .'

# Open CMakeLists.txt in vim
alias ce='vim CMakeLists.txt'

# Number of commits in git repo
alias count="git log --pretty=oneline | grep -c ''"

# Show all groups
alias sgroups="cat /etc/group | cut -d: -f1"

# Show all users
alias susers="cat /etc/passwd | cut -d: -f1"

# Git typo
alias gi="git"
alias it="git"
alias gti="git"

# RVM init
alias uservm='[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Colorful svn client
function svn
{
	# rebuild args to get quotes right
	CMD=
	for i in "$@"
	do
		if [[ "$i" =~ \  ]]
		then
			CMD="$CMD \"$i\""
		else
			CMD="$CMD $i"
		fi
	done

	# pad with spaces to strip --nocol
	CMD=" $CMD "
	CMDLEN=${#CMD}

	# parse disabling arg
	CMD="${CMD/ --nocol / }"

	# check if disabled
	test "$CMDLEN" = "${#CMD}"
	NOCOL=$?
	if [ "$SVN_COLOR" != "always" ] && ( [ $NOCOL = 1 ] || [ "$SVN_COLOR" = "never" ] || [ ! -t 1 ] )
	then
		eval $(which svn) $CMD
		return
	fi

	# supported svn actions for "status-like" output
	ACTIONS="add|checkout|co|cp|del|export|remove|rm|st"
	ACTIONS="$ACTIONS|merge|mkdir|move|mv|ren|sw|up"

	# actions that outputs "status-like" data
	if [[ "$1" =~ ^($ACTIONS) ]]
	then
		eval $(which svn) $CMD | while IFS= read -r RL
		do
			if   [[ $RL =~ ^\ ?M ]]; then C="\033[34m";
			elif [[ $RL =~ ^\ ?C ]]; then C="\033[41m\033[37m\033[1m";
			elif [[ $RL =~ ^A ]]; then C="\033[32m\033[1m";
			elif [[ $RL =~ ^D ]]; then C="\033[31m\033[1m";
			elif [[ $RL =~ ^X ]]; then C="\033[37m";
			elif [[ $RL =~ ^! ]]; then C="\033[43m\033[37m\033[1m";
			elif [[ $RL =~ ^I ]]; then C="\033[33m";
			elif [[ $RL =~ ^R ]]; then C="\033[35m";
			else C=
			fi

			echo -e "$C${RL/\\/\\\\}\033[0m\033[0;0m"
		done

	# actions that outputs "diff-like" data
	elif [[ "$1" =~ ^diff ]]
	then
		eval $(which svn) $CMD | while IFS= read -r RL
		do
			if   [[ $RL =~ ^Index:\  ]]; then C="\033[34m\033[1m";
			elif [[ $RL =~ ^@@ ]]; then C="\033[37m";

			# removed
			elif [[ $RL =~ ^-\<\<\< ]]; then C="\033[31m\033[1m";
			elif [[ $RL =~ ^-\>\>\> ]]; then C="\033[31m\033[1m";
			elif [[ $RL =~ ^-=== ]]; then C="\033[31m\033[1m";
			elif [[ $RL =~ ^- ]]; then C="\033[31m";

			# added
			elif [[ $RL =~ ^\+\<\<\< ]]; then C="\033[32m\033[1m";
			elif [[ $RL =~ ^\+\>\>\> ]]; then C="\033[32m\033[1m";
			elif [[ $RL =~ ^\+=== ]]; then C="\033[32m\033[1m";
			elif [[ $RL =~ ^\+ ]]; then C="\033[32m";

			else C=
			fi

			echo -e "$C${RL/\\/\\\\}\033[0m\033[0;0m"
		done
	else
		eval $(which svn) $CMD
	fi
}
