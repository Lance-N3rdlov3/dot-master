#!/usr/bin/env zsh

# .zshenv - Sourced for all shells (login, interactive, non-interactive)
# Environment variables, PATH, and platform detection

# Source modular environment configurations
for file in "${ZDOTDIR:-$HOME/.config/zsh}/conf.d/"{10-environment,15-xdg,20-paths}.zsh; do
    [[ -r "$file" ]] && source "$file"
done
