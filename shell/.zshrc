#----------| Options |-----------
setopt LOCAL_OPTIONS      # allow functions to have local options
setopt LOCAL_TRAPS        # allow functions to have local traps
setopt CLOBBER
setopt RM_STAR_SILENT     # dont ask for confirmation in rm globs
setopt CORRECT            # auto-correct commands
setopt COMPLETE_IN_WORD   # dont nice background tasks
setopt PROMPT_SUBST       # expand prompt sequences
setopt NO_HUP             # Prevent background processes being killed along with the shell

# Add ctrl-x command building in $EDITOR  #
autoload -U edit-command-line             #
zle -N edit-command-line                  #
bindkey '^x' edit-command-line            #

[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh    # Start zim (zsh fancifier)
source /usr/share/fzf/key-bindings.zsh          # Add CTRL-T, CTRL-R and ALT-C
source /usr/share/fzf/completion.zsh            # Contextual ** Auto-completion. Ex. ssh **<TAB>
[ -f ~/.alias_fn ] && source $HOME/.alias_fn    # Set aliases and functions