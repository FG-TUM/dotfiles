# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="cypher"
# If not running interactively, do not do anything
[[ $- != *i*  ]] && return
#if not ssh session or in IDE
# (JETBRAINS env variable needs to be set manually in IDE terminal settings)
if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ] && [ -z "${JETBRAINS}" ] ; then
    # If not already running tmux start tmux
    [[ -z "$TMUX"  ]] && exec tmux -u
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
    archlinux
    common-aliases
    colored-man-pages
    git
    rust
    systemd
    # zsh-navigation-tools
    fzf
    zsh-completions
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
# ~/software/miniconda3/bin
#~/.cabal/bin
/opt/intel/oneapi/vtune/latest/bin64
/opt/clang-format-static/
${HOME}/.local/bin
${HOME}/.cargo/bin
${HOME}/.local/share/gem/ruby/3.0.0/bin
${HOME}/software/scripts
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

#export INTEL_LICENSE_FILE=~/Licenses/
# Prepend MANPATH with ":" to not lose defaults
export MANPATH=":"`sed -e '/^#/'d -e '/^$/'d << EOF | paste -d ":" -s
#user added
${HOME}/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/share/man/
EOF`

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

#sshd_status=$(service ssh status)
#if [[ $sshd_status = *"is not running"* ]]; then
#  sudo service ssh --full-restart
#fi

if [[ -f ~/.zshrc.local ]]
then
  source ~/.zshrc.local
fi

if [[ -f /usr/share/nvm/init-nvm.sh ]]
then 
  source /usr/share/nvm/init-nvm.sh
fi
