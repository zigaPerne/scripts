high="$1" # High image (full-size original view)
low="$2" # Low image (thumbnail) (should be the same size)
output="output.png"
[ ! -z "$3" ] && output="$3" # Output image
size=$(convert "$high" -format "%wx%h" info:)
convert "$high" -alpha off +level 3.5%,100% -gamma 20 high_gamma.png
low_gamma="-alpha off -gamma 0.8 +level 0%,77%"
convert \( "$low" $low_gamma \) high_gamma.png \
           -compose Mathematics -define compose:args='0,-0.33,1,0.33' \
           -composite low_adjusted.png
convert low_adjusted.png high_gamma.png -size $size pattern:gray25 -composite \
        -set gamma 0.022727 -define png:include-chunk=none,gAMA "$output"
rm high_gamma.png low_adjusted.png


#Just ./script.sh hiddenimage.png wantedthumbnail.png output.png
