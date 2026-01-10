export EZA_CONFIG_DIRa='/Users/nrd/.config/eza/'
if command -v "eza" &>/dev/null; then
  # Replace ls with exa
  alias ls='eza -aG --color=always --group-directories-first --icons --sort type'  \
  alias la='eza -aG --color=always --group-directories-first --icons' \ 
  alias ll='eza -lG --color=always --group-directories-first --icons'  \
  alias lt='eza -aT --color=always --group-directories-first --icons --sort name' \
  alias l.='eza -ald --color=always --group-directories-first --icons .*' # show only dotfiles
  
fi
