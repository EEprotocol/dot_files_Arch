#!/bin/bash

# 使用中のワークスペース番号の最大値を取得
last_used=$(hyprctl workspaces -j | jq '.[].id' | sort -n | tail -1)

# 次の未使用ワークスペースにジャンプ
next_ws=$((last_used + 1))
hyprctl dispatch workspace "$next_ws"
