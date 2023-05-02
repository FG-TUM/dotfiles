# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="cypher"
# If not running interactively, do not do anything
[[ $- != *i*  ]] && return
#if not ssh session
if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]; then
    tmuxExe=${HOME}/work/software/tmux/buildDir/bin/tmux
    # If tmux exists and not already running tmux start tmux
    if [[ -x "$tmuxExe" ]]; then
        [[ -z "$TMUX" ]] && exec $tmuxExe -u new-session -c ${HOME}
    else
        echo "$tmuxExe not found or not executable!"
    fi
fi


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#
# interesting plugins:
#    archlinux 
#    docker
#    gpg-agent
#    ubuntu
#    fzf instead of zsh-navigation-tools
plugins=(
    common-aliases
    colored-man-pages
    git
    systemd
    zsh-navigation-tools
)

source $ZSH/oh-my-zsh.sh

# User configuration:

# this slows zsh down considerably
# eval $(thefuck --alias)

# source ${HOME}/work/software/cheatsheet/zsh_completion.sh
# COMPLETION SETTINGS
# add custom completion scripts
# fpath=(~/.oh-my-zsh/custom/completions $fpath)

# compsys initialization
# autoload -Uz compinit
# compinit

# show completion menu when number of options is at least 2
zstyle ':completion:*' menu select=2

export PATH=`sed -e '/^#/'d -e '/^$/'d << EOF | paste -d ":" -s
#user added
#~/.cabal/bin
#defaults
$PATH
EOF`

export JAVA_HOME=/usr/lib/jvm/default
export ANDROID_HOME=${HOME}/software/Android/Sdk
export CHROME_EXECUTABLE=/usr/bin/chromium
export GOPATH=/home/${USER}/software/gocode
export VIMRC=/home/${USER}/.vimrc

export LC_TIME="de_DE.utf8"

export LD_LIBRARY_PATH=`sed -e '/^#/'d -e '/^$/'d << EOF | paste -d ":" -s
$LD_LIBRARY_PATH
#user added
#/opt/cuda/lib64
EOF`

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='vim'
export VISUAL="$EDITOR"
# else
#   export EDITOR='mvim'
# fi

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export GPG_TTY=$(tty)
# alias gpg=gpg2

export GTEST_COLOR=1

# vi input mode
#set -o vi

if [ -x /usr/local/cuda/bin/nvcc ]
then
    export PATH=$PATH:/usr/local/cuda/bin
    export CUDADIR=/usr/local/cuda
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64
fi

# FOR ALIASES AND SIMILAR USE ~/.zshenv

# so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/work/ga68cat/software/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/work/ga68cat/software/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/work/ga68cat/software/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/work/ga68cat/software/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# init fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# init broot file browser: https://github.com/Canop/broot
source /home/ga68cat/.config/broot/launcher/bash/br

