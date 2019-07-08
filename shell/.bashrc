shopt -s autocd         # Allows you to cd into directory merely by typing the directory name.
shopt -s expand_aliases # Makes you see what aliases actually do
shopt -s checkwinsize   # rechecks window size after each executed command
shopt -s extglob        # Extended globbing, allowing inverse globs
complete -cf sudo       # Autocomplete now works with sudo
HISTSIZE=10000

[ -f ~/.fzf.bash ] && source ~/.fzf.bash      # Integrate fzf
[ -f ~/.alias_fn ] && source $HOME/.alias_fn  # Set aliases and functions