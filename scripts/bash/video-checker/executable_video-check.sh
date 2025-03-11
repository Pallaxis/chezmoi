#!/usr/bin/env bash

help() {
	printf -- "-h	Show this help menu & exit\n"
	printf -- "-c	Clear saved video lists\n"
	exit
}

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

cleanup() {
	echo
	printf "%s\n" "${passed_videos[@]}" > passed-videos.txt
	printf "%s\n" "${failed_videos[@]}" > failed-videos.txt
	exit
}
trap cleanup INT


# Checking for arguments on startup
OPTSTRING=":hc"
while getopts ${OPTSTRING} opt; do
	case ${opt} in
		h)
			help
			;;
		c)
			echo "Deleting saved files..."
			script_location=$0
			rm "${script_location%/*}/passed-videos.txt"
			rm "${script_location%/*}/failed-videos.txt"
			exit
			;;
		?)
			echo "Invalid option: -${OPTARG}."
			help
			exit 1
			;;
	esac
done



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
