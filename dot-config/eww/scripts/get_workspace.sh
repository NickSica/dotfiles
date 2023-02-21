#!/bin/bash

get_workspaces() {
workspaces=$(swaymsg --raw -t get_workspaces)
nums=$(echo $workspaces | jq '.[].num')
w=("00" "00" "00" "00" "00" "00" "00" "00" "00")
for i in {0..8}; do
    focused=$(echo $workspaces | jq '.['$i'].focused')
    num=$(echo $workspaces | jq '.['$i'].num')
    if [ $num == "null" ] || [ $num == -1 ]; then
        continue
    fi

    if [[ $nums =~ $num ]]; then
        w[$num]="1"
    else
        continue
    fi

    if [ $focused == "true" ]; then
        w[$num]=${w[$num]}"1"
    else
        w[$num]=${w[$num]}"0"
    fi
done
echo "(box :class \"workspaces\" :orientation \"h\" :space-evenly true :halign \"start\" :spacing 15 (button :class \""${w[1]}"\" :onclick \"sway workspace 1:term\"  (label :text \"\")) (button :class \""${w[2]}"\" :onclick \"sway workspace 2:code\"  (label :text \"\")) (button :class \""${w[3]}"\" :onclick \"sway workspace 3:work\"  (label :text \"\")) (button :class \""${w[4]}"\" :onclick \"sway workspace 4:web\"   (label :text \"\")) (button :class \""${w[5]}"\" :onclick \"sway workspace 5:music\" (label :text \"\")) (button :class \""${w[6]}"\" :onclick \"sway workspace 6:docs\"  (label :text \"\")) (button :class \""${w[7]}"\" :onclick \"sway workspace urgent\"  (label :text \"\")) (button :class \""${w[8]}"\" :onclick \"sway workspace focused\" (label :text \"\")) (button :class \""${w[9]}"\" :onclick \"sway workspace default\" (label :text \"\")))"

}

get_workspaces

swaymsg -t subscribe -m '[ "workspace" ]' | while read -r _; do
    get_workspaces
done
