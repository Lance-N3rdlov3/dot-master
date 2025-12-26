#!/usr/bin/env zsh

# Snippet management - Cross-platform snippet access

export SNIPPETS_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/snippets"
export NVIM_SNIPPETS_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/after/plugin"

# Create snippet directories if they don't exist
[[ ! -d "$SNIPPETS_DIR" ]] && mkdir -p "$SNIPPETS_DIR"
[[ ! -d "$NVIM_SNIPPETS_DIR" ]] && mkdir -p "$NVIM_SNIPPETS_DIR"

# List all snippets
snip_list() {
    echo "Available snippets:"
    find "$SNIPPETS_DIR" -type f \( -name "*.snippets" -o -name "*.md" \) | while read -r file; do
        echo "  $(basename "$file")"
    done
}

# View a snippet
snip_view() {
    local name="$1"
    local snip_file

    if [[ -f "$name" ]]; then
        snip_file="$name"
    else
        snip_file=$(find "$SNIPPETS_DIR" -name "*${name}*" -type f | head -1)
    fi

    if [[ -z "$snip_file" ]]; then
        echo "Snippet '$name' not found"
        return 1
    fi

    if command -v bat &>/dev/null; then
        bat "$snip_file"
    else
        cat "$snip_file"
    fi
}

# Edit a snippet
snip_edit() {
    local name="$1"
    local snip_file

    if [[ -z "$name" ]]; then
        name="untitled.snippets"
    fi

    if [[ -f "$SNIPPETS_DIR/$name" ]]; then
        snip_file="$SNIPPETS_DIR/$name"
    else
        snip_file="$SNIPPETS_DIR/$name"
        echo "# Created new snippet: $name" > "$snip_file"
    fi

    ${EDITOR:-nvim} "$snip_file"
}

# Add a new snippet
snip_add() {
    local name="$1"
    local trigger="$2"
    local description="$3"
    local content="$4"

    if [[ -z "$name" ]]; then
        echo "Usage: snip_add <name> <trigger> <description> <content>"
        return 1
    fi

    local snip_file="$SNIPPETS_DIR/$name.snippets"

    if [[ ! -f "$snip_file" ]]; then
        cat > "$snip_file" <<EOF
# Snippets for $name
# Created: $(date)
EOF
    fi

    if [[ -n "$trigger" ]]; then
        cat >> "$snip_file" <<EOF

snippet $trigger "$description"
$content
endsnippet
EOF
    fi

    echo "Snippet added to $snip_file"
}

# Fuzzy snippet selector with fzf
snip_fzf() {
    local snip_file
    snip_file=$(find "$SNIPPETS_DIR" -type f \( -name "*.snippets" -o -name "*.md" \) | fzf --preview='bat --style=plain --color=always {}')

    if [[ -n "$snip_file" ]]; then
        ${EDITOR:-nvim} "$snip_file"
    fi
}

# Aliases
alias snip='snip_fzf'
alias snipl='snip_list'
alias snipv='snip_view'
alias snipe='snip_edit'
alias snipa='snip_add'
