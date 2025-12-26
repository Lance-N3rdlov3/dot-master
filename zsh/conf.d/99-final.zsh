#!/usr/bin/env zsh

# Source tool-specific configurations
for tool_file in "${ZDOTDIR:-$HOME/.config/zsh}/tools/"*.zsh; do
    [[ -r "$tool_file" ]] && source "$tool_file"
done

# Load HyDE terminal configuration (interactive only)
if [[ $- == *i* ]] && [[ -f "${ZDOTDIR:-$HOME/.config/zsh}/conf.d/hyde/terminal.zsh" ]]; then
    source "${ZDOTDIR:-$HOME/.config/zsh}/conf.d/hyde/terminal.zsh"
fi

# Load user-specific customizations
if [[ -f "${ZDOTDIR:-$HOME/.config/zsh}/user.zsh" ]]; then
    source "${ZDOTDIR:-$HOME/.config/zsh}/user.zsh"
fi

# Final status
if [[ -n "$DEBUG_ZSH" ]]; then
    echo "ZSH loaded successfully"
    echo "Platform: $PLATFORM"
    echo "Package Manager: $PACKAGE_MANAGER"
fi
