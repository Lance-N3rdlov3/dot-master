#!/usr/bin/env zsh

# Load all custom functions from functions directory
for file in "${ZDOTDIR:-$HOME/.config/zsh}/functions/"*.zsh; do
    [[ -r "$file" ]] && source "$file"
done

# Load fzf-marks if available
if [[ -f "${ZDOTDIR:-$HOME/.config/zsh}/fzf-marks.plugin.zsh" ]]; then
    source "${ZDOTDIR:-$HOME/.config/zsh}/fzf-marks.plugin.zsh"
fi

# Common utility functions

# Extract archives - unified function
extract() {
    if [ -z "$1" ]; then
        echo "Usage: extract <archive_file>"
        return 1
    fi

    if [ ! -f "$1" ]; then
        echo "Error: File '$1' not found."
        return 1
    fi

    case "$1" in
        *.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
        *.tar.gz|*.tgz) tar xvzf "$1" ;;
        *.tar.xz|*.txz) tar xvJf "$1" ;;
        *.tar.zst) tar --zstd -xvf "$1" ;;
        *.tar.lz4) tar --lz4 -xvf "$1" ;;
        *.tar) tar xvf "$1" ;;
        *.bz2) bunzip2 "$1" ;;
        *.gz) gunzip "$1" ;;
        *.xz) unxz "$1" ;;
        *.zst) zstd -d "$1" ;;
        *.lz4) lz4 -d "$1" ;;
        *.zip) unzip "$1" ;;
        *.rar) unrar x "$1" ;;
        *.7z) 7z x "$1" ;;
        *.Z) uncompress "$1" ;;
        *.deb) ar x "$1" ;;
        *.rpm) rpm2cpio "$1" | cpio -idmv ;;
        *)
            echo "'$1' cannot be extracted with extract()"
            return 1
            ;;
    esac
}

# Man page with fzf
tm() {
    local man_page
    man_page=$(man -k . | sort | fzf --prompt='Man Pages> ' --preview='echo {} | awk "{print \$1}" | xargs man' --preview-window=right:60%:wrap)
    man "$(echo "$man_page" | awk '{print $1}')"
}

# Enhanced help with bat
help() {
    if command -v bat >/dev/null 2>&1; then
        "$@" --help 2>&1 | bat --style=auto --paging=auto --color=always
    else
        "$@" --help | cat
    fi
}

# Yazi file manager with cd on exit
y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# Developer helper functions

# Create new project scaffold
new_project() {
    local name="${1:-project}"
    local type="${2:-default}"

    mkdir -p "$name" && cd "$name"

    case "$type" in
        node|npm)
            npm init -y
            echo "node_modules/" >> .gitignore
            ;;
        python)
            python -m venv .venv
            echo ".venv/" >> .gitignore
            echo "__pycache__/" >> .gitignore
            echo "*.pyc" >> .gitignore
            ;;
        rust|cargo)
            cargo init
            ;;
        go|golang)
            go mod init "$name"
            ;;
        *)
            echo "Default project created"
            ;;
    esac

    git init
    echo "# $name" >> README.md
}

# Quick commit
quick_commit() {
    local message="${1:-update}"
    git add -A
    git commit -m "$message"
}

# Create GitHub PR
pr() {
    local title="${1:-Update}"
    local body="${2:-}"
    if command -v gh &>/dev/null; then
        gh pr create --title "$title" --body "$body"
    else
        echo "gh CLI not found. Please install GitHub CLI."
        return 1
    fi
}

# System admin helper functions

# Quick system info
sysinfo() {
    echo "=== System Info ==="
    echo "Kernel: $(uname -r)"
    echo "OS: $PLATFORM"
    echo "Uptime: $(uptime | awk -F'load average:' '{print $1}')"
    echo -e "\n=== Disk Usage ==="
    df -h | head -5
    if command -v free &>/dev/null; then
        echo -e "\n=== Memory ==="
        free -h
    elif command -v vm_stat &>/dev/null; then
        echo -e "\n=== Memory (macOS) ==="
        vm_stat
    fi
}

# Port scan function
scan_ports() {
    local host="${1:-localhost}"
    local ports="${2:-1-1024}"

    if command -v nmap &>/dev/null; then
        nmap -p "$ports" "$host"
    elif command -v nc &>/dev/null; then
        echo "Scanning $host ports $ports..."
        nc -zv "$host" 1-1024 2>&1 | grep -v "Connection refused"
    else
        echo "Neither nmap nor nc found. Please install one."
        return 1
    fi
}

# Service management (cross-platform)
svc() {
    local action="$1"
    local service="$2"

    if [[ -z "$action" ]] || [[ -z "$service" ]]; then
        echo "Usage: svc <start|stop|restart|status> <service>"
        return 1
    fi

    if command -v systemctl &>/dev/null; then
        sudo systemctl "$action" "$service"
    elif command -v service &>/dev/null; then
        sudo service "$service" "$action"
    elif command -v brew &>/dev/null && [[ "$PLATFORM" == "macos" ]]; then
        brew services "$action" "$service"
    else
        echo "No service manager found"
        return 1
    fi
}
