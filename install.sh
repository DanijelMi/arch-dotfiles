#!/bin/bash
# Symlinks all the config files from the central repository
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
declare -a dotpaths

dotpaths=(
"awesomec:~/.config/awesomea" 
"neovim:~/.config/nvima" 
".bashrc:~/.bashrc" 
)

for i in "${dotpaths[@]}"
do
   paths_split=(${i//:/ })	# seperates each dotpath entry into an array seperated by :
#   echo "ln -srf $PWD/${paths_split[0]} ${paths_split[1]}"
	while true; do
		# Checks if the source file/directory exists
		if [ ! -f $DIR/${paths_split[0]} ] && [ ! -d $DIR/${paths_split[0]} ]; then
		    echo "Error: $DIR/${paths_split[0]} does not exist"
		    break;
		fi
		if [ -f ${paths_split[1]} ]; then
		    echo "Warning: ${paths_split[1]} already exists"
		    break;
		fi
		read -p "Symlink \"$DIR/${paths_split[0]} into ${paths_split[1]}\"(Y/n)? " yn
		case $yn in
			[Yy]* ) echo "Yes!"; break;;
			[Nn]* ) echo "No!"; break ;;
			* ) echo "Please answer yes or no.";;
		esac
	   sleep 1
	done
done
#while true; do
#    read -p "Do you wish to install this program?" yn
#    case $yn in
#        [Yy]* ) make install; break;;
#        [Nn]* ) exit;;
#        * ) echo "Please answer yes or no.";;
#    esac
#done
