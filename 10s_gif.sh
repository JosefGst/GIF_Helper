#!/bin/bash


# Print help if -h is passed
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
		echo "Usage: $0 <input.mp4> [-o output.gif] [-l length]"
		echo -e "\nTakes an <input.mp4> and converts it to a GIF."
		echo "-o output.gif   Specify output GIF file (default: output.gif)"
		echo "-l length       Desired GIF length in seconds (default: 10)"
		exit 0
fi

if [ -z "$1" ]; then
		echo "Usage: $0 <input.mp4> [-o output.gif] [-l length]"
		exit 1
fi

input_mp4="$1"
output_gif="${input_mp4%.mp4}.gif"
desired_video_length=10  # in seconds

shift  # Move to next argument for getopts

while getopts "o:l:" opt; do
	case $opt in
		o) output_gif="$OPTARG" ;;
		l) desired_video_length="$OPTARG" ;;
		*) echo "Usage: $0 <input.mp4> [-o output.gif] [-l length]"; exit 1 ;;
	esac
done

# Get the length of the input mp4 in seconds
mp4_length=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$input_mp4")

# Convert to GIF with the desired length
# ffmpeg -i "$input_mp4" -vf "setpts=$desired_video_length/$mp4_length*PTS,fps=10,scale=480:-1:flags=lanczos" -gifflags +transdiff -y "$output_gif"

ffmpeg -i "$input_mp4" -filter_complex \
"[0:v]setpts=$desired_video_length/$mp4_length*PTS,fps=4,scale=320:-1:flags=lanczos,split[a][b];[a]palettegen[p];[b][p]paletteuse" \
-gifflags +transdiff -y "$output_gif"

# Optimize the GIF using gifsicle
gifsicle -O3 --lossy=100 "$output_gif" -o "$output_gif"
