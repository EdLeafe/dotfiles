# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

THIS_DEVICE=CUSTOMIZE

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth
export HISTCONTROL=erasedups

# Editors
export GIT_EDITOR=vim
export SVN_EDITOR

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Customize for path to virtualenvwrapper.sh
export WORKON_HOME=$HOME/.virtualenvs                                           
source /usr/local/bin/virtualenvwrapper.sh                                      

export PATH=$PATH:$HOME/.local/bin
export PYTHONPATH=$HOME/.local/lib/python2.7/site-packages

# Set the local environment variables
source $HOME/.set_envars

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
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f /etc/bash_aliases ]; then
    . /etc/bash_aliases
fi
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
	export PS1='\h:\u:\w $(__git_ps1 "(%s) ")'
fi

#export PS1='\[\033[0;35m\]\h\[\033[0;33m\] \w\[\033[00m\]: '
export PS1='\[\033[0;32m\]\u@\h\[\033[0;36m\] \w\[\033[00m\]: '

PS1="[\u@\h \w]\$ "
PS2="> "

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

function hgrep
{
   if [ $# -lt 2 ];then
     echo 'Usage: hgrep pattern files'
     return 2
   fi

   pattern=$1
   shift
   reverse=$'\e[7m'
   sep=$'\001'
   off=$'\e[0m'

   sed -n "s${sep}${pattern}${sep}${reverse}&${off}${sep}gp" $*
}

# Opens SSH on a new screen window with the appropriate name.
screen_ssh() {
   numargs=$#
   screen -t ${!numargs} ssh $@
}
if [ $TERM == "screen" -o $TERM == "screen.linux" ]; then
   alias ssh=screen_ssh
fi


function parse_git_branch { 
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/' 
}

function exitstatus {
    EXITSTATUS="$?"
    BOLD="\[\033[1m\]"
    GREEN_BG="\[\033[42m\]"
    RED_BG="\[\033[41m\]"
    RED="\[\033[31m\]"
    ORANGE="\[\033[33m\]"
    YELLOW="\[\033[1;33m\]"
    GREEN="\[\033[32m\]"
    PURPLE="\[\033[35m\]"
    BLUE="\[\033[34m\]"
    CYAN="\[\033[36m\]"
    LIGHTCYAN="\[\033[1;36m\]"
    OFF="\[\033[00m\]"
    BASE="${BOLD}\u${OFF}@${LIGHTCYAN}${THIS_DEVICE}:${BLUE}${BOLD}\w${OFF}${YELLOW}\$(parse_git_branch)${OFF}\$ "

    if [ "$EXITSTATUS" -eq "0" ]
    then
        PS1="${GREEN}${BASE}"
    else
        PS1="${RED}${BASE}"
    fi
    if [ $VIRTUAL_ENV ]
    then
        PS1="(`basename \"$VIRTUAL_ENV\"`)$PS1"
    fi
    PS2="${BOLD}>${OFF} "
}

PROMPT_COMMAND=exitstatus
