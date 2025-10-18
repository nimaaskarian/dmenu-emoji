#!/bin/sh
tmp=$(mktemp)
cat user_emoji.txt | awk '{print $NF}' > $tmp
jq  --raw-output '.[] | (.description + "," + .emoji)'|grep -v ',$'|awk 'gsub(",", sprintf("%*s", 50 - length($0), ""))' | grep -v -f $tmp
rm $tmp
