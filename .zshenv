# This file is always loaded. In interactive sessions and otherwise.

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
alias less='less -i'
alias lessh='LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s" less --LONG-PROMPT --LINE-NUMBERS '
alias wdiff="wdiff -w \"$(tput bold;tput setaf 1)\" -x \"$(tput sgr0)\" -y \"$(tput bold;tput setaf 2)\" -z \"$(tput sgr0)\""
alias remark="docker run --rm -i -v \$PWD:/lint/input:ro zemanlx/remark-lint:latest"

# kill all incoming ssh connections
kickSSHIntruders() {
    if [[ $1 == '-s' ]]; then
        ps -opid -C sshd | tail -n+3
    else
        # 1. select all processes with sshd
        # 2. do not show first two rows (column name and sshd service)
        # 3. kill them all
        ps -opid -C sshd | tail -n+3 | xargs sudo kill -9
    fi
}

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
    rm -f ${direcory}/*.lof        > /dev/null 2>&1
    rm -f ${direcory}/*.log        > /dev/null 2>&1
    rm -f ${direcory}/*.lot        > /dev/null 2>&1
    rm -f ${direcory}/*.nav        > /dev/null 2>&1
    rm -f ${direcory}/*.out        > /dev/null 2>&1
    rm -f ${direcory}/*.pdfpc      > /dev/null 2>&1
    rm -f ${direcory}/*.ps         > /dev/null 2>&1
    rm -f ${direcory}/*.run.xml    > /dev/null 2>&1
    rm -f ${direcory}/*.snm        > /dev/null 2>&1
    rm -f ${direcory}/*.synctex.gz > /dev/null 2>&1
    rm -f ${direcory}/*.toc        > /dev/null 2>&1
    rm -f ${direcory}/*.tex~       > /dev/null 2>&1
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
