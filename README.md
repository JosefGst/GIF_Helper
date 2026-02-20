# 10s GIF Helper
This script takes an input MP4 video file of any length and speeds it up into a 10-second GIF. If an output filename is not specified, it defaults to `output.gif`.

## Requirements

    sudo apt-get install ffmpeg gifsicle

## Usage

```bash
./10s_gif.sh <input.mp4> [-o output.gif] [-l length]
```

## Example

```bash
./10s_gif.sh myvideo.mp4
./10s_gif.sh myvideo.mp4 -o myclip.gif
./10s_gif.sh myvideo.mp4 -l 20
./10s_gif.sh myvideo.mp4 -o myclip.gif -l 15
# Apply to all MP4 files in the current directory
for f in *.mp4; do 10s_gif.sh "$f" -o "${f%.mp4}.gif"; done
```
