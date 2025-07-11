
#!/bin/bash

# 依存: jq

# 現在使用されているワークスペースのIDを昇順で取得
workspace_ids=($(hyprctl workspaces -j | jq '.[].id' | sort -n))

# 対応表: 元のワークスペース -> 新しいワークスペース
declare -A ws_map
new_id=1
for old_id in "${workspace_ids[@]}"; do
    ws_map[$old_id]=$new_id
    new_id=$((new_id + 1))
done

# クライアント（ウィンドウ）ごとに移動
clients=$(hyprctl clients -j)

echo "$clients" | jq -c '.[]' | while read -r client; do
    win_addr=$(echo "$client" | jq -r '.address')
    old_ws=$(echo "$client" | jq -r '.workspace.id')
    new_ws=${ws_map[$old_ws]}

    if [[ "$old_ws" != "$new_ws" ]]; then
        hyprctl dispatch movetoworkspacesilent "$new_ws,address:$win_addr"
    fi
done
