copy_emoji() {
  awk '{printf "%s", $NF}' | xclip -selection c
  command -v notify-send > /dev/null && notify-send -t 200 "$emoji copied!"
}

case "$1" in
  "list")
    print_emojis
    ;;
  "copy")
    copy_emoji
    ;;
  "")
    print_emojis | dmenu -p 'Emoji: ' | copy_emoji
    ;;
esac
