shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.

alias ls='ls -hN --color=auto --group-directories-first'
alias ll='ls -l --color=auto --group-directories-first'
alias grep="grep --color=auto" # Color grep - highlight desired sequence.
alias ccat="highlight --out-format=ansi" # Color cat - print file with syntax highlighting.
alias ethspeed="python2.7 /usr/local/bin/speedometer/speedometer.py -r enp2s0"
alias wifispeed="python2.7 /usr/local/bin/speedometer/speedometer.py -r wlp3s0"
