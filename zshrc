export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

 ENABLE_CORRECTION="true"

plugins=(
    brew
    git
    git-extras
    python
    tmux
)

source $ZSH/oh-my-zsh.sh

export PATH="/usr/local/bin:/usr/local/include:/usr/bin:/bin:/usr/sbin:/sbin:/Users/tyr/.rvm/gems/ruby-2.1.2/bin:/Users/tyr/.rvm/gems/ruby-2.1.2@global/bin:/Users/tyr/.rvm/rubies/ruby-2.1.2/bin:/Users/tyr/.rvm/bin:/usr/local/texlive/2015/bin:$PATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR='vim'

alias vim="mvim -v"
alias freespace="diskutil info /dev/disk1s1 | rg \"Volume Free Space\""
alias iprenew="sudo ifconfig en0 down ; sudo ifconfig en0 up"
alias cr="cargo run"
alias icloud=" ~/Library/Mobile\ Documents/com~apple~CloudDocs/"
alias cat="bat"
alias res-work="displayplacer \"id:A3A511FA-8117-37A9-D510-25AB0C8A1153 res:3840x1600 hz:30 color_depth:4 scaling:off origin:(0,0) degree:0\""
alias res-gaming="displayplacer \"id:A3A511FA-8117-37A9-D510-25AB0C8A1153 res:1920x1080 hz:60 color_depth:4 scaling:off origin:(0,0) degree:0\""

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"

if [ type rustup &> /dev/null > /dev/null ]; then
    export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src
fi

# Setup fzf
# ---------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"
