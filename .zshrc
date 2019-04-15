export ZSH="$HOME/.oh-my-zsh"   # Path to your oh-my-zsh installation.
export PATH="$PATH:$HOME/.local/bin:/usr/local/bin:/bin"
setopt NO_HUP   # Prevent background processes being killed along with the shell

ZSH_THEME="clean"   # See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
HYPHEN_INSENSITIVE="true"   # Case-sensitive completion must be off. _ and - will be interchangeable.

# DISABLE_AUTO_UPDATE="true"    # disable bi-weekly auto-update checks.
# export UPDATE_ZSH_DAYS=13     # how often to auto-update (in days).
# DISABLE_AUTO_TITLE="true"     # disable auto-setting terminal title.
# COMPLETION_WAITING_DOTS="true"    # display red dots whilst waiting for completion.
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="dd/mm/yyyy"        # "history" command date-stamp format

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh
# export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8 # You may need to manually set your language environment

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='nvim'
fi
# export ARCHFLAGS="-arch x86_64"   # Compilation flags
export SSH_KEY_PATH="~/.ssh/rsa_id" # ssh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
