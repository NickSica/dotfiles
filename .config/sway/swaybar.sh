#!/bin/sh
echo '{"version": 1, "click_events": true, "cont_signal": 18, "stop_signal": 19}'
echo '['
echo '[]'

get_date() {
	time=$(date "+%a %b %e %T")
	echo -n '{"name":"id_time", "min_width":140, "full_text":"'$time'"},'
}

get_ip() {
	if [[ $(cat /tmp/ip.txt) -eq 1 ]]; then
		ip_addr=$(dig +short myip.opendns.com @resolver1.opendns.com)
	else
		ip_addr=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d'/')
	fi
	echo -n '{"name":"id_network", "min_width":25, "full_text":"'$ip_addr'"},'
}

# Launch in background to update status line
(while :;
do
	echo -n ",["
	get_date
	get_ip
	echo -n '{"name":"id_cpu", "background":"#283593", "full_text":"'$(~/.config/sway/modules/cpu.py)'%"},'
	~/.config/sway/modules/spotify.sh
	~/.config/sway/modules/storage.sh
	~/.config/sway/modules/weather.sh
	echo -n "]"
	sleep 1
done ) &

ip_cmd=1
echo $ip_cmd > /tmp/ip.txt

# Listen for STDIN events
while read line;
do
	echo $line > /tmp/tmp.txt
	# DATE click
	if [[ $line == *"name"*"id_time"* ]]; then
		termite -e ~/.config/sway/modules/click_time.sh &

	# IP Address click
	elif [[ $line == *"name"*"id_network"* ]]; then
		ip_cmd=$((1-ip_cmd))
		echo $ip_cmd > /tmp/ip.txt

	# CPU click
	elif [[ $line == *"name"*"id_cpu"* ]]; then
		termite -e htop &
	fi
done
