
function tm ()
{
    local man_page;
    man_page=$(man -k . | sort | fzf --prompt='Man Pages> ' --preview='echo {} | awk "{print \$1}" | xargs man' --preview-window=right:60%:wrap);
    man "$(echo "$man_page" | awk '{print $1}')"
}
#
#
function help() {
  if command -v bat >/dev/null 2>&1; then
    "$@" --help | bat --style=auto --paging=auto --color=always
  else
    "$@" --help | cat
  fi
}
#
#
#export MANPAGER="sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -lman --color=always'"
export MANPAGER='nvim +Man!'
#export MANPAGER='sh -c "col -bx | bat --language=man --style=plain --paging=auto --color=always"' 
