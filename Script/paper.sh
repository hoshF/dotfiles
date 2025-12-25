#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <source_file>"
    exit 1
fi

SOURCE_FILE="$1"
DEST_DIR="$HOME/.config/hypr/wallpapers"
MODIFY_FILE="$HOME/.config/hypr/hyprpaper.conf"

# 确保目标目录存在
mkdir -p "$DEST_DIR"

# 复制文件
cp "$SOURCE_FILE" "$DEST_DIR/"
if [ $? -ne 0 ]; then
    echo "Failed to copy file!"
    exit 2
fi
echo "File copied to $DEST_DIR"

# 只取文件名
BASENAME=$(basename "$SOURCE_FILE")

# 生成 hyprpaper 配置
cat > "$MODIFY_FILE" <<EOF
preload = $DEST_DIR/$BASENAME
wallpaper = ,$DEST_DIR/$BASENAME
EOF

echo "File $MODIFY_FILE modified"

# 杀掉 hyprpaper 进程
pkill hyprpaper && hyprctl reload
if [ $? -eq 0 ]; then
    echo "hyprpaper process killed"
else
    echo "No hyprpaper process found"
fi

