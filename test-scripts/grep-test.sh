#!/bin/bash

var="$(grep -o -m 1 "\+\?-\?[0-9].*°C" $HOME/.local/share/weather-report.txt
)"
read -ra strarr <<< "$var"

echo ${strarr[4]}
