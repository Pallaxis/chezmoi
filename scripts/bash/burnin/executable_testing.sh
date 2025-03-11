#!/usr/bin/env bash
folder=$HOME/media/videos/burn-in/folder
if [ -d $folder ] && [ -z "$( ls -A "$folder/end" )" ]; then
	echo "exists and end is empty"
else
	echo "doesnt exist or is full"
fi
