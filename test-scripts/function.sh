#!/bin/sh

function crop_image {
	len=$(identify /tmp/album_cover.png | awk '{print $3}' | awk -Fx '{print $1}')
	hei=$(identify /tmp/album_cover.png | awk '{print $3}' | awk -Fx '{print $2}')
	left=$((($len-400)/2))
	top=$((($hei-225)/2))
	convert /tmp/album_cover.png -crop 400x225+0+0 /tmp/album_cover.png 
	echo $left
	echo $top
}
crop_image


