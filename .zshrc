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
    # If not already running tmux start tmux
    # [[ -z "$TMUX"  ]] && exec tmux -u
    [[ -z "$TMUX"  ]] && exec ${HOME}/work/software/tmux/buildDir/bin/tmux -u new-session -c ${HOME}
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
plugins=(
    common-aliases
    colored-man-pages
    docker
    gpg-agent
    ubuntu
    zsh-navigation-tools
)

source $ZSH/oh-my-zsh.sh

# User configuration

# this slows zsh down considerably
# eval $(thefuck --alias)

# source ${HOME}/work/software/cheatsheet/zsh_completion.sh
# COMPLETION SETTINGS
# add custom completion scripts
fpath=(~/.oh-my-zsh/custom/completions $fpath)

# compsys initialization
autoload -U compinit
compinit

# show completion menu when number of options is at least 2
zstyle ':completion:*' menu select=2

export PATH=`sed -e '/^#/'d -e '/^$/'d << EOF | paste -d ":" -s
#user added
# $#(ls -dt /opt/intel/inspector* | head -n 1)/bin64
# $#(ls -dt /opt/intel/advisor* | head -n 1)/bin64
# $#(ls -dt /opt/intel/compilers_and_libraries* | head -n 1)/bin64
# $#(ls -dt /opt/intel/vtune_amplifier_xe_* | head -n 1)/bin64
${HOME}/work_fast/CLion-2017.3.3/bin
${HOME}/work/software/LanguageTool-4.0/bin
${HOME}/work/workspace/GROMACS/gromacs-2018/install/bin
${HOME}/work/software/ParaView-5.5.0-RC3-Qt5-MPI-Linux-64bit/bin
${HOME}/work/software/vmd-1.9.3/installDir/bin
${HOME}/work/software/CMake/build/bin
${HOME}/work/software/cheatsheet/
${HOME}/.local/bin
${HOME}/.local/share/JetBrains/Toolbox/bin
${HOME}/work/software/tmux/buildDir/bin
${HOME}/work/software/doxygen/myBuild/bin
${HOME}/work/software/oni/dist/linux-unpacked/
$PATH
EOF`

# export TERM=xterm-256color
# export TERM=xterm

export JAVA_HOME=/usr/lib/jvm/default-java
export GOPATH=${HOME}/work/software/gocode
export VIMRC=${HOME}/.vimrc

export LC_TIME="de_DE.utf8"

export LD_LIBRARY_PATH=`sed -e '/^#/'d -e '/^$/'d << EOF | paste -d ":" -s
$LD_LIBRARY_PATH
#user added
EOF`

# activate this when using mls templates
# export TEXMFHOME=`sed -e '/^#/'d -e '/^$/'d << EOF | paste -d ";" -s
# $TEXMFHOME
# ${HOME}/texmf
# /usr/share/texmf
# #user added
# /home/LATEX/texmf
# EOF`

export MANPATH="${HOME}/work/software/tmux/buildDir/share/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export GPG_TTY=$(tty)

export GTEST_COLOR=1

# vi input mode
#set -o vi


export plot="${HOME}/work/workspace/AutoPas/examples/md-flexible/plotScript.gp"

if [ -x /usr/local/cuda/bin/nvcc ]
then
    export PATH=$PATH:/usr/local/cuda/bin
    export CUDADIR=/usr/local/cuda
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64
fi

# FOR ALIASES AND SIMILAR USE ~/.zshenv

# so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

