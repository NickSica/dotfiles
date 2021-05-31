#!/bin/sh

time=$(date "+%a %b %e %T")
echo -n '{"name": "id_time", "min_width":140, "full_text":"'$time'"},'

ip_addr=$(dig +short myip.opendns.com @resolver1.opendns.com)
echo -n '{"name": "id_network", "min_width":25, "full_text":"'$ip_addr'"},'
