#!/usr/bin/env zsh

# PATH Management
# Remove duplicates and add user-specific paths
typeset -U PATH

# Add user bin directories first
[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"
[[ -d "$HOME/go/bin" ]] && PATH="$HOME/go/bin:$PATH"
[[ -d "$HOME/.pkgx/bin" ]] && PATH="$HOME/.pkgx/bin:$PATH"
[[ -d "$HOME/.cargo/bin" ]] && PATH="$HOME/.cargo/bin:$PATH"
[[ -d "$HOME/.rbenv/bin" ]] && PATH="$HOME/.rbenv/bin:$PATH"

# Platform-specific paths
case "$PLATFORM" in
    macos)
        [[ -d "/opt/homebrew/bin" ]] && PATH="/opt/homebrew/bin:$PATH"
        [[ -d "/usr/local/bin" ]] && PATH="/usr/local/bin:$PATH"
        ;;
    arch)
        [[ -d "/usr/bin" ]] && PATH="$PATH:/usr/bin"
        [[ -d "/usr/bin/site_perl" ]] && PATH="$PATH:/usr/bin/site_perl"
        [[ -d "/usr/bin/vendor_perl" ]] && PATH="$PATH:/usr/bin/vendor_perl"
        ;;
esac

# Language and encoding
export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"
export LC_CTYPE="${LC_CTYPE:-en_US.UTF-8}"
