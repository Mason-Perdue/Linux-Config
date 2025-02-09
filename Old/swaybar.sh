
# ./.config/sway/scripts/swaybar.sh
# must run chmod +x before swaybar can use it

volume=$(pamixer --get-volume-human)

date_time=$(date +'%Y-%m-%d %I:%M %p')

echo "$volume | $date_time "
