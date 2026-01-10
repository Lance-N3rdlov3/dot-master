export BAT_THEME="Catppuccin Frappe"

if command -v "bat" &>/dev/null; then
    #! alias -g -- h='-h 2>&1 | bat --language=help --style=plain --paging=never --color always' # <--- this is discouraged! This conflicts with posix -h test operator
    alias -g -- --help='--help 2>&1 | bat --language=help --style=plain --paging=never --color always'
   # alias cat='bat --style header --style snip --style changes --style numbers --style grid --style changes --style rule --color always'
    alias cat='bat --style auto --decorations auto --color always' 
#

fi
