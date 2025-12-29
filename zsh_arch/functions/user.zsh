#! /bin/zsh
#  Startup 
#
# Commands to execute on startup (before the prompt is shown)
# Check if the interactive shell option is set
#if [[ $- == *i* ]]; then
#    # This is a good place to load graphic/ascii art, display system information, etc.
#    if command -v pokego >/dev/null; then
#        pokego --no-title -r 1,3,6
#    elif command -v pokemon-colorscripts >/dev/null; then
#        pokemon-colorscripts --no-title -r 1,3,6
#    elif command -v fastfetch >/dev/null; then
#        if do_render "image"; then
#            fastfetch --logo-type kitty
#        fi
#    fi
#fi

#   Overrides 
# HYDE_ZSH_NO_PLUGINS=1 # Set to 1 to disable loading of oh-my-zsh plugins, useful if you want to use your zsh plugins system 
# unset HYDE_ZSH_PROMPT # Uncomment to unset/disable loading of prompts from HyDE and let you load your own prompts
# HYDE_ZSH_COMPINIT_CHECK=1 # Set 24 (hours) per compinit security check // lessens startup time
# HYDE_ZSH_OMZ_DEFER=1 # Set to 1 to defer loading of oh-my-zsh plugins ONLY if prompt is already loaded

if [[ ${HYDE_ZSH_NO_PLUGINS} != "1" ]]; then
    #  OMZ Plugins 
    # manually add your oh-my-zsh plugins here
    plugins=(
        sudo
        git
        zsh-autosuggestions
        zsh-syntax-highlighting
        zsh-autosuggestions
        z
        dash
        zoxide
        command-not-found
        colored-man-pages
        colorize
        docker
        docker-compose
        fancy-ctrl-z
        flutter
        github
        golang
        kitty
        brew
        mise
        thefuck
        mosh
        ng
        node
        nodenv
        npm
        react-native
        ruby
        python
        tldr
        tmux
        themes
        thor
        toolbox
        virtualenv
        virtualenvwrapper
        zsh-navigation-tools
        zsh-interactive-cd
        aliases
        fzf-marks
        autojump
        vscode
        fzf
        eza
    )
fi
source $HOME/.env 
source $HOME/.config/zsh/functions/aliases.zsh
source $HOME/.config/zsh/functions/env.zsh
source $HOME/.config/zsh/functions/yazi.zsh
source $HOME/.config/zsh/functions/fzf.zsh
source $HOME/.config/zsh/functions/fzf-marks.plugin.zsh
source $HOME/.config/zsh/functions/error-handlers.zsh
source $HOME/.config/zsh/functions/extract.zsh
source $HOME/.config/zsh/functions/tm.zsh
source $HOME/.config/zsh/functions/tm_man.zsh
source $HOME/.config/zsh/functions/nocaps.zsh
source $HOME/.config/zsh/functions/plugin.zsh
source $HOME/.config/zsh/functions/help.zsh







