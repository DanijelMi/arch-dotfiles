export PATH="$PATH:$HOME/.local/bin:/usr/local/bin"
export EDITOR=nvim

shopt -s autocd     # Allows you to cd into directory merely by typing the directory name.
shopt -s expand_aliases # Makes you see what aliases actually do
shopt -s checkwinsize   # rechecks window size after each executed command
shopt -s extglob    # Extended globbing, allowing inverse globs
complete -cf sudo   # Autocomplete now works with sudo
HISTSIZE= HISTFILESIZE= # Infinite history.

alias ls='ls -hN --color=auto --group-directories-first'
alias ll='ls -l --color=auto --group-directories-first'
alias grep="grep --color=auto" # Color grep - highlight desired sequence.
alias ccat="highlight --out-format=ansi" # Color cat - print file with syntax highlighting.

# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
