#!/usr/bin/env zsh

# McFly configuration - Fuzzy history search
if command -v mcfly &>/dev/null; then
    export MCFLY_FUZZY="${MCFLY_FUZZY:-true}"
    export MCFLY_RESULTS="${MCFLY_RESULTS:-20}"
    export MCFLY_INTERFACE_VIEW="${MCFLY_INTERFACE_VIEW:-BOTTOM}"
    export MCFLY_RESULTS_SORT="${MCFLY_RESULTS_SORT:-LAST_RUN}"
    export MCFLY_HISTORY_LIMIT="${MCFLY_HISTORY_LIMIT:-10000}"
    export MCFLY_DEBUG="${MCFLY_DEBUG:-0}"

    eval "$(mcfly init zsh)"
fi
