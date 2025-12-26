#!/usr/bin/env zsh

# Completion Configuration
autoload -Uz compinit
autoload -U +X bashcompinit

# Fast completion with cache
setopt EXTENDED_GLOB
ZSH_COMPDUMP="${ZDOTDIR:-$HOME/.config/zsh}/.zcompdump"

if [[ -n ${ZSH_COMPDUMP}(#qN.mh+${HYDE_ZSH_COMPINIT_CHECK:-1}) ]]; then
    compinit
else
    compinit -C
fi

# Tab completion styles
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive
zstyle ':completion:*' rehash true                              # Find new executables
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zcache
zstyle ':completion:*' accept-exact '*(N)'
_comp_options+=(globdots)                                        # Complete hidden files

# Bash completion support
bashcompinit

# Add custom completions directory
if [[ -d "${ZDOTDIR:-$HOME/.config/zsh}/completions" ]]; then
    fpath=("${ZDOTDIR:-$HOME/.config/zsh}/completions" "${fpath[@]}")
fi
