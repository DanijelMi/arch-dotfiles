shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.

alias ls='ls -hN --color=auto --group-directories-first'
alias ll='ls -l --color=auto --group-directories-first'
alias grep="grep --color=auto" # Color grep - highlight desired sequence.
alias ccat="highlight --out-format=ansi" # Color cat - print file with syntax highlighting.
alias ethspeed="python2.7 /usr/local/bin/speedometer/speedometer.py -r enp2s0"
alias wifispeed="python2.7 /usr/local/bin/speedometer/speedometer.py -r wlp3s0"
alias accesspoint="sudo create_ap wlp3s0 ens2s0 Arch_DM devetosam09 &" 
alias accesspoint_kill="sudo create_ap --stop wlp3s0"

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
