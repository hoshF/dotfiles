#!/bin/bash

address=~/Notes/logs/
cd "$address" || exit 1

[ ! -f "SUMMARY.md" ] && echo -e "# Summary\n" > SUMMARY.md

for file in $(find . -maxdepth 1 -name "*.md" ! -name "SUMMARY.md" -type f | sort); do
    filename=$(basename "$file")
    filename_without_ext="${filename%.md}"
    grep -q "\[$filename_without_ext\](\./$filename)" "SUMMARY.md" || echo "- [$filename_without_ext](./$filename)" >> SUMMARY.md
done

echo "完成！"
