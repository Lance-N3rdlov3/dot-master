
# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files sourced from it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update      'yes'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '14'

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard  'mac'

# Start tmux if not already in tmux.
#zstyle ':z4h:' start-tmux command tmux -u new -A -D -t z4h

# Whether to move prompt to the bottom when zsh starts and on Ctrl+L.
zstyle ':z4h:' prompt-at-bottom 'no'

# Mark up shell's output with semantic information.
zstyle ':z4h:' term-shell-integration 'yes'

# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'

# Recursively traverse directories when TAB-completing files.
zstyle ':z4h:fzf-complete' recurse-dirs 'yes'

# Enable direnv to automatically source .envrc files.
zstyle ':z4h:direnv'         enable 'no'
# Show "loading" and "unloading" notifications from direnv.
zstyle ':z4h:direnv:success' notify 'yes'

# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# SSH when connecting to these hosts.
zstyle ':z4h:ssh:example-hostname1'   enable 'no'
zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
# The default value if none of the overrides above match the hostname.
zstyle ':z4h:ssh:*'                   enable 'yes'

# Send these files over to the remote host when connecting over SSH to the
# enabled hosts.
zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh' 

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`. This is just an
# example. If you don't plan to use Oh My Zsh, delete this line.
z4h install ohmyzsh/ohmyzsh || return

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Extend PATH.
#starship theme
<<<<<<< HEAD
eval "$(starship init zsh)"
=======
#eval "$(starship init zsh)"
>>>>>>> refs/remotes/origin/main

 export PATH=/opt/homebrew/bin:$PATH

#test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true
export GOPATH=$HOME/go/
#export GOROOT=$(brew --prefix go)/libexec
export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$HOME/.mynav:$PATH


export PATH=/opt/homebrew/opt/uutils-creutils/libexec/uubin:/opt/homebrew/bin:$HOME/bin:$HOME/.local/bin:/usr/bin:/bin:/sbin:/$HOME/.local/share:$HOME/.bin:/usr/sbin:/root:/etc:/proc:/opt:$PATH
# Export environment variables.
export GPG_TTY=$TTY

# Source additional local files if they exist.
z4h source ~/.env.zsh
z4h source ~/.config/zsh/functions/bat.zsh
z4h source ~/.config/zsh/functions/eza.zsh
z4h source ~/.config/zsh/functions/fzf.zsh
z4h source ~/.config/zsh/functions/fzf-marks.plugin.zsh  
z4h source ~/.config/zsh/functions/man.zsh
z4h source ~/.config/zsh/functions/extr.zsh
z4h source ~/.config/zsh/functions/error-handlers.zsh
z4h source ~/.config/zsh/functions/y.zsh
# Use additional Git repositories pulled in with `z4h install`.
#
# This is just an example that you should delete. It does nothing useful.
z4h source ohmyzsh/ohmyzsh/lib/diagnostics.zsh  # source an individual file
z4h load   ohmyzsh/ohmyzsh/plugins/emoji-clock  # load a plugin

# Define key bindings.
z4h bindkey undo Ctrl+/    # undo the last command line change
z4h bindkey redo Option+/            # redo the last undone command line change

z4h bindkey z4h-cd-back    Shift+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Shift+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Shift+Up     # cd into the parent directory
z4h bindkey z4h-cd-down    Shift+Down   # cd into a child directory
#
# Use emacs key bindings
bindkey -e

# Start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${terminfo[kcuu1]}" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search

  bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# Start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${terminfo[kcud1]}" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search

  bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
fi


# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M emacs "${terminfo[kcbt]}" reverse-menu-complete
fi

# [Backspace] - delete backward
bindkey -M emacs '^?' backward-delete-char
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char
# [Delete] - delete forward
if [[ -n "${terminfo[kdch1]}" ]]; then
  bindkey -M emacs "${terminfo[kdch1]}" delete-char
  bindkey -M viins "${terminfo[kdch1]}" delete-char
  bindkey -M vicmd "${terminfo[kdch1]}" delete-char
else
  bindkey -M emacs "^[[3~" delete-char
  bindkey -M viins "^[[3~" delete-char
  bindkey -M vicmd "^[[3~" delete-char
  bindkey -M emacs "^[3;5~" delete-char
  bindkey -M viins "^[3;5~" delete-char
  bindkey -M vicmd "^[3;5~" delete-char
fi

typeset -g -A key
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi



# Alt Left - go back a word
key[Alt-Left]="${terminfo[kLFT3]}"
if [[ -n "${key[Alt-Left]}"  ]]; then
	bindkey -M emacs "${key[Alt-Left]}"  backward-word
	bindkey -M viins "${key[Alt-Left]}"  backward-word
	bindkey -M vicmd "${key[Alt-Left]}"  backward-word
fi

# Control Right - go forward a word
key[Alt-Right]="${terminfo[kRIT3]}"
if [[ -n "${key[Alt-Right]}" ]]; then
	bindkey -M emacs "${key[Alt-Right]}" forward-word
	bindkey -M viins "${key[Alt-Right]}" forward-word
	bindkey -M vicmd "${key[Alt-Right]}" forward-word
fi

bindkey '^h'  backward-char         #control+h：向左移动一个单词
bindkey '^l'  forward-char          #control+l：向右移动一个单词
bindkey '^k'  up-line-or-history    #control+k：向上翻看历史记录
bindkey '^j'  down-line-or-history  #control+j：向下翻看历史记录



# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

# Completions and completion optimizations
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' rehash true                              # automatically find new executables in path
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zcache
zstyle ':omz:plugins:alias-finder' autoload yes # disabled by defaultzstyle
zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default


# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit

HISTFILE=~/.zhistory
HISTSIZE=50000
SAVEHIST=10000


# Define named directories: ~w <=> Windows home directory on WSL.
#[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# Define aliases.
alias zconf="nvim ~/.zshrc"
alias uconf="nvim ~/.config/zsh/"

alias mysql=/usr/local/mysql/bin/mysql
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias micro='nvim'
alias nano='nvim'
alias reload="source ~/.config/zsh/.zshrc"
alias cl="clear"
alias kconf='nvim ~/.config/kitty/kitty.conf'
alias code='code .'

bindkey ',' autosuggest-accept


EDITOR=nvim
export EDITOR
#
# Aliases
alias tree='broot'
alias c='clear'
alias vc='code'  # gui code editor
alias fastfetch='fastfetch --logo-type kitty'
#
# # Directory navigation shortcuts
 alias ..='cd ..'
 alias ...='cd ../..'
 alias .3='cd ../../..'
 alias .4='cd ../../../..'
 alias .5='cd ../../../../..'
#
# # Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias mkdir='mkdir -p'
#
# Replace ls with exa
source $HOME/.config/zsh/functions/*
#
# Common Use
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='rg --color=auto'
alias fgrep='rg -F --color=auto'
alias egrep='rg -E --color=auto'
alias hw='hwinfo --short'
alias ip='ip -color'
alias please='sudo'
alias tb='nc termbin.com 9999'
alias helpme='cht.sh --shell'
# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

alias rmpkg="brew uninstall $@"
# Add flags to existing aliases.

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
 else
   export EDITOR='nvim'
 fi

# initialize various cli tools
source <(fzf --zsh)
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"
#source /opt/homebrew/etc/profile.d/z.sh

[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" # boot up x-cmd.

# Added by Antigravity
export PATH="/Users/nrd/.antigravity/antigravity/bin:$PATH"

#starship theme
#eval "$(starship init zsh)"

 export PATH=/opt/homebrew/bin:$PATH

#test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true
#export GOPATH=$HOME/go/
#export GOROOT=$(brew --prefix go)/libexec
export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$HOME/.mynav:$PATH

#export SOFT_SERVE_INITIAL_ADMIN_KEYS=$HOME/.ssh/id_ed25519

# Generated for envman. Do not edit.
#[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

eval "$(pkgx --quiet dev --shellcode)"  # https://github.com/pkgxdev/dev

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/.cache/node_modules/bin/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac



<<<<<<< HEAD
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
=======
 To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
>>>>>>> refs/remotes/origin/main
# bun completions
[ -s "/Users/nrd/.bun/_bun" ] && source "/Users/nrd/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# ===========================================
# ZSH Hacks - Dreams of Code
# ===========================================
# Add these to your .zshrc file
# -------------------------------------------
# 1. Edit Command Buffer
# -------------------------------------------
# Open the current command in your $EDITOR (e.g., neovim)
# Press Ctrl+X followed by Ctrl+E to trigger
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# For Vi mode users:
# bindkey -M vicmd 'v' edit-command-line

# -------------------------------------------
# 2. Undo in ZSH
# -------------------------------------------
# Press Ctrl+_ (Ctrl+Underscore) to undo
# This is built-in, no configuration needed!
# Redo widget exists but has no default binding:
#bindkey '^Y' redo  # Example binding if you want it

# -------------------------------------------
# 3. Magic Space - Expand History
# -------------------------------------------
# Expands history expressions like !! or !$ when you press space
bindkey ' ' magic-space

# -------------------------------------------
# 4. chpwd Hook - Run Commands on Directory Change
# -------------------------------------------
# NOTE: Only one chpwd hook can be defined at once
# To merge them, use add-zsh-hook which is mentioned below

# Example: List directory contents on cd

#chpwd() {
#  ls
#}

# Example: Auto-activate Python virtual environments
#chpwd() {
#  if [[ -d .venv ]]; then
#    source .venv/bin/activate
#  fi
#}

# Example: Auto-load Nix development shells
#chpwd() {
#  if [[ -f flake.nix ]] && [[ -z "$IN_NIX_SHELL" ]]; then
#    nix develop
#  fi
#}

# Example: Auto-use correct Node version with nvm
#chpwd() {
#  if [[ -f .nvmrc ]]; then
#    nvm use
#  fi
#}

# -------------------------------------------
# 4.1. Bonus: Merging Hooks
# -------------------------------------------

# To merge hooks, use add-zsh-hook
autoload -Uz add-zsh-hook


# Then Define separate functions
function auto_venv() {
  # If already in a virtualenv, do nothing
  if [[ -n "$VIRTUAL_ENV" && ! -f "$VIRTUAL_ENV/bin/activate" ]]; then
    deactivate
  fi

  [[ -n "$VIRTUAL_ENV" ]] && return

  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    if [[ -f "$dir/.venv/bin/activate" ]]; then
      source "$dir/.venv/bin/activate"
      return
    fi
    dir="${dir:h}"
  done
}

function auto_nix() {
  # If we're already in a nix develop shell, do nothing
  [[ -n "$IN_NIX_SHELL" ]] && return

  # Walk up to find a flake
  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    if [[ -f "$dir/flake.nix" ]]; then
      # If this project already has .envrc, just allow it (you can remove this if you prefer)
      if [[ ! -f "$dir/.envrc" ]]; then
        # Create .envrc that loads the dev env (fast, no interactive shell)
        #cat > "$dir/.envrc" << EOF
      #  autogenerated: load flake dev environment
          eval "$(nix print-dev-env)"
          command direnv allow "$dir" >/dev/null 2>&1
      fi
          command direnv reload >/dev/null 2>&1
          return
      fi
    dir="${dir:h}"
  done
}

function auto_nvm() {
  [[ -f .nvmrc ]] && nvm use
}
function cd_ls(){
  eza -aG --color=always --group-directories-first --icons always --sort type
}
# Register them all
add-zsh-hook chpwd auto_venv
add-zsh-hook chpwd auto_nix
add-zsh-hook chpwd auto_nvm
add-zsh-hook chpwd cd_ls
# -------------------------------------------
# 5. Suffix Aliases - Open Files by Extension
# -------------------------------------------
# Just type the filename to open it with the associated program
alias -s json=jless
alias -s md=bat
alias -s go='$EDITOR'
alias -s rs='$EDITOR'
alias -s txt=bat
alias -s log=bat
alias -s py='$EDITOR'
alias -s js='$EDITOR'
alias -s ts='$EDITOR'
alias -s html=open  # macOS: open in default browser

# -------------------------------------------
# 6. Global Aliases - Use Anywhere in Commands
# -------------------------------------------
# Redirect stderr to /dev/null
alias -g NE='2>/dev/null'

# Redirect stdout to /dev/null
alias -g NO='>/dev/null'

# Redirect both stdout and stderr to /dev/null
alias -g NUL='>/dev/null 2>&1'

# Pipe to jq
alias -g J='| jq'

# Copy output to clipboard (macOS)
alias -g C='| pbcopy'

# Copy output to clipboard (Linux with xclip)
# alias -g C='| xclip -selection clipboard'

# -------------------------------------------
# 7. zmv - Advanced Batch Rename/Move
# -------------------------------------------
# Enable zmv
#autoload -Uz zmv

# Usage examples:
# zmv '(*).log' '$1.txt'           # Rename .log to .txt
# zmv -w '*.log' '*.txt'           # Same thing, simpler syntax
# zmv -n '(*).log' '$1.txt'        # Dry run (preview changes)
# zmv -i '(*).log' '$1.txt'        # Interactive mode (confirm each)

# Helpful aliases for zmv
alias zcp='zmv -C'  # Copy with patterns
alias zln='zmv -L'  # Link with patterns

# -------------------------------------------
# 8. Named Directories - Bookmark Folders
# -------------------------------------------
# Access with ~name syntax, e.g., cd ~yt or ls ~yt
hash -d yt=~/projects/youtube
hash -d dot=~/.dotfiles
hash -d dl=~/Downloads
hash -d conf=~/.config 
hash -d zshc=~/.cofig/zsh/
# Add your own commonly used directories here
hash -d pro=~/projects/
hash -d rep=~/repo/ 
hash -d vault=~/repo/PKM/
hash -d dm=~/repo/dot-master/
hash -d gst=~/repo/gist/
# -------------------------------------------
# 9. Custom Widgets
# -------------------------------------------
# Clear screen but keep current command buffer
function clear-screen-and-scrollback() {
  echoti civis >"$TTY"
  printf '%b' '\e[H\e[2J\e[3J' >"$TTY"
  echoti cnorm >"$TTY"
  zle redisplay
}
zle -N clear-screen-and-scrollback
bindkey '^X^L' clear-screen-and-scrollback

# Copy current command buffer to clipboard (macOS)
function copy-buffer-to-clipboard() {
  echo -n "$BUFFER" | pbcopy
  zle -M "Copied to clipboard"
}
zle -N copy-buffer-to-clipboard
bindkey '^X^C' copy-buffer-to-clipboard

# For Linux with wl-copy:
# function copy-buffer-to-clipboard() {
#   echo -n "$BUFFER" | wl-copy
#   zle -M "Copied to clipboard"
# }

# -------------------------------------------
# 10. Hotkey Insertions - Text Snippets
# -------------------------------------------
# Insert git commit template (Ctrl+X, G, C)
# \C-b moves cursor back one position
#bindkey -s '^Xgc' 'git commit -m ""\C-b'

# More examples:
#bindkey -s '^Xgp' 'git push origin '
#bindkey -s '^Xgs' 'git status\n'
#bindkey -s '^Xgl' 'git log --oneline -n 10\n'

export HOMEBREW_NO_ENV_HINTS=1
