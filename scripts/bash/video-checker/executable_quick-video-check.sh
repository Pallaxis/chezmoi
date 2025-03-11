#!/usr/bin/env bash

confirm() {
	echo
	read -r -p "Does the video look good? [y/N] " response
	response=${response,,}    # tolower
	if [[ "$response" =~ ^(yes|y)$ ]]; then
		return 0
	elif [[ "$response" =~ ^(quit|q)$ ]]; then
		cleanup
	else
		return 255
	fi
}

video_dir=~/media/videos/zeus
script=$0
script_dir=${$script%/*}
echo $script_dir
passed_videos=()
failed_videos=()

for video in "$video_dir"/*;do
	printf "Playing %s...\nPress Ctrl+C to exit. (Ctrl+Q in VLC)" "$video"
	vlc $video &> /dev/null
	if confirm $1; then
		passed_videos+=( "$video" )
	else
		failed_videos+=( "$video" )
	fi
	printf "%s\n" "${passed_videos[@]}"
done

exit
