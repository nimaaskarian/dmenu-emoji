copy_emoji() {
  awk '{printf "%s", $NF}' | xclip -selection c
}

case "$1" in
  "list")
    print_emojis
    ;;
  "copy")
    copy_emoji
    ;;
  *)
    print_emojis | dmenu -p 'Emoji: ' "$@" | copy_emoji
    ;;
esac
