#!/bin/bash
# Symlinks all the config files from the central repository

# If this script is not located at the base directory of the dotfile repository, it will not work.
# Gets the current directory location of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
declare -a dotpaths

#####    DEFINE YOUR SYMLINKS HERE #############
# FORMAT: "PATH_TO_REPO_CONFIG:PATH_IN_SYSTEM"
dotpaths=(
"awesome:~/.config/awesome1" 
"neovim:~/.config/nvim" 
".bashrc:~/.bashrc" 
)
################################################

for i in "${dotpaths[@]}"
do
   paths_split=(${i//:/ })	# seperates each dotpath entry into an array seperated by :
#   echo "ln -srf $PWD/${paths_split[0]} ${paths_split[1]}"
	while true; do
		# expand tildes into full paths
		paths_split[1]="${paths_split[1]/#\~/$HOME}"
#		echo ${paths_split[1]}
		# Checks if the source file/directory exists
		if [ ! -e $DIR/${paths_split[0]} ]; then
		    echo "Error: $DIR/${paths_split[0]} does not exist"
		    break;
		# Check if target already exists
		elif [ -e ${paths_split[1]} ]; 
		then
		    while true; do
			    read -p "${paths_split[1]} already exists!
Do you want to overwrite/skip/overwrite with backup (y/n/B)? " yn
			    if [ ${#yn} == 0 ] ; then yn="B" ; fi
			    case $yn in
				    [Yy]* ) echo Overwrtie; break;;
				    [Nn]* ) echo Skip; break;;
				    [Bb]* ) echo Backup; break;;
				    * ) echo Invalid answer;;
		    esac
		    done
		    break;
		fi
		read -p "Symlink \"$DIR/${paths_split[0]} into ${paths_split[1]}\"(Y/n)? " yn
	    	if [ ${#yn} == 0 ] ; then yn="Y" ; fi
		case $yn in
			[Yy]* ) echo ln -srf $PWD/${paths_split[0]} ${paths_split[1]}; break;;
			[Nn]* ) echo "No!"; break ;;
			* ) echo "Invalid answer";;
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
