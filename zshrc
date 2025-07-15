[ -f "$HOME/.config/shell/env" ] && source "$HOME/.config/shell/env"
[ -f "$HOME/.config/shell/alias" ] && source "$HOME/.config/shell/alias"

zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors
autoload -U vcs_info

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' (%b)'
zstyle ':vcs_info:git:*' actionformats ' (%b|%a)'

precmd() {
    vcs_info
}

setopt append_history inc_append_history share_history
setopt auto_menu menu_complete
setopt autocd
setopt auto_param_slash
setopt globdots
setopt extended_glob
unsetopt prompt_sp

HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$HOME/.cache/zsh_history"
HISTCONTROL=ignoreboth

setopt PROMPT_SUBST
PROMPT='%{$fg_bold[cyan]%}%c%{$fg[red]%}${vcs_info_msg_0_}%{$reset_color%} %(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})❯%{$reset_color%} '

bindkey -e

# Bind Ctrl-F to fzf completion for the ~/code directory
fzf-codedir-completion-widget() {
  local selected_dir=$(fd . ~/code --type d | fzf --height 100% --layout reverse --prompt "code> ")
  if [[ -n $selected_dir ]]; then
    eval "cd '$selected_dir'"
    print -s "cd '$selected_dir'"
    BUFFER=""
    zle reset-prompt
  fi
}

zle -N fzf-codedir-completion-widget
bindkey '^F' fzf-codedir-completion-widget

command -v fzf >/dev/null && . <(fzf --zsh)
command -v tfctl >/dev/null && . <(tfctl completion zsh)

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
