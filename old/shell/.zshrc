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

[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh    # Start zim (zsh fancifier)
source /usr/share/fzf/key-bindings.zsh          # Add CTRL-T, CTRL-R and ALT-C
source /usr/share/fzf/completion.zsh            # Contextual ** Auto-completion. Ex. ssh **<TAB>
export FZF_DEFAULT_OPTS='--height=70% --preview="cat {}" --preview-window=right:60%:wrap'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" 2> /dev/null' # fzf default params (use ripgrep)
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"                                                    # Make the above apply to CTRL-T 
[ -f ~/.alias_fn ] && source $HOME/.alias_fn    # Set aliases and functions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh