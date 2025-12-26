#!/usr/bin/env zsh

# Zsh Options - Core settings
setopt correct                           # Auto correct mistakes
setopt extendedglob                      # Extended globbing with regex
setopt nocaseglob                        # Case insensitive globbing
setopt rcexpandparam                     # Array expansion with parameters
setopt nocheckjobs                       # Don't warn about running processes when exiting
setopt numericglobsort                   # Sort filenames numerically
setopt nobeep                            # No beep
setopt appendhistory                      # Immediately append history instead of overwriting
setopt histignorealldups                 # Remove older duplicate commands
setopt histfindnodups                    # Do not display a previously found event
setopt histignorespace                   # Don't record commands starting with space
setopt sharehistory                      # Share history across all sessions
setopt incappendhistory                  # Incremental append to history file
setopt autocd                            # cd to directory if only path is entered
setopt auto_pushd                        # Automatically pushd when using cd
setopt pushd_ignore_dups                  # Ignore duplicates in pushd
setopt pushdminus                        # Exchange meanings of +/- in pushd
setopt nomatch                           # If pattern has no matches, leave unchanged
setopt notify                            # Report status of background jobs immediately
setopt hashcmds                          # Hash commands to speed up PATH lookups
setopt hashdirs                          # Hash directories as well
setopt menucomplete                       # Show completion menu on first tab
setopt listpacked                         # Completions will be packed tighter
setopt nolistbeep                        # No beep on ambiguous completion

# History settings
HISTFILE="${HISTFILE:-$HOME/.zhistory}"
HISTSIZE=10000
SAVEHIST=100000
setopt hist_expire_dups_first             # Expire duplicate entries first
setopt hist_verify                        # Verify commands before executing with history expansion
