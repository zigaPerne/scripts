#!/bin/sh

video1=$1
video2=$2
ffmpeg -i $1 -i $2 -filter_complex "[0:v]setpts=PTS-STARTPTS, pad=iw*2:ih[bg]; [1:v]setpts=PTS-STARTPTS[fg]; [bg][fg]overlay=w" side_by_side.mp4


