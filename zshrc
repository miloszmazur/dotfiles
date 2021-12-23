export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

ENABLE_CORRECTION="true"

plugins=(
    brew cargo copydir dirhistory kubectl python rust
    tmux jira docker fd fzf npm ripgrep ssh-agent
    yarn
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="/usr/local/bin:/usr/local/include:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.rvm/gems/ruby-2.1.2/bin:$HOME/.rvm/gems/ruby-2.1.2@global/bin:$HOME/.rvm/rubies/ruby-2.1.2/bin:$HOME/.rvm/bin:/usr/local/texlive/2015/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:/usr/local/opt/gnu-getopt/bin:$PATH"
export TMUX_TMPDIR=~/.tmux_sessions

alias ic="ibmcloud"
alias kn="kubens"
alias kx="kubectx"
alias vim="nvim"
alias freespace="diskutil info /dev/disk1s1 | rg \"Volume Free Space\""
alias iprenew="sudo ifconfig en0 down ; sudo ifconfig en0 up"
alias cr="cargo run"
alias icloud=" ~/Library/Mobile\ Documents/com~apple~CloudDocs/"
alias cat="bat"
alias res-work="displayplacer \"id:A3A511FA-8117-37A9-D510-25AB0C8A1153 res:3840x1600 hz:30 color_depth:4 scaling:off origin:(0,0) degree:0\""
alias res-gaming="displayplacer \"id:A3A511FA-8117-37A9-D510-25AB0C8A1153 res:1920x1080 hz:60 color_depth:4 scaling:off origin:(0,0) degree:0\""

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

if [ type rustup &> /dev/null > /dev/null ]; then
    export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src
fi

# Setup fzf
# ---------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --follow --hidden --no-ignore'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND


if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"
