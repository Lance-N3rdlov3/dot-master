#!/usr/bin/env zsh

# Mise/rtx configuration - Version manager
if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi
