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
    git
    gpg-agent
    gradle
    mvn
    systemd
    ubuntu
    zsh-navigation-tools
)

source $ZSH/oh-my-zsh.sh

# User configuration

eval $(thefuck --alias)

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
${HOME}/work/software/cmake-3.15.1/install/bin
${HOME}/work/software/cheatsheet/
${HOME}/.local/bin
${HOME}/.local/share/JetBrains/Toolbox/bin
${HOME}/work/software/tmux/buildDir/bin
${HOME}/work/software/doxygen/myBuild/bin
$PATH
EOF`

export JAVA_HOME=/usr/lib/jvm/default-java
export GOPATH=${HOME}/work/software/gocode
export VIMRC=${HOME}/.vimrc

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
#   export EDITOR='vim'
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


#alias nvidia-Visual-Profiler="nvvp"
#alias nvidia-nsight-eclipse="nsight"
alias volume="amixer set 'Master'"
alias jobs="jobs -l"
# alias vivaldi="vivaldi-stable"
# alias paraview="optirun paraview"
alias echo_PATH="echo $PATH | sed \"s/:/\n/g\""
alias echo_LD_LIBRARY_PATH="echo $LD_LIBRARY_PATH | sed \"s/:/\n/g\""
alias invert_colors="xcalib -alter -invert"
alias ocaml="rlwrap ocaml"
alias lessh='LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s" less --LONG-PROMPT --LINE-NUMBERS '
alias yed="java -jar ${HOME}/work/software/yed/yed-3.18.1/yed.jar"
alias wdiff="wdiff -w \"$(tput bold;tput setaf 1)\" -x \"$(tput sgr0)\" -y \"$(tput bold;tput setaf 2)\" -z \"$(tput sgr0)\""
alias remark="docker run --rm -i -v \$PWD:/lint/input:ro zemanlx/remark-lint:latest"

# load icc and parallel studio stuff
loadIntelStuff() {
    source /home/software/intel_2019_u4/bin/compilervars.sh intel64
    echo "To use the right libraries call icpc with -gcc-name=gcc-7"
}

# necessary thanks to JetBrains-toolbox
clion() {
    $(find ${HOME}/.local/share/JetBrains/Toolbox/apps/CLion -name 'clion.sh' | head -n 1) $@
}

intellij() {
    $(find ${HOME}/.local/share/JetBrains/Toolbox/apps/IDEA-U -name 'idea.sh' | head -n 1) $@
}

export ws=~/work/workspace/

# insert sudo when searching from root
find()
{
    if [[ $1 == '/' ]]; then
        command sudo find $@
    else
        command find $@
    fi
}

calc()
{
    printf "%.${2:-3}f\n" $(bc -l <<< ${1})
}

wttr()
{
    # curl -H "Accept-Language: ${LANG%_*}" wttr.in/"${1:-Munich}"
    curl -H "Accept-Language: ${LANG%_*}" wttr.in/"${1:-Garching}"
}

shrinkImage()
{
    if [[ $# < 1 ]]; then
        echo "Usage: " $0 " PATH_TO_IMAGE"
    else
        inkscape -D -A $1 $1
    fi
}

grepPDF()
{
    find ${2:-\.} -name '*.pdf' -exec sh -c "pdftotext '{}' - | grep --with-filename --label='{}' --color --ignore-case '${1}'" \;

}

oneDtoThreeD(){
    if [[ $# < 4 ]]; then
        echo "Usage: " $0 " dimX dimY dimZ index"
    else
        dimX=$1
        dimY=$2
        dimZ=$3
        index=$4

        indexX=$(bc <<< "${index} % ${dimX}")
        indexY=$(bc <<< "(${index} / ${dimX}) % ${dimY}")
        indexZ=$(bc <<< "(${index} / (${dimX} * ${dimY})) % ${dimZ}")
        echo "3D index: " $indexX $indexY $indexZ
    fi

}

cleanTeX()
{
    setopt +o nomatch
    direcory=${1:-\.}
    direcory=${direcory%/}

    rm -f ${direcory}/*.aux        > /dev/null 2>&1
    rm -f ${direcory}/*.bbl        > /dev/null 2>&1
    rm -f ${direcory}/*.bcf        > /dev/null 2>&1
    rm -f ${direcory}/*.blg        > /dev/null 2>&1
    rm -f ${direcory}/*.dvi        > /dev/null 2>&1
    rm -f ${direcory}/*.ent        > /dev/null 2>&1
    rm -f ${direcory}/*.log        > /dev/null 2>&1
    rm -f ${direcory}/*.lof        > /dev/null 2>&1
    rm -f ${direcory}/*.lot        > /dev/null 2>&1
    rm -f ${direcory}/*.nav        > /dev/null 2>&1
    rm -f ${direcory}/*.out        > /dev/null 2>&1
    rm -f ${direcory}/*.pdfpc      > /dev/null 2>&1
    rm -f ${direcory}/*.ps         > /dev/null 2>&1
    rm -f ${direcory}/*.run.xml    > /dev/null 2>&1
    rm -f ${direcory}/*.snm        > /dev/null 2>&1
    rm -f ${direcory}/*.synctex.gz > /dev/null 2>&1
    rm -f ${direcory}/*.toc        > /dev/null 2>&1
    rm -f ${direcory}/*.vrb        > /dev/null 2>&1
}

encrypt()
{
    if [[ $# < 1 ]]; then
        echo "Usage: " $0 " file/folder"
    else
        payload=$1

        tar --create --gzip --file ${payload}.tgz ${payload}     &&\
        rm ${payload} -r                                         &&\
        gpg --encrypt --recipient f.gratl@tum.de ${payload}.tgz  &&\
        rm ${payload}.tgz
    fi
}

decrypt()
{
    if [[ $# < 1 ]]; then
        echo "Usage: " $0 " file/folder"
    else
        payload=$1
        # check for correct suffix
        if [ ${payload: -4} != '.gpg' ];
        then
            echo "File is not a .gpg file (bad suffix)."
            return
        fi

        # delete suffix from decrypted file
        gpg --decrypt ${payload} > ${payload%%.gpg} &&\
        rm ${payload}                               &&\
        dtrx ${payload%%.gpg}                       &&\
        rm ${payload%%.gpg}
    fi
}


# so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon
