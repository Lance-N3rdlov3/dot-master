#!/usr/bin/env zsh

# Fabric pattern integration with opencode
if command -v opencode &>/dev/null; then
    export FABRIC_PATTERNS="${XDG_DATA_HOME:-$HOME/.local/share}/fabric/patterns"

    fabric() {
        local pattern="$1"
        shift

        if [[ -z "$pattern" ]]; then
            echo "Usage: fabric <pattern> [options]"
            echo ""
            echo "Available patterns:"
            if [[ -d "$FABRIC_PATTERNS" ]]; then
                ls "$FABRIC_PATTERNS" | sed 's/^/  /'
            fi
            return 1
        fi

        local pattern_file="$FABRIC_PATTERNS/$pattern/system.md"

        if [[ ! -f "$pattern_file" ]]; then
            echo "Pattern '$pattern' not found in $FABRIC_PATTERNS"
            return 1
        fi

        # Use opencode with fabric pattern
        opencode "$pattern" "$@"
    }
fi
