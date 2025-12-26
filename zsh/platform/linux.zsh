#!/usr/bin/env zsh

# Generic Linux configuration
# Only sourced when PLATFORM=linux (but not arch/macos/debian/fedora specific)

if [[ "$PLATFORM" != "linux" ]]; then
    return
fi

# Common Linux paths
export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Systemd aliases (if available)
if command -v systemctl &>/dev/null; then
    alias sc='systemctl'
    alias scu='systemctl --user'
    alias jctl='journalctl'
    alias jctlf='journalctl -f'
fi

# Network management
alias ping='ping -c 4'
alias ports='netstat -tulanp'
alias ip='ip -color'

# Package manager aliases (generic)
case "$PACKAGE_MANAGER" in
    apt)
        alias up='sudo apt update && sudo apt upgrade'
        alias un='sudo apt remove --purge'
        alias pl='apt list --installed'
        alias pa='apt search'
        alias pc='sudo apt autoremove && sudo apt autoclean'
        ;;
    dnf)
        alias up='sudo dnf upgrade'
        alias un='sudo dnf remove'
        alias pl='dnf list installed'
        alias pa='dnf search'
        alias pc='sudo dnf autoremove'
        ;;
esac

# Linux-specific tools
if command -v flatpak &>/dev/null; then
    alias fp='flatpak'
    alias fpl='flatpak list'
    alias fpi='flatpak install'
    alias fpu='flatpak update'
fi

if command -v snap &>/dev/null; then
    alias sn='snap'
    alias snl='snap list'
    alias sni='snap install'
    alias snu='snap refresh'
fi
