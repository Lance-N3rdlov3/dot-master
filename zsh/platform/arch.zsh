#!/usr/bin/env zsh

# Arch Linux specific configuration
# Only sourced when PLATFORM=arch

if [[ "$PLATFORM" != "arch" ]]; then
    return
fi

# Arch-specific aliases
if [[ -n "$AURHELPER" ]]; then
    alias up='$AURHELPER -Syu'
    alias un='$AURHELPER -Rns'
    alias pl='$AURHELPER -Qs'
    alias pa='$AURHELPER -Ss'
    alias pc='$AURHELPER -Sc'
    alias po='$AURHELPER -Qtdq | $AURHELPER -Rns -'
else
    alias up='sudo pacman -Syu'
    alias un='sudo pacman -Rns'
    alias pl='pacman -Qs'
    alias pa='pacman -Ss'
    alias pc='sudo pacman -Sc'
fi

# Mirror management
alias mirror='sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist'
alias mirrord='sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist'
alias mirrors='sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist'
alias mirrora='sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist'

# System maintenance
alias fixpacman='sudo rm /var/lib/pacman/db.lck'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
alias rip='expac --timefmt="%Y-%m-%d %T" "%l\t%n %v" | sort | tail -200 | nl'
alias big="expac -H M '%m\t%n' | sort -h | nl"
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'

# Help for Arch users
alias apt='man pacman'
alias apt-get='man pacman'

# Load Arch-specific plugin paths
if [[ -d /usr/share/zsh/plugins ]]; then
    # Add zsh plugins to fpath if they exist
    [[ -d /usr/share/zsh/plugins/zsh-completions ]] && fpath=(/usr/share/zsh/plugins/zsh-completions $fpath)
fi

# Command-not-found hook for Arch
if [[ -e /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
    source /usr/share/doc/pkgfile/command-not-found.zsh
fi

if [[ -e /usr/share/doc/find-the-command/ftc.zsh ]]; then
    source /usr/share/doc/find-the-command/ftc.zsh
fi
