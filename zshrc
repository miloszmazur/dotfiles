export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

ENABLE_CORRECTION="true"

plugins=(
    brew copypath dirhistory kubectl python rust
    tmux jira docker fd fzf npm ripgrep ssh-agent yarn
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'
export TERM=xterm-256color
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="/opt/homebrew/bin:/opt/homebrew/opt/gnu-sed/libexec/gnubin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/include:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:/usr/local/opt/gnu-getopt/bin:$HOME/.local/bin:$PATH"
export TMUX_TMPDIR=~/.tmux_sessions

alias g="git"
alias ls="lsd"
alias ic="ibmcloud"
alias kn="kubens"
alias kx="kubectx"
alias v="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"
alias history="history -f"
alias k="kubectl"
alias freespace="diskutil info /dev/disk1s1 | rg \"Volume Free Space\""
alias iprenew="sudo ifconfig en0 down ; sudo ifconfig en0 up"
alias cr="cargo run"
alias icloud=" ~/Library/Mobile\ Documents/com~apple~CloudDocs/"
alias cat="bat"
alias readlink="greadlink"
alias rg="rg -S"

export LS_COLORS='di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

if [ type rustup &> /dev/null > /dev/null ]; then
    export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src
fi

# Setup fzf
# ---------
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
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/key-bindings.zsh" 2> /dev/null

# pyenv
# ------------
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bun completions
[ -s "/Users/milosz.mazur/.bun/_bun" ] && source "/Users/milosz.mazur/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# Bind Ctrl-F to fzf completion for the ~/code directory
fzf-codedir-completion-widget() {
  local selected_dir=$(fd . ~/code --type d | fzf --height 100% --layout reverse --prompt "code> ")
  if [[ -n $selected_dir ]]; then
    eval "cd '$selected_dir'"
    print -s "cd '$selected_dir'"
    # Clear the BUFFER
    BUFFER=""
    zle reset-prompt
  fi
}

zle -N fzf-codedir-completion-widget
bindkey '^F' fzf-codedir-completion-widget
