#!/usr/bin/env zsh

# Platform-specific aliases
if [[ -f "${ZDOTDIR:-$HOME/.config/zsh}/platform/$PLATFORM.zsh" ]]; then
    source "${ZDOTDIR:-$HOME/.config/zsh}/platform/$PLATFORM.zsh"
fi

# Common aliases - Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias mkdir='mkdir -p'

# Common aliases - Utilities
alias c='clear'
alias reload='source ${ZDOTDIR:-$HOME/.config/zsh}/.zshrc'
alias grep='rg --color=auto'
alias fgrep='rg -F --color=auto'
alias egrep='rg -E --color=auto'

# Editor aliases
alias vi='nvim'
alias vim='nvim'
alias v='nvim'
alias nano='nvim'
alias micro='nvim'

# Config aliases
alias zconf='nvim ${ZDOTDIR:-$HOME/.config/zsh}/.zshrc'
alias kconf='nvim ${XDG_CONFIG_HOME:-$HOME/.config}/kitty/kitty.conf'

# HyDE Package Manager aliases
if command -v hyde-shell &>/dev/null; then
    alias in='hyde-shell pm install'
    alias up='hyde-shell pm upgrade'
    alias pl='hyde-shell pm search installed'
    alias pa='hyde-shell pm search all'
fi

# Development aliases
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Docker aliases
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dpsa='docker ps -a'

# Kubernetes aliases
alias k='kubectl'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kx='kubectl config use-context'
alias kn='kubectl config set-context --current --namespace'
