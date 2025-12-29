#! /bin/zsh
function extract() {
  # Check if a file was provided
  if [ -z "$1" ]; then
    echo "Usage: extract <archive_file>"
    return 1
  fi

  # Check if the file exists
  if [ ! -f "$1" ]; then
    echo "Error: File '$1' not found."
    return 1
  fi

  case "$1" in
    # Tar archives
    *.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
    *.tar.gz|*.tgz) tar xvzf "$1" ;;
    *.tar.xz|*.txz) tar xvJf "$1" ;;
    *.tar.zst) tar --zstd -xvf "$1" ;;
    *.tar.lz4) tar --lz4 -xvf "$1" ;;
    *.tar) tar xvf "$1" ;;

    # Individual compressed files
    *.bz2) bunzip2 "$1" ;;
    *.gz) gunzip "$1" ;;
    *.xz) unxz "$1" ;;
    *.zst) zstd -d "$1" ;;
    *.lz4) lz4 -d "$1" ;;

    # Other archives
    *.zip) unzip "$1" ;;
    *.rar) unrar x "$1" ;;
    *.7z) 7z x "$1" ;;
    *.Z) uncompress "$1" ;;
    *.deb) ar x "$1" ;;
    *.rpm) rpm2cpio "$1" | cpio -idmv ;;

    # Fallback for unrecognized files
    *)
      echo "'$1' cannot be extracted with extract()"
      return 1
      ;;
  esac
}
