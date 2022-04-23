#!/bin/sh

ffmpeg -r 60 -f image2 -s 432x288 -i tagged%04d.png -vcodec libx264 -crf 20  -pix_fmt yuv420p bubble.mp4
