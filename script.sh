copy_emoji() {
  if [ -n "$EMOJI" ]; then
    printf "%s" "$EMOJI"
  else
    awk '{printf "%s", $NF}'
  fi | xclip -selection c
}

insert_emoji() {
  echo "$WINDOW" "$EMOJI"
  xdotool type --delay 300 --window "$WINDOW" --clearmodifiers "$EMOJI"
}

set_emoji_and_window() {
  WINDOW=$(xdotool getactivewindow)
  EMOJI=$(print_emojis | dmenu -p 'Emoji: ' "$@" | awk '{printf "%s", $NF}') || exit 1
}

case "$1" in
  "list")
    print_emojis
    ;;
  "copy")
    copy_emoji
    ;;
  "insert/copy")
    shift
    set_emoji_and_window "$@"
    insert_emoji
    copy_emoji
    ;;
  "insert")
    shift
    set_emoji_and_window "$@"
    insert_emoji
    ;;
  *)
    print_emojis | dmenu -p 'Emoji: ' "$@" | copy_emoji
    ;;
esac
