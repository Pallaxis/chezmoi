#!/usr/bin/env bash
# Grabs $target video files from the hosts listed

target="zeus"
hosts=("ats1" "ats2")

mkdir $HOME/media/videos/$target

for host in ${hosts[@]}; do
	rsync --progress -zav --exclude='*blackdetect.mp4' --include="${target}*.mp4" --exclude='*' $host:rvp-ats/ $HOME/media/videos/$target
done
