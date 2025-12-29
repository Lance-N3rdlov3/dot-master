#  Aliases 
export aurhelper='yay'
# Terminal and system
alias c='clear'                                                        # clear terminal
alias cl="clear"
alias reload="source ~/.config/zsh/.zshrc"

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# File operations
alias mkdir='mkdir -p'

# Listing (using eza)
alias ls='eza -aG --color=always --group-directories-first --icons --sort type' # preferred listing
alias la='eza -aG --color=always --group-directories-first --icons'  # all fils and dirs
alias ll='eza -lG --color=always --group-directories-first --icons'  # long format
alias lt='eza -aT --color=always --group-directories-first --icons --sort name' # tree listing
alias l.='eza -ald --color=always --group-directories-first --icons .*' # show only dotfiles

# Editors
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias micro='nvim'
alias nano='nvim'

# Configuration files
alias zconf="nvim ~/.config/zsh/.zshrc"
alias uconf="nvim ~/.config/zsh/user.zsh"
alias kconf='nvim ~/.config/kitty/kitty.conf'

# Package management (Arch Linux)
alias un='pacman -Rns'                                             # uninstall package
alias up='pacman -Syu'                                             # update system/package/aur
alias pl='pacman -Qs'                                              # list installed package
alias pa='pacman -Ss'                                              # list available package
alias pc='pacman -Sc'                                              # remove unused cache
alias po='pacman -Qtdq | $aurhelper -Rns -'                        # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -
alias aun='$aurhelper -Rns'                                             # uninstall package
alias aup='$aurhelper -Syu'                                             # update system/package/aur
alias apl='$aurhelper -Qs'                                              # list installed package
alias apa='$aurhelper -Ss'                                              # list available package
alias apc='$aurhelper -Sc'                                              # remove unused cache
alias apo='$aurhelper -Qtdq | $aurhelper -Rns -'                        # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -

alias ??='how2'

alias upd='sudo pacman -Syyu --noconfirm'
alias rmpkg="sudo pacman -Rdd"
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
alias big="expac -H M '%m\t%n' | sort -h | nl"     # Sort installed packages according to size in MB (expac must be installed)
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages
alias fixpacman="sudo rm /var/lib/pacman/db.lck"

# Mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# System administration
alias grubup="sudo update-grub"
alias hw='hwinfo --short'                          # Hardware Info
alias ip='ip -color'
alias jctl="journalctl -p 3 -xb"
alias pacdiff='sudo -H DIFFPROG=meld pacdiff'

# Archives and compression
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '

# Process monitoring
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

# Search and utilities
alias grep='rg --color=auto'
alias fgrep='rg -F --color=auto'
alias egrep='rg -E --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias cat='bat --style auto --decorations auto --color always'

# Package information
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Fun/compatibility aliases
alias apt='man pacman'
alias apt-get='man pacman'
alias please='sudo'
alias tb='nc termbin.com 9999'
alias helpme='cht.sh --shell'

# Database
alias mysql=/usr/local/mysql/bin/mysql

# GUI applications
alias vc='code'                                                        # gui code editor
