#!/usr/bin/env zsh

# macOS specific configuration
# Only sourced when PLATFORM=macos

if [[ "$PLATFORM" != "macos" ]]; then
    return
fi

# Homebrew initialization
if command -v brew &>/dev/null; then
    eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null)"
fi

# macOS-specific aliases
alias brewup='brew update && brew upgrade && brew cleanup'
alias caskup='brew upgrade --cask'
alias brewls='brew list --formula'
alias brewcask='brew list --cask'

# Show/hide hidden files in Finder
alias show='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hide='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'

# Lock screen
alias lock='pmset displaysleepnow'

# Flush DNS cache
alias flushdns='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'

# Empty trash
alias emptytrash='sudo rm -rf ~/.Trash/*'

# macOS-specific paths
export ANDROID_HOME="${ANDROID_HOME:-$HOME/Library/Android/sdk}"
[[ -d "$ANDROID_HOME" ]] && PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"

# Homebrew-installed tools
if [[ -d "/opt/homebrew/opt/openjdk" ]]; then
    export JAVA_HOME="/opt/homebrew/opt/openjdk"
fi

# macOS-specific completions
if [[ -d "/opt/homebrew/share/zsh-completions" ]]; then
    fpath=(/opt/homebrew/share/zsh-completions $fpath)
fi

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true
