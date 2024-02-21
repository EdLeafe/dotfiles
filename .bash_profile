# don't put duplicate lines in the history. See bash(1) for more options
HISTCONTROL=ignoredups:ignoreboth:erasedups

# Editors
export GIT_EDITOR=vim

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"

export VENV_HOME="/Users/ed/venvs"

if [ -f /etc/bash_aliases ]; then
    . /etc/bash_aliases
fi
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if [ -f ~/.git-completion.bash ]; then
      . ~/.git-completion.bash
fi

source ~/.iterm2_shell_integration.bash

function lk {
  cd "$(walk "$@")"
}

function workon { 
    if [ -z $1 ]
    then
        ls -1 $VENV_HOME
    else
        source $VENV_HOME/$1/bin/activate
    fi
}

function mkvenv {
    python3 -m venv $VENV_HOME/$1
    workon $1
    pip install -U pip setuptools wheel
    pip install ipython pytest-pudb requests
}

function rmvenv {
    command -v deactivate
    rm -rf $VENV_HOME/$1
}

_venvdirs()
{
    local cur="$2"
    COMPREPLY=( $(cd $HOME/venvs && compgen -d -- "${cur}" ) );
}
complete -F _venvdirs workon rmvenv 

_ngc_subs()
{
    COMPREPLY=("ace" "alert" "audit" "batch" "config" "dataset" "diag" "fleet-command" "org" "pym" "registry" "result" "team" "user" "version" "workspace");
}
nsub=("ace" "alert" "audit" "batch" "config" "dataset" "diag" "fleet-command" "org" "pym" "registry" "result" "team" "user" "version" "workspace")
complete -W "ace alert audit batch config dataset diag fleet-command org pym registry result team user version workspace" ngc


function parse_git_branch { 
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/' 
}

function parse_sdk_target { 
    PWD=`pwd`
    STG="<stg>"
    CANARY="<can>"
    PROD="<prod>"
    CONFIG_DIR="/Users/ed/projects/ngcsdk/my_config"
    if [[ $PWD =~ .+projects/publishing.*  || $PWD =~ .+projects/ngcsdk.* || $PWD =~ .+projects/sdk.* ]]
    then
        if [ `rg 'target_url.+api.stg' $CONFIG_DIR/pyproject.toml | wc -l` = "1" ];
        then
            echo $STG
        elif [ `rg 'target_url.+.api.canary' $CONFIG_DIR/pyproject.toml | wc -l` = "1" ];
        then
            echo $CANARY
        else
            echo $PROD
        fi
    elif [[ $PWD =~ .+projects/ngc-cli.*  || $PWD =~ .+projects/cli.* ]]
    then
        ENV_URL=$NGC_CLI_API_URL
        if [[ $ENV_URL =~ api\.stg\..+ ]]
        then
            echo $STG
        elif [[ $ENV_URL =~ api\.canary\..+ ]]
        then
            echo $CANARY
        elif [[ $ENV_URL =~ api\..+ ]]
        then
            echo $PROD
        fi
    fi
}

function exitstatus {
    EXITSTATUS="$?"
    BOLD="\[\033[1m\]"
    GREEN_BG="\[\033[42m\]"
    RED_BG="\[\033[41m\]"
    RED="\[\033[31m\]"
    ORANGE="\[\033[33m\]"
    GREEN="\[\033[32m\]"
    PURPLE="\[\033[35m\]"
    BLUE="\[\033[34m\]"
    OFF="\[\033[00m\]"
    BASE="\u${BOLD}@\h${OFF}:${BLUE}${BOLD}\w${OFF}${ORANGE}\$(parse_git_branch)${PURPLE}\$(parse_sdk_target)${OFF}\$ "

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

function shortstat {
    PS1="\u@\h \$ "
}

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

PROMPT_COMMAND=exitstatus
#PROMPT_COMMAND=shortstat
#PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export PATH="/usr/local/bin/:$PATH"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
# export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export PATH="/Users/ed/.local/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
#if command -v pyenv 1>/dev/null 2>&1; then
 eval "$(pyenv init -)"
#fi
#export PYTHONPATH=$PYTHONPATH:$HOME/projects/ngc-cli
export NGC_CLI_API_URL=api.stg.ngc.nvidia.com/
# Keep the SDK settings out of the project's pyproject.toml
export NGC_SDK_CONFIG_DIRECTORY="/Users/ed/projects/ngcsdk/my_config/"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
source /usr/local/etc/profile.d/z.sh

# nnn
export export NNN_PLUG='f:finder;o:fzopen;h:fzhist;b:oldbigfile;k:pskill;v:imgview;p:preview-tui'
export NNN_FIFO='/tmp/nnn.fifo'
. "$HOME/.cargo/env"
