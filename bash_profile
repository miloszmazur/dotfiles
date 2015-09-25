bind "set completion-ignore-case on"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
alias cd..="cd .."
source ~/.git-completion.sh
source ~/.git-prompt.sh
PS1='\u@\h \w$(__git_ps1 " (%s)")\$ '
