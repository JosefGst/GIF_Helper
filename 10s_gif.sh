#!/bin/bash


# Print help if -h is passed
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
	echo "Usage: $0 <input.mp4> [output.gif]"
	echo -e "\nTakes an <input.mp4> and converts it to an 10s GIF."
	echo "If [output.gif] is not specified, defaults to output.gif."
	exit 0
fi

if [ -z "$1" ]; then
	echo "Usage: $0 <input.mp4> [output.gif]"
	exit 1
fi

input_mp4="$1"
output_gif="${2:-output.gif}"
mp4_length=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$input_mp4")

ffmpeg -i "$input_mp4" -vf "setpts=10/$mp4_length*PTS,fps=10,scale=480:-1:flags=lanczos" -gifflags +transdiff -y "$output_gif"