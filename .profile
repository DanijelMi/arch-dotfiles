#!/usr/bin/env bash
# Runs on user login

####### EXPORTS ###########
export EDITOR="nvim"
export EDITOR_GUI="leafpad"
export TERMINAL="alacritty"
export PAGER="less"
export READER="zathura"
export WEB_BROWSER="firefox"
export IDE_GUI="code"
export LOCKSCREEN="lock-better"
# export FILE="vifmuber"
export FILE_GUI="pcmanfm-qt"
export SUDO_ASKPASS=$HOME/.custombin/rofi-askpass
export LOCAL_BIN=$HOME/.local/bin/

export XDG_CONFIG_HOME="$HOME/.config"
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
#export XDG_CURRENT_DESKTOP=XFCE
#export XDG_CONFIG_DIRS=/etc/xdg

# export SSH_KEY_PATH="~/.ssh/rsa_id" # ssh
# export LANG=en_US.UTF-8             # You may need to manually set your language environment
# export MANPATH="$MANPATH:/usr/local/man"
# export ZIM_HOME=$HOME/arch-dotfiles/shell/zimfw # Default zim location
# export WALLPAPER_DIR=$HOME/arch-dotfiles/wallpapers
# export ARCHFLAGS="-arch x86_64"   # Compilation flags

# Perl stuff
# PATH="/home/danijel/perl5/bin${PATH:+:${PATH}}"; export PATH;
# PERL5LIB="/home/danijel/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
# PERL_LOCAL_LIB_ROOT="/home/danijel/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
# PERL_MB_OPT="--install_base \"/home/danijel/perl5\""; export PERL_MB_OPT;
# PERL_MM_OPT="INSTALL_BASE=/home/danijel/perl5"; export PERL_MM_OPT;

# Adds `~/.local/bin/` and all further subdirectories to $PATH
export PATH="$PATH:$(du "$LOCAL_BIN" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"

#export DRI_PRIME=1    # Force discrete gpu to be used globally

# Set aliases and functions
[ -f ~/.alias_fn ] && source $HOME/.alias_fn  

# Source bashrc if exists
[[ -f ~/.bashrc ]] && . ~/.bashrc

startx=false
if which startx > /dev/null 2>&1 ; then
  case "$( tty )" in
  (/dev/tty*)
    while :; do    # Breaking out only if valid answer given
      printf 'Start X? (Y/n): ' # ZSH can't combine this with read -p "Prompt string" cuz zsh read behaves differently
      read choice
      case "$choice" in 
        [Yy] | [Yy][Ee][Ss] | "" ) startx=true ; break ;;
        [Nn] | [Nn][Oo] ) startx=false ; break ;;
        * ) echo "Invalid input" ;;
      esac
    done
  esac
fi
"$startx" && exec startx # Start X if requested
