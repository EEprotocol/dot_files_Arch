#!/bin/bash

# 使用するタッチパッドデバイス名（xinput list で確認可能）
device_name="DELL0A20:00 06CB:CE65 Touchpad"

# デバイスIDを取得
id=$(xinput list --id-only "$device_name")

# 現在の状態を取得（0: 無効, 1: 有効）
state=$(xinput list-props "$id" | grep "Device Enabled" | awk '{print $4}')

# 切り替えと通知
if [ "$state" -eq 1 ]; then
    xinput disable "$id"
    notify-send "Touchpad Disabled"
else
    xinput enable "$id"
    notify-send "Touchpad Enabled"
fi
