#!/bin/bash
# Symlinks all the config files from the central repository

# If this script is not located at the base directory of the dotfile repository, it will not work.
# Gets the current directory location of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
declare -a dotpaths

#####  DEFINE YOUR SYMLINKS HERE  ############
# FORMAT: "PATH_TO_REPO_CONFIG:PATH_IN_SYSTEM"
dotpaths=(
"awesome:~/.config/awesome" 
"neovim/init.vim:~/.config/nvim/init.vim" 
".bashrc:~/.bashrc" 
".zshrc:~/.zshrc" 
"rofi/config:~/.config/rofi/config"
"scripts/glitch-lock.sh:/bin/glitch-lock"
)
########  END OF CONFIGURATION  ##############

# Check if the script is run as root. It is likely that the user does not want to do this
if [[ $EUID -eq 0 ]]; then
    while true; do
        read -p "WARNING: are you sure you want to install these settings to the ROOT user? (y/N)" yn
        if [ ${#yn} == 0 ] ; then yn="N" ; fi # Sets the default option
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) exit 0;;
            * ) echo Invalid answer;;
    esac
    done
fi

for i in "${dotpaths[@]}"
do
   paths_split=(${i//:/ })	# seperates each dotpath entry into an array seperated by :
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
Do you want to overwrite/skip/overwrite with backup (y/N/b)? " yn
			    if [ ${#yn} == 0 ] ; then yn="N" ; fi # Sets the default option
			    case $yn in
				    [Yy]* ) rm -rf ${paths_split[1]};
					    ln -sf $DIR/${paths_split[0]} ${paths_split[1]};
					    break;;
				    [Nn]* ) break;;
				    [Bb]* ) cp -r ${paths_split[1]} ${paths_split[1]}-BACKUP;
					    echo "Original file backed up as ${paths_split[1]}-BACKUP";
				    	    rm -rf ${paths_split[1]}; 
					    ln -sf $DIR/${paths_split[0]} ${paths_split[1]}; 
					    break;;
				    * ) echo Invalid answer;;
		    esac
		    done
		    break;
		fi
		read -p "Symlink \"$DIR/${paths_split[0]} into ${paths_split[1]}\"(Y/n)? " yn
	    	if [ ${#yn} == 0 ] ; then yn="Y" ; fi # Sets the default option
		case $yn in
			[Yy]* ) mkdir -p `dirname ${paths_split[1]}`;
				ln -sf $DIR/${paths_split[0]} ${paths_split[1]}; break;;
			[Nn]* ) break;;
			* ) echo "Invalid answer";;
		esac
	   sleep 1
	done
done
