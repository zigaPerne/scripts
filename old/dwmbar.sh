#!/bin/sh
#
#Status bar script. Start it in .xinitrc or .xprofile.

#Set delimiter
delim="|"


display() { \


	#Gets weather data from pre-downloaded file
	
	#Get current temperature:
	current="  現$(sed '1,6!d' ~/.local/share/weather-report.txt | grep "°C" | grep -o "m\-\?+\?[0-9]\+" | tr -d 'm''\+' | tr '\n' ' ' | sed 's/ .*//')°"

	#Get daily min and max:
	temperature_list="$(sed '13!d' ~/.local/share/weather-report.txt | sed 's/([^ ]*)//g'| grep -o "m\-\?+\?[0-9]\+" | sed 's/m//g;s/+//g' | sort -n | tr '\n' ' ')"
	read -a temperature_array <<< "$temperature_list"
	min_max="❄️${temperature_array[0]}° ☀️${temperature_array[3]}°"
	
	#Get max percipitation %:
	percip="☂️$(sed '16!d' ~/.local/share/weather-report.txt | grep -o "[0-9]\+%" | tr -d '%' | sort -n | tr '\n' ' ' | grep -o '[0-9]\+\s$' | tr -d ' ')%"
	echo " "
	echo $current $min_max $percip | tr -d ' '
	echo $delim
	

	#Checks internet staus
	sed "s/down/⚠️/;s/up/🌍/" /sys/class/net/e*/operstate
	echo $delim



	#Gets the audio status info from pulseaudio.
	#If speaker or mic is muted, 
	#it displays additional messages.
	volume_full=$(pulseaudio-ctl full-status)
	read -a strarr <<< "$volume_full"

	case ${strarr[0]} in
		100) echo "🔊100" ;;
		[0-33]*) echo "🔈${strarr[0]}" ;;
		[34-66]*) echo "🔉${strarr[0]}" ;;
		*) echo "🔊${strarr[0]}" ;;
	esac

	case ${strarr[1]} in
		yes) echo "🔇"	;;
	esac

	case ${strarr[2]} in
		yes) echo "🎙️" ;;
	esac
	echo $delim



	#Gets time and date.
	day="$(grep "$(date "+%a")" ~/.local/share/ref/japan-days.ref | sed 's/.*://g')"
	echo "$(date "+%Y年%m月%d日") ($day) | $(date "+%k:%M" )"

	}

while :; do
	xsetroot -name "$(display | tr '\n' ' ')"
	sleep 30
done

