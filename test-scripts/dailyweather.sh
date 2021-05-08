#!/bin/bash


echo " 現 $(sed '1,6!d' ~/.local/share/weather-report.txt | grep "°C" | grep -o "m\-\?+\?[0-9]\+" | tr -d 'm''\+' | tr '\n' ' ' | sed 's/ .*//')°"
list="$(sed '13!d' ~/.local/share/weather-report.txt | sed 's/([^ ]*)//g'|grep -o "m\-\?+\?[0-9]\+" | sed 's/m//g;s/+//g' | tr '\n' ' ')"
read -a array <<< "$list"
sorted_list=$(echo ${array[*]} | tr ' ' '\n' |  sort -n | tr '\n' ' ')
read -a sorted_array <<< "$sorted_list"
echo "❄️ ${sorted_array[0]} ☀️ ${sorted_array[3]}"
