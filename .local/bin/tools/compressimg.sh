#!/usr/bin/env bash
# Author: Danijel Milosevic
# Guetzli batching wrapper with multithreading support

OUTPUT_PREFIX=compressed
OUTPUT_SUFFIX=""

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -q|--quality)
    QUALITY="$2"
    shift # past argument
    shift # past value
    ;;
    -p|--process-count)
    PCOUNT="$2"
    shift # past argument
    shift # past value
    ;;
    -h|--help)
    HELP=YES
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

# Ensure that the core tool exists
if ! [ -x "$(command -v guetzli)" ]; then
  echo 'Error: guetzli is not installed.' >&2
  exit 1
fi

# Provide help text
if [ ! -z "$HELP" ] ; then
  echo "Usage: $(basename $0) {SOURCE} {DESTINATION} {QUALLITY (OPTIONAL)}"
  echo -e "-q, --quality \t\t Lower is more compressed. Range: 84-100. Default is 84"
  echo -e "-p, --process-count \t Limit how many parallel image compressions(threads) can run at once"
  exit 0
fi

# QUALITY default
if [ -z "$QUALITY" ] ; then
  QUALITY=84
fi

# Process count default
if [ -z "$PCOUNT" ] ; then
  PCOUNT=2
fi

# SOURCE default
if [ -z "$1" ] ; then
  SOURCE=.
else
  SOURCE=$1
fi

# DESTINATION default
if [ -z "$2" ] ; then
  DESTINATION=./compressed
else
  DESTINATION=$2
fi

#echo "Number files in SEARCH PATH with EXTENSION:" $(ls -1 "${SEARCHPATH}"/*."${EXTENSION}" | wc -l)
#if [[ -n $1 ]]; then
    #echo "Last line of file specified as non-opt/last argument:"
    #tail -1 "$1"
#fi

# Catch if SOURCE directory does not exist
if [[ ! -e $SOURCE ]] ; then
  echo "Error: $SOURCE does not exist" 
  exit 1
fi

# Ensure SOURCE is a dir
if [[ ! -d $SOURCE ]]; then
    echo "$SOURCE is not a directory. If you wish to use it on individual files, use the original 'guetzli' command"
    exit 1

fi

# Catch if destination points to a file instead of a directory
if [[ -f $DESTINATION ]] ; then
  echo "$DESTINATION is not a directory. If you wish to use it on individual files, use the original 'guetzli' command"
  exit 1
# Catch if the path is completely non existant, try to go along by making the specified directory
elif [[ ! -e $DESTINATION ]] ; then
  echo "Warning: the destination path does not exist. Creating it now..." 
  mkdir -p $DESTINATION
fi

#echo $SOURCE
#echo $DESTINATION

# The workhorse
find -wholename "$SOURCE/*.jpg" -print0 -o -wholename "$SOURCE/*.jpeg" -print0 -o -wholename "$SOURCE/*.png" -print0 | \
xargs -0 -I{} -P$PCOUNT guetzli --verbose --quality $QUALITY {} $DESTINATION/{}