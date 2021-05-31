#!/bin/sh
echo '{"version": 1, "click_events": true, "cont_signal": 18, "stop_signal": 19}'
echo '['
echo '[]'

# Launch in background to update status line
while :;
do
	echo -n ",["
	~/.config/sway/modules/misc.sh
	~/.config/sway/modules/spotify.sh
	~/.config/sway/modules/storage.sh
	~/.config/sway/modules/weather.sh
	echo -n "]"
	sleep 1
done #) &

# Listen for STDIN events
while read line;
do
	#echo $line > /tmp/tmp.txt
	# DATE click
	if [[ $line == *"name"*"id_time"* ]]; then
		~/.config/sway/modules/click_time.sh &

	# CPU click
	elif [[ $line == *"name"*"id_cpu"* ]]; then
		htop &
	fi
done
