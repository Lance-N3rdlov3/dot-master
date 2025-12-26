#!/usr/bin/env zsh

# .zshrc - Sourced for interactive shells
# Main interactive shell configuration

# Source all conf.d files in order
for file in "${ZDOTDIR:-$HOME/.config/zsh}/conf.d/"*.zsh; do
    [[ -r "$file" ]] && source "$file"
done

# Load fzf-marks plugin if available
[[ -f "${ZDOTDIR:-$HOME/.config/zsh}/fzf-marks.plugin.zsh" ]] && source "${ZDOTDIR:-$HOME/.config/zsh}/fzf-marks.plugin.zsh"

# Configure Powerlevel10k if using it
if [[ -f ~/.p10k.zsh ]] || [[ -f ${ZDOTDIR:-$HOME/.config/zsh}/.p10k.zsh ]]; then
    POWERLEVEL10K_TRANSIENT_PROMPT=same-dir
    P10k_THEME=${P10k_THEME:-/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme}
    [[ -r $P10k_THEME ]] && source $P10k_THEME

    if [[ -f ~/.p10k.zsh ]]; then
        source ~/.p10k.zsh
    elif [[ -f ${ZDOTDIR:-$HOME/.config/zsh}/.p10k.zsh ]]; then
        source ${ZDOTDIR:-$HOME/.config/zsh}/.p10k.zsh
    fi
fi

# Load tool-specific configurations
for tool_file in "${ZDOTDIR:-$HOME/.config/zsh}/tools/"*.zsh; do
    [[ -r "$tool_file" ]] && source "$tool_file"
done

# Load user customizations
[[ -f "${ZDOTDIR:-$HOME/.config/zsh}/user.zsh" ]] && source "${ZDOTDIR:-$HOME/.config/zsh}/user.zsh"

# Load HyDE-specific terminal config if interactive
if [[ $- == *i* ]] && [[ -f "${ZDOTDIR:-$HOME/.config/zsh}/conf.d/hyde/terminal.zsh" ]]; then
    source "${ZDOTDIR:-$HOME/.config/zsh}/conf.d/hyde/terminal.zsh"
fi
