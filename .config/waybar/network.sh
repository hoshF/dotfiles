#!/bin/bash

nmcli device wifi rescan >/dev/null

wifi_list=$(nmcli -t -f SSID,SIGNAL device wifi list | \
grep -v '^$' | \
awk -F ':' 'length($1)>0 {print $2 ":" $1}' | \
sort -t ':' -k1,1nr | \
head -n 15 | \
cut -d ':' -f2)

[[ -z "$wifi_list" ]] && {
    notify-send "Wi-Fi" "未找到任何 Wi-Fi 网络"
    exit 1
}

selected_ssid=$(echo "$wifi_list" | wofi --dmenu --prompt "选择 Wi-Fi 网络")

if [[ -z "$selected_ssid" ]]; then
    notify-send "Wi-Fi" "取消选择"
    exit 0
fi

password=$(wofi --dmenu  --password --prompt "输入 [$selected_ssid] 密码" --width 300 --height 50)

if nmcli connection show "$selected_ssid" &>/dev/null; then
    nmcli connection delete "$selected_ssid" &>/dev/null
fi

if nmcli device wifi connect "$selected_ssid" password "$password"; then
    notify-send "Wi-Fi" "已成功连接到 $selected_ssid"
else
    notify-send "Wi-Fi" "连接到 $selected_ssid 失败"
fi
