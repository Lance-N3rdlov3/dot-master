#!/usr/bin/env zsh

# .zprofile - Sourced for login shells
# Commands that should run only once when logging in

# macOS Homebrew initialization (only on login)
if [[ "$OSTYPE" == "darwin"* ]] && command -v brew &>/dev/null; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# User-local bin paths
export PATH="$PATH:/Users/nrd/.local/bin"

# OrbStack integration (macOS virtualization)
[[ -f ~/.orbstack/shell/init.zsh ]] && source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Load platform-specific login configs
if [[ -f "${ZDOTDIR:-$HOME/.config/zsh}/platform/${PLATFORM:-linux}.zsh" ]]; then
    source "${ZDOTDIR:-$HOME/.config/zsh}/platform/${PLATFORM:-linux}.zsh"
fi
