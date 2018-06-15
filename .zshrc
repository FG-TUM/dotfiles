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
plugins=(archlinux archlinux-patch cabal cargo common-aliases colored-man-pages git mvn nyan rust svn systemd zsh-navigation-tools)

source $ZSH/oh-my-zsh.sh

# User configuration

eval $(thefuck --alias)

export PATH=`sed -e '/^#/'d -e '/^$/'d << EOF | paste -d ":" -s
$PATH
#user added
~/software/paraview/install/bin/
~/software/gocode/bin
~/software/dock
~/.cabal/bin
~/workspace/android-sdks/tools
$(\ls -dt /opt/intel/inspector* | head -n 1)/bin64
EOF`
#$(\ls -dt /opt/intel/advisor* | head -n 1)/bin64
#$(\ls -dt /opt/intel/compilers_and_libraries* | head -n 1)/linux/bin/intel64
#$(\ls -dt /opt/intel/vtune_amplifier_xe_* | head -n 1)/bin64

export JAVA_HOME=/usr/lib/jvm/default
export GOPATH=/home/${USER}/software/gocode
export VIMRC=/home/${USER}/.vimrc

export LD_LIBRARY_PATH=`sed -e '/^#/'d -e '/^$/'d << EOF | paste -d ":" -s
$LD_LIBRARY_PATH
#user added
#/opt/cuda/lib64
EOF`

#export INTEL_LICENSE_FILE=~/Licenses/
# export MANPATH="/usr/local/man:$MANPATH"

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

# vi input mode
#set -o vi


#alias nvidia-Visual-Profiler="nvvp"
#alias nvidia-nsight-eclipse="nsight"
alias volume="amixer set 'Master'"
alias jobs="jobs -l"
# alias vivaldi="vivaldi-stable"
alias paraview="optirun paraview"
alias echo_PATH="echo $PATH | sed \"s/:/\n/g\""
alias echo_LD_LIBRARY_PATH="echo $LD_LIBRARY_PATH | sed \"s/:/\n/g\""
alias invert_colors="xcalib -alter -invert"
alias ocaml="rlwrap ocaml"
alias lessh='LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s" less --LONG-PROMPT --LINE-NUMBERS '
# necessary thanks to JetBrains-toolbox
clion() {
    $(find /opt/JetBrains/apps/CLion -name 'clion.sh' | head -n 1) $@
}

intellij() {
    $(find /opt/JetBrains/apps/IDEA-U -name 'idea.sh' | head -n 1) $@
}


# ONLY NECESSARY WITH OLD VERSIONS OF TEXSTUDIO / LANGUAGETOOL
# starts languagetool server if available and texstudio and terminates all processes on return
# texstudio()
# {
    # if [[ $(where languagetool-startServer.sh) == "languagetool-startServer.sh not found" ]]; then
        # echo "WARNING: languagetool not found"
        # command texstudio $@
    # else
        # languagetool --http > /dev/null &
        # #languagetool-startServer.sh > /dev/null &
        # command texstudio $@
        # PID_languagetool=$(ps -o pid,args | grep languagetool | head -n -1 | sed -e 's/^ *\([0-9]\+\).*/\1/')
        # echo ${PID_languagetool//$'\n'/ } | xargs kill
    # fi
# }

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

cleanTeX()
{
    setopt +o nomatch
    direcory=${1:-\.}
    direcory=${direcory%/}

    rm -f ${direcory}/*.aux        > /dev/null 2>&1
    rm -f ${direcory}/*.dvi        > /dev/null 2>&1
    rm -f ${direcory}/*.log        > /dev/null 2>&1
    rm -f ${direcory}/*.nav        > /dev/null 2>&1
    rm -f ${direcory}/*.out        > /dev/null 2>&1
    rm -f ${direcory}/*.pdfpc      > /dev/null 2>&1
    rm -f ${direcory}/*.ps         > /dev/null 2>&1
    rm -f ${direcory}/*.snm        > /dev/null 2>&1
    rm -f ${direcory}/*.synctex.gz > /dev/null 2>&1
    rm -f ${direcory}/*.toc        > /dev/null 2>&1
    rm -f ${direcory}/*.vrb        > /dev/null 2>&1
}
# so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon
