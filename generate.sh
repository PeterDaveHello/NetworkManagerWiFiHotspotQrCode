#!/bin/sh -e

config="$(ls -t /etc/NetworkManager/system-connections/Hotspot*.nmconnection | head -n 1)"

ID="$(sudo grep 'ssid=' "$config" | awk -F '=' '{print $2}')"
PW="$(sudo grep 'psk=' "$config" | awk -F '=' '{print $2}')"

echo "Wi-Fi SSID: $ID, PASSWORD: $PW"
qrencode -m 2 -t UTF8 -l M -s 18 "WIFI:T:WPA;S:${ID};P:${PW};;"
echo

if [ -n "$XDG_CURRENT_DESKTOP" ] && command -v xdg-open > /dev/null; then
    TMP="$(mktemp --suffix=.png)"
    qrencode -m 2 -t PNG -l M -s 18 "WIFI:T:WPA;S:${ID};P:${PW};;" -o "$TMP"
    xdg-open "$TMP"
fi
