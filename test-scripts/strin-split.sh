#!/bin/bash

volume_full=$(pulseaudio-ctl full-status)

read -a strarr <<< "$volume_full"

echo "There are ${#strarr[*]} words in the text."

echo "🔊 ${strarr[0]}"

case ${strarr[0]} in
	[0-33]*) echo "🔈 ${strarr[0]}" ;;
	[34-66]*) echo "🔉 ${strarr[0]}" ;;
	*) echo "🔊 ${strarr[0]}" ;;
esac
