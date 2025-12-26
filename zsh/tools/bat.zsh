#!/usr/bin/env zsh

# Bat configuration - Modern cat replacement
if command -v bat &>/dev/null; then
    export BAT_THEME="${BAT_THEME:-Catppuccin Frappe}"
    export BAT_STYLE="${BAT_STYLE:-auto,decorations,grid}"
    export BAT_PAGER="${BAT_PAGER:-less -FR}"

    alias cat='bat --style=auto --decorations=auto --color=always'
    alias --help='--help 2>&1 | bat --language=help --style=plain --paging=never --color=always'

    if [[ -n "$MANPAGER" ]] || [[ -n "$PAGER" ]]; then
        export MANPAGER='sh -c "col -bx | bat --language=man --style=plain --paging=auto --color=always"'
    fi
fi
