#!/usr/bin/env bash
# Simple borgbackup wrapper script
# https://blog.andrewkeech.com/posts/170718_borg.html

# Initialize target repo manually first (not worth automating)
# To explore encryption options: man borg-init
# borg init --encryption=repokey-blake2 /path/to/repo

export REPOSITORY="/mnt/hdd0/backup-borg"  # Borg repo destination
export TARGET="/home"      # Borg backup target

# Fill in your password here, borg picks it up automatically
#export BORG_PASSPHRASE="your_custom_pass_here" 

# Or just pass it through with the first arg
export BORG_PASSPHRASE="$1" 

# Backup all of /home except a few excluded directories and files
borg create -v --stats --compression lz4                 \
    $REPOSITORY::'{hostname}-{now:%Y-%m-%d_%H:%M}' $TARGET \
#--exclude '/home/*/.cache'                               \
#--exclude '/home/*/.ccache'                              \

2>&1        # Route the normal process logging to journalctl

# If there is an error backing up, reset password envvar and exit
if [ "$?" = "1" ] ; then
    export BORG_PASSPHRASE=""
    exit 1
fi
 
# Prune the repo of extra backups
# borg prune -v $REPOSITORY --prefix '{hostname}-'         \
#     --keep-daily=7                                       \
#     --keep-weekly=4                                      \
#     --keep-monthly=6                                     \

# Include the remaining device capacity in the log
#df -hl | grep --color=never /dev/sdc
 
borg list $REPOSITORY
 
# Unset the password
export BORG_PASSPHRASE=""
exit 0