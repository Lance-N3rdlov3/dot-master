#!/usr/bin/env zsh

# FZF configuration - Command-line fuzzy finder
if command -v fzf &>/dev/null; then
    # FZF default options
    export FZF_DEFAULT_OPTS="--color=bg+:#414559,bg:#303446,spinner:#F2D5CF,hl:#E78284 --color=fg:#C6D0F5,header:#E78284,info:#CA9EE6,pointer:#F2D5CF --color=marker:#BABBF1,fg+:#C6D0F5,prompt:#CA9EE6,hl+:#E78284 --color=selected-bg:#51576D --color=border:#737994 --height=40% --layout=reverse --cycle"

    # Load FZF key-bindings and completions
    [[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
    [[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh
    [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
    [[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]] && source /opt/homebrew/opt/fzf/shell/completion.zsh

    # Source fzf.zsh if available (newer fzf versions)
    [[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

    # FZF functions
    _fuzzy_change_directory() {
        local initial_query="$1"
        local selected_dir
        local fzf_options=('--preview=ls -p {}' '--preview-window=right:60%')
        fzf_options+=(--height "80%" --layout=reverse --cycle)
        local max_depth=7

        if [[ -n "$initial_query" ]]; then
            fzf_options+=("--query=$initial_query")
        fi

        selected_dir=$(find . -maxdepth $max_depth \( -name .git -o -name node_modules -o -name .venv -o -name target -o -name .cache \) -prune -o -type d -print 2>/dev/null | fzf "${fzf_options[@]}")

        if [[ -n "$selected_dir" && -d "$selected_dir" ]]; then
            cd "$selected_dir"
        fi
    }

    _fuzzy_edit_search_file_content() {
        local selected_file
        local fzf_options=()
        local preview_cmd
        if command -v "bat" &>/dev/null; then
            preview_cmd=('bat --color always --style=full --paging=never {}')
        else
            preview_cmd=('cat {}')
        fi
        fzf_options+=(--height "80%" --layout=reverse --cycle --preview-window right:60% --preview ${preview_cmd[@]})
        selected_file=$(grep -irl "${1:-}" ./ | fzf "${fzf_options[@]}")

        if [[ -n "$selected_file" ]]; then
            if [[ -n "$EDITOR" ]]; then
                "$EDITOR" "$selected_file"
            else
                vim "$selected_file"
            fi
        fi
    }

    _fuzzy_edit_search_file() {
        local initial_query="$1"
        local selected_file
        local fzf_options=()
        fzf_options+=(--height "80%" --layout=reverse --preview-window right:60% --cycle)
        local max_depth=5

        if [[ -n "$initial_query" ]]; then
            fzf_options+=("--query=$initial_query")
        fi

        selected_file=$(find . -maxdepth $max_depth -type f 2>/dev/null | fzf "${fzf_options[@]}")

        if [[ -n "$selected_file" && -f "$selected_file" ]]; then
            if [[ -n "$EDITOR" ]]; then
                "$EDITOR" "$selected_file"
            else
                vim "$selected_file"
            fi
        fi
    }

    # FZF aliases
    alias ffcd='_fuzzy_change_directory'
    alias ffec='_fuzzy_edit_search_file_content'
    alias ffe='_fuzzy_edit_search_file'
fi
