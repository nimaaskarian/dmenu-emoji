#!/bin/sh
tmp=$(mktemp)
json_csv=$(mktemp)
cat user_emoji.txt | cut -d ',' -f 2 > $tmp
jq  --raw-output '.[] | (.description + "," + .emoji)'|grep -v ',$'> $json_csv
max_length=$(cat $json_csv user_emoji.txt | cut -d ',' -f 1 | awk '{print length($0)}' | sort -r -n | head -n 1)
{
  cat user_emoji.txt
  grep -v -f $tmp $json_csv
} | awk 'gsub(",", sprintf("%*s", '"$max_length"' - length($0), ""))'
rm $tmp $json_csv
