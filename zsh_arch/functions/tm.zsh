# Enhanced terminal man page finder with fuzzy search
tm() {
    local query="$1"
    local preview_cmd="echo {} | awk '{print \$1}' | xargs man 2>/dev/null | head -50 || echo 'No preview available'"

    # Colors
    local blue='\e[1;34m' green='\e[1;32m' yellow='\e[1;33m' red='\e[1;31m' reset='\e[0m'

    # Check if fzf is available
    if ! command -v fzf &>/dev/null; then
        printf "${red}Error:${reset} fzf is required for tm function\n" >&2
        printf "${yellow}Install:${reset} pacman -S fzf  (or your package manager equivalent)\n" >&2
        return 1
    fi

    # Show usage if requested
    if [[ "$query" == "--help" || "$query" == "-h" ]]; then
        cat <<EOF
${blue}tm${reset} - Terminal man page fuzzy finder

${green}Usage:${reset}
  tm [query]        # Search man pages with optional query
  tm --help         # Show this help
  tm --list         # List all available man pages
  tm --update       # Update man page database

${green}Examples:${reset}
  tm                # Browse all man pages
  tm grep           # Search for grep-related pages
  tm --list | grep ls  # List man pages containing 'ls'

${green}Requirements:${reset}
  fzf - Fuzzy finder (pacman -S fzf)
EOF
        return 0
    fi

    # Handle special commands
    case "$query" in
        --list)
            man -k . | sort
            return 0
            ;;
        --update)
            printf "${blue}Updating man page database...${reset}\n"
            if command -v mandb &>/dev/null; then
                sudo mandb
            else
                printf "${yellow}mandb not found, trying alternative...${reset}\n"
                # Try to find man page cache update command
                printf "${red}Manual update required${reset}\n" >&2
            fi
            return 0
            ;;
    esac

    # Get man page list
    local man_pages
    if [[ -n "$query" ]]; then
        # Search for specific query
        man_pages=$(man -k "$query" 2>/dev/null | sort)
        if [[ -z "$man_pages" ]]; then
            printf "${yellow}No man pages found for:${reset} %s\n" "$query" >&2
            printf "${green}Try:${reset} tm (to browse all pages)\n" >&2
            return 1
        fi
    else
        # Get all man pages
        man_pages=$(man -k . 2>/dev/null | sort)
    fi

    # Use fzf to select man page
    local selection
    selection=$(echo "$man_pages" | fzf \
        --prompt="Man Pages> " \
        --preview="$preview_cmd" \
        --preview-window="right:60%:wrap" \
        --bind="ctrl-r:reload(man -k . | sort)" \
        --bind="ctrl-f:reload(man -k {} | sort)" \
        --header="Ctrl-R: reload all, Ctrl-F: search current")

    # Check if user made a selection
    if [[ -z "$selection" ]]; then
        return 0
    fi

    # Extract man page name and open it
    local man_name=$(echo "$selection" | awk '{print $1}')
    local man_section=$(echo "$selection" | awk '{print $2}' | tr -d '()')

    if [[ -n "$man_name" ]]; then
        printf "${green}Opening:${reset} %s" "$man_name"
        [[ -n "$man_section" ]] && printf "(${man_section})"
        printf "\n"
        man "$man_name" 2>/dev/null || {
            printf "${red}Error:${reset} Could not open man page for '%s'\n" "$man_name" >&2
            return 1
        }
    fi
}

# Additional man page utilities
function man-search() {
    # Search for man pages containing a keyword
    local keyword="$1"
    if [[ -z "$keyword" ]]; then
        echo "Usage: man-search <keyword>"
        return 1
    fi
    man -k "$keyword" | sort
}

function man-recent() {
    # Show recently viewed man pages (if available)
    if [[ -f ~/.man_history ]]; then
        tail -10 ~/.man_history 2>/dev/null || echo "No recent man page history found"
    else
        echo "Man page history not available"
        echo "Consider installing a man page viewer that tracks history"
    fi
}