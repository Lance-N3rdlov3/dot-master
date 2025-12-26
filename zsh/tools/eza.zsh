#!/usr/bin/env zsh

# Eza configuration - Modern ls replacement
if command -v eza &>/dev/null; then
    export EZA_CONFIG_DIR="${EZA_CONFIG_DIR:-$XDG_CONFIG_HOME/eza}"

    alias l='eza -lh --icons=auto'
    alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
    alias la='eza -aG --icons=auto'
    alias ld='eza -lhD --icons=auto'
    alias lt='eza --icons=auto --tree'
    alias l.='eza -ald --icons=auto .*'
    alias ls='eza -aG --color=always --group-directories-first --icons --sort type'
fi
