#!/bin/bash

# HDMIポート名（環境に合わせて変更）
HDMI_NAME="HDMI-A-1"
INTERNAL_NAME="eDP-1"

# ワークスペース番号（拡張モードでHDMI側に移す）
EXT_WS=2

# 現在の接続状態を確認
MONITORS=$(hyprctl monitors -j)
HDMI_CONNECTED=$(echo "$MONITORS" | grep "$HDMI_NAME")

STATE_FILE="/tmp/hypr_hdmi_mode"



# モード切り替えを判定：HDMIが既に拡張されている場合はミラーに戻す
if [[ -f "$STATE_FILE" && $(cat "$STATE_FILE") == "extend" ]]; then
    #hyprctl keyword monitor "$HDMI,preferred,auto,1"
    #WS_ID=$(hyprctl activeworkspace -j | jq '.id')
    #hyprctl dispatch moveworkspacetomonitor "$WS_ID $HDMI_NAME"
    echo "to mirror mode"
    hyprctl keyword monitor "$HDMI_NAME,preferred,0x0,1,mirror,$INTERNAL_NAME"
    echo "mirror">"$STATE_FILE"

else
    echo "to extended mode"
    hyprctl keyword monitor "$HDMI_NAME,preferred,0x-1080,1"
    sleep 0.2
    hyprctl dispatch moveworkspacetomonitor "$EXT_WS $HDMI_NAME"
    echo "extend">"$STATE_FILE"
fi
