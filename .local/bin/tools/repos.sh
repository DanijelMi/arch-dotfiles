#/bin/bash
# Returns all git repos from your HOME and filters out ones that probably aren't of interest to you 
# Easy to edit/add your own filters
# Author: DanijelM 

list_repos (){
  all_repos=$(locate -r $HOME/.*/.git$)
  for i in $all_repos; do
    parentdir_i=$(dirname $i)

    # Ignore all repos that are children of already found repos (usually git submodules/libraries)
    if [[ "$parentdir_i" =~ "$prev_i/".* ]] && [ ! -z "$prev_i" ] ; then
      continue
    # Ignore all repos within hidden dirs
    elif [[ "$parentdir_i" =~ /\..* ]] ; then
      continue
    fi

    prev_i="$parentdir_i"
    printf "$parentdir_i\n"
  done
}

selection=$(list_repos | fzf)
# selection=$(list_repos | rofi -dmenu -i)

if [ ! -z $selection ] ; then
  # printf $selection
  # thunar $selection
  code $selection
fi
