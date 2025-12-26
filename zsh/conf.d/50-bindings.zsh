#!/usr/bin/env zsh

# Key Bindings - Emacs style
bindkey -e

# Custom key bindings
bindkey '^h' backward-char
bindkey '^l' forward-char
bindkey '^k' up-line-or-history
bindkey '^j' down-line-or-history

# History search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

if [[ -n "${terminfo[kcuu1]}" ]]; then
    bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
    bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
    bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

if [[ -n "${terminfo[kcud1]}" ]]; then
    bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
    bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
    bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# Word movement
typeset -g -A key
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start { echoti smkx }
    function zle_application_mode_stop { echoti rmkx }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

key[Control-Left]="${terminfo[kLFT5]}"
if [[ -n "${key[Control-Left]}"  ]]; then
    bindkey -M emacs "${key[Control-Left]}"  backward-word
    bindkey -M viins "${key[Control-Left]}"  backward-word
    bindkey -M vicmd "${key[Control-Left]}"  backward-word
fi

key[Control-Right]="${terminfo[kRIT5]}"
if [[ -n "${key[Control-Right]}" ]]; then
    bindkey -M emacs "${key[Control-Right]}" forward-word
    bindkey -M viins "${key[Control-Right]}" forward-word
    bindkey -M vicmd "${key[Control-Right]}" forward-word
fi

# Delete key
bindkey -M emacs '^?' backward-delete-char
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char
