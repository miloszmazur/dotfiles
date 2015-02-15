bind "set completion-ignore-case on"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
alias cd..="cd .."
source ~/.git-completion.sh
source ~/.git-prompt.sh
PS1='\u@\h \w$(__git_ps1 " (%s)")\$ '


export PATH=/Users/tyr/bin/Sencha/Cmd/5.1.0.26:$PATH

export SENCHA_CMD_3_0_0="/Users/tyr/bin/Sencha/Cmd/5.1.0.26"
