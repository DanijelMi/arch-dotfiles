# --- EXPORT ---
#export ZSH=$HOME/.config/zsh
#export TERM=xterm-256color
export LC_ALL=en_US.UTF-8 
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# --- HISTORY ---
export HISTSIZE=1000000 # How many commands zsh will load to memory.
export SAVEHIST=1000000 # How many commands history will save on file.
setopt EXTENDED_HISTORY # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # History won't show duplicates on search.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.

# --- ALIAS ---
[ -f ~/.alias_fn ] && source $HOME/.alias_fn  # Import aliases and functions

# --- PLUGINS ---
# Download Znap, if it's not there yet.
[[ -f ~/Git/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Git/zsh-snap

source ~/Git/zsh-snap/znap.zsh  # Start Znap
#znap prompt sindresorhus/pure
znap clone starship/starship
export STARSHIP_CONFIG=$HOME/.config/starship.toml
znap eval starship 'starship init zsh --print-full-init'
znap prompt starship
znap install ohmyzsh/ohmyzsh
#znap source zsh-users/zsh-completions       # Completion definitions for many tools beneath the prompt
#znap source marlonrichert/zsh-autocomplete  # Shows auto-complete suggestions below
#znap source zsh-users/zsh-autosuggestions   # Type-ahead cmd preview as typing based on history and completions
#znap source zsh-users/zsh-syntax-highlighting   # Gives syntax-based color to prompt text
znap source ohmyzsh/ohmyzsh lib/functions.zsh # OMZ depends on this core
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
znap source ohmyzsh/ohmyzsh plugins/docker
znap source ohmyzsh/ohmyzsh plugins/{urltools,kubectx,command-not-found,aws,terraform,aliases,globalias,git,kube-ps1}
znap source ohmyzsh/ohmyzsh plugins/bgnotify # brew install terminal-notifier
export FORGIT_NO_ALIASES=true && znap source wfxr/forgit 

# --- AUTOCOMPLETE ---
[[ $(command -v kubectl) ]] && source <(kubectl completion zsh)
[[ $(command -v helm) ]] && source <(helm completion zsh)

PROMPT='$(kube_ps1)'$PROMPT

#zinit ice from"github-rel" as"command" load @junegunn/fzf-bin
#zinit light Aloxaf/fzf-tab
#zinit light unixorn/fzf-zsh-plugin
