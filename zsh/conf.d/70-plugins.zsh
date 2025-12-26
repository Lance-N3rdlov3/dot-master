#!/usr/bin/env zsh

# Plugin loading configuration
# HyDE plugin system - deferred loading for faster startup

HYDE_ZSH_DEFER="${HYDE_ZSH_DEFER:-1}"
HYDE_ZSH_PROMPT="${HYDE_ZSH_PROMPT:-1}"
HYDE_ZSH_NO_PLUGINS="${HYDE_ZSH_NO_PLUGINS:-0}"

# Deduplicate zsh plugins
function _dedup_zsh_plugins {
    unset -f _dedup_zsh_plugins
    zsh_paths=(
        "/usr/share/oh-my-zsh"
        "/usr/local/share/oh-my-zsh"
        "$HOME/.oh-my-zsh"
    )
    for zsh_path in "${zsh_paths[@]}"; do
        [[ -d $zsh_path ]] && export ZSH=$zsh_path && break
    done

    hyde_plugins=(git zsh-256color zsh-autosuggestions zsh-syntax-highlighting)
    plugins+=("${plugins[@]}" "${hyde_plugins[@]}")
    plugins=($(printf "%s\n" "${plugins[@]}" | sort -u))

    typeset -g DEFER_OMZ_LOAD=1
}

# Load prompt
function _load_prompt {
    if [[ -f "${ZDOTDIR:-$HOME/.config/zsh}/prompt.zsh" ]]; then
        source "${ZDOTDIR:-$HOME/.config/zsh}/prompt.zsh"
    elif [[ -f "${ZDOTDIR:-$HOME/.config/zsh}/conf.d/hyde/prompt.zsh" ]]; then
        source "${ZDOTDIR:-$HOME/.config/zsh}/conf.d/hyde/prompt.zsh"
    fi
}

# Defer oh-my-zsh loading
function _defer_omz_after_prompt_before_input() {
    [[ -r $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh

    # Load custom completions and functions
    fpath=(${ZDOTDIR:-$HOME/.config/zsh}/completions "${fpath[@]}")

    for file in "${ZDOTDIR:-$HOME/.config/zsh}/functions/"*.zsh; do
        [ -r "$file" ] && source "$file"
    done

    for file in "${ZDOTDIR:-$HOME/.config/zsh}/completions/"*.zsh; do
        [ -r "$file" ] && source "$file"
    done

    _load_prompt

    chmod +r ${ZDOTDIR:-$HOME/.config/zsh}/.zshrc
}

# Main plugin loading function
function _load_plugins {
    if [[ ${HYDE_ZSH_NO_PLUGINS} == "1" ]]; then
        return
    fi

    _dedup_zsh_plugins

    if [[ "$HYDE_ZSH_DEFER" == "1" ]] && [[ -r $ZSH/oh-my-zsh.sh ]]; then
        [[ ${VSCODE_INJECTION} == 1 ]] || chmod -r ${ZDOTDIR:-$HOME/.config/zsh}/.zshrc
        zle -N zle-line-init _defer_omz_after_prompt_before_input
    elif [[ -r $ZSH/oh-my-zsh.sh ]]; then
        source $ZSH/oh-my-zsh.sh
        _load_prompt
    fi
}

# Source plugin.zsh if it exists for custom plugin loading
if [[ -f "${ZDOTDIR:-$HOME/.config/zsh}/plugin.zsh" ]]; then
    source "${ZDOTDIR:-$HOME/.config/zsh}/plugin.zsh"
else
    _load_plugins
fi
