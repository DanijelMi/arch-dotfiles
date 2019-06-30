#!/bin/zsh

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

setopt LOCAL_OPTIONS          # allow functions to have local options
setopt LOCAL_TRAPS            # allow functions to have local traps
setopt CLOBBER
setopt RM_STAR_SILENT         # dont ask for confirmation in rm globs
setopt CORRECT                # auto-correct commands
setopt COMPLETE_IN_WORD       # dont nice background tasks
setopt PROMPT_SUBST           # expand prompt sequences
setopt NO_HUP   # Prevent background processes being killed along with the shell

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='nvim'
fi

######## ALIASES ###########
alias ll='ls -l --color=auto --group-directories-first'
alias ls='ls -hN --color=auto --group-directories-first'
alias grep="grep --color=auto" # Color grep - highlight desired sequence.
alias ccat="highlight --out-format=ansi" # Color cat - print file with syntax highlighting.
alias crp="rsync --recursive --progress --size-only --inplace --verbose" # A better cp
alias pacinstall="pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -r sudo pacman -S"
command -v nvim >/dev/null && alias vim="nvim" vimdiff="nvim -d" # Use neovim for vim if present.

######## FUNCTIONS #########
h(){curl cheat.sh/$1;}

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
