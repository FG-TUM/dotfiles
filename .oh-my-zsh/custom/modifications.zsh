#from common-aliases
alias rm='rm -I'
# output is colorized even when piped
alias ls='ls --color=always'
alias dmesg='dmesg --color=always --human'

# removes all locally missing files
alias svnCleanup="svn status  | sed --quiet -e 's/^\! *\(.*\)/\1/p' | xargs svn rm"

# fixes for vi style
#bindkey -v "k" up-line-or-beginning-search
#bindkey -v "j" down-line-or-beginning-search
