#!/usr/bin/env zsh

# Platform Detection
# Determine the current operating system and package manager
typeset -g PLATFORM
typeset -g PACKAGE_MANAGER
typeset -g AURHELPER

if [[ "$OSTYPE" == "darwin"* ]]; then
    PLATFORM="macos"
    if command -v brew &>/dev/null; then
        PACKAGE_MANAGER="brew"
    fi
elif [[ -f /etc/arch-release ]]; then
    PLATFORM="arch"
    PACKAGE_MANAGER="pacman"
    if command -v yay &>/dev/null; then
        AURHELPER="yay"
    elif command -v paru &>/dev/null; then
        AURHELPER="paru"
    fi
elif [[ -f /etc/debian_version ]] || [[ -f /etc/lsb-release ]]; then
    PLATFORM="debian"
    PACKAGE_MANAGER="apt"
elif [[ -f /etc/fedora-release ]]; then
    PLATFORM="fedora"
    PACKAGE_MANAGER="dnf"
elif [[ -f /etc/redhat-release ]]; then
    PLATFORM="redhat"
    PACKAGE_MANAGER="yum"
else
    PLATFORM="linux"
    if command -v apt &>/dev/null; then
        PACKAGE_MANAGER="apt"
    elif command -v dnf &>/dev/null; then
        PACKAGE_MANAGER="dnf"
    elif command -v pacman &>/dev/null; then
        PACKAGE_MANAGER="pacman"
    fi
fi

export PLATFORM PACKAGE_MANAGER AURHELPER
