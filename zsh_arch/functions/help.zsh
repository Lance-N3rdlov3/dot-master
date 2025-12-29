#! /bin/zsh
function help() {
  if command -v bat >/dev/null 2>&1; then
    "$@" --help | bat --style=auto --paging=never --color=always
  else
    "$@" --help | cat
  fi
}
