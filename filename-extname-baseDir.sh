#!/bin/bash
# learn note about ${ ##* } in bash to get the path,filename,suffix extension,prefix ...
FULLPATH=/usr/share/X11/xorg.conf.d/50-synaptics.conf
# remove all the prefix until "/" character
FILENAME=${FULLPATH##*/}
# remove all the prefix unitl "." character
FILEEXTENSION=${FILENAME##*.}
# remove a suffix, in our case, the filename, this will return the name of the directory that contains this file
BASEDIRECTORY=${FULLPATH%$FILENAME}

echo "path = $FULLPATH"
echo "file name = $FILENAME"
echo "file extension = $FILEEXTENSION"
echo "base directory = $BASEDIRECTORY"

