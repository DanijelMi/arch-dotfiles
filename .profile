#!/bin/bash

####### EXPORTS ###########
export EDITOR="nvim"
export EDITOR_GUI="leafpad"
export TERMINAL="alacritty_rainbow"
export PAGER="less"
export READER="zathura"
export WEB_BROWSER="firefox"
export IDE_GUI="code"
export FILE_GUI="thunar"
export SUDO_ASKPASS=$HOME/.custombin/rofi-askpass
export LOCAL_BIN=$HOME/.local/bin/
export XDG_CONFIG_HOME="$HOME/.config"
export QT_QPA_PLATFORMTHEME="gtk2"	# Have QT use gtk2 theme.
export QT_AUTO_SCREEN_SCALE_FACTOR=0
#export XDG_CURRENT_DESKTOP=XFCE
#export XDG_CONFIG_DIRS=/etc/xdg

# export LANG=en_US.UTF-8             # You may need to manually set your language environment

# export WALLPAPER_DIR=$HOME/arch-dotfiles/wallpapers

# Adds `~/.local/bin/` and all further subdirectories to $PATH
export PATH="$PATH:$(du "$LOCAL_BIN" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"

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
