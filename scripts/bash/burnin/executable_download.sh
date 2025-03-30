#!/usr/bin/env bash
# Downloads .mp4 and .out files from specified rvp_folders.
# Checks if folders exist and are empty before starting
# Can probably be expanded to run commands on the host and wait until the data is generated before exiting

#rvp_folders=("rvp-ats-ansible-platbook-rpi" "rvp-ats-ansible-platbook-rpi_3")	# Edit this to change what folders we are downloading from
rvp_folders=("rvp-ats-ansible-platbook-rpi")
download_folder="$HOME/media/videos/burn-in/"	# Where we want to save the output to
host="mikyla"	# Set this to the burn-in test bench ( mikyla@10.71.0.125 for the ubuntu macbook upstairs )

help() {
    printf -- "-h, --help	Show this help menu & exit\n"
    printf -- "-s, --start	Create folder structure and download into start folder\n"
    printf -- "-e, --end	IMPORTANT: Only run after teardown has been completed! Download to end folder of most recent project folder\n"
    exit
}

start() {
    printf "Currently selected rvp is: $rvp_folders\n"
    #		read -p "Have you saved all videos and dmesgs from last run?" yn
    #		case $yn in
    #			[yY] echo "Starting new run...";
    #			ssh mikyla;;
    #			[nN] echo "Exiting...";
    #			exit;;
    cd $download_folder
    folder_name=burn_in_$(date '+%d-%m-%y')
    echo $folder_name
    if [[ -d $folder_name ]]; then
        echo "$folder_name already exists. Exiting..."
        exit
    else
        echo "Creating folder: $folder_name"
        mkdir $folder_name $folder_name/start $folder_name/end

        for remote_path in "${rvp_folders[@]}"; do
            run_scp "$remote_path" "$folder_name/start" "start"
            echo "ping"
        done
    fi
}

end() {
    cd $download_folder
    newest_file=$(ls -Art | tail -n 1)
    echo $newest_file
    # Bit of a mess of if statements, should clean up a bit
    if [ -z "$newest_file" ]; then
        echo "No folder exists, has the start command been run? Exiting..."
        exit
    else 
        echo "Folder exists, can continue"
    fi
    if [ -z "$( ls -A "$newest_file/end" )" ]; then
        echo "Folder exists and is ready to be downloaded to."
    else
        echo "end folder is not empty. Exiting..."
        exit
    fi

        #	Running before teardown has completed will just give the same results as the start but in the end folder
        echo "!!!MAKE SURE TEARDOWN HAS BEEN RUN!!!"

        for remote_path in "${rvp_folders[@]}"; do
            run_scp "$remote_path" "$newest_file/end" "end"
        done
        echo "Files downloaded, exiting."
        exit
    }

    run_scp() {
        local remote_path=$1
        local file_destination=$2
        local copy_mode=$3

        if [[ "$copy_mode" == "start" ]]; then
            echo "start selected for scp"
            scp "$host:$remote_path"/*.mp4 "$file_destination"
        elif [[ "$copy_mode" == "end" ]]; then
            echo "end selected for scp"
            scp "$host:$remote_path"/*.mp4 "$file_destination"
            scp "$host:$remote_path"/*.out "$file_destination"
        else
            # This should never trigger lol
            echo "how did we get here?"
        fi
    }

    VALID_ARGS=$(getopt -o seh --long start,end,help -- "$@")
    if [[ $? -ne 0 ]]; then
        exit 1;
    fi

    eval set -- "$VALID_ARGS"
    while [ : ]; do
        case "$1" in
            -s | --start)
                echo "Processing 'start' option"
                start
                shift
                ;;
            -e | --end)
                echo "Processing 'end' option"
            end
            shift
            ;;
        -h | --help)
            echo "Processing 'help' option"
            help
            shift
            ;;
        --) shift; 
            break 
            ;;
    esac
done
# vim: sw=4 et
