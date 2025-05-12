
#!/bin/bash

# uptime取得
uptime_sec=$(cut -d. -f1 /proc/uptime)
hours=$((uptime_sec / 3600))
minutes=$(( (uptime_sec % 3600) / 60 ))
seconds=$((uptime_sec % 60))
uptime_text=$(printf "%02d:%02d:%02d working" "$hours" "$minutes" "$seconds")

# 現在時刻
now=$(date '+%Y/%m/%d %a %H:%M:%S')

# JSON出力
echo "{\"text\":\"$now\", \"alt\":\" $uptime_text\"}"
