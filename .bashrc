shopt -s extglob        # Extended globbing, allowing inverse globs
complete -cf sudo       # Autocomplete now works with sudo
HISTSIZE=90000

[ -f ~/.fzf.bash ] && source ~/.fzf.bash      # Integrate fzf
[ -f ~/.alias_fn ] && source $HOME/.alias_fn  # Import aliases and functions
#eval "$(navi widget bash)"
