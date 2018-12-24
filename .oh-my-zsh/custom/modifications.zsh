#from common-aliases
alias rm='rm -I'
# output is colorized even when piped
alias ls='ls --color=always'
alias dmesg='dmesg --color=always --human'

# lists all hidden files
unalias ldot
ldot()
{
    # locally enables supressing glob fail output
    setopt local_options no_nomatch

    searchPath=${1}
    [[ "${searchPath}" != "" && "${searchPath}" != */ ]] && searchPath=${searchPath}/
    ls -ld ${searchPath}.* 2>/dev/null
}
alias lsdot=ldot

# fixes for vi style
#bindkey -v "k" up-line-or-beginning-search
#bindkey -v "j" down-line-or-beginning-search
