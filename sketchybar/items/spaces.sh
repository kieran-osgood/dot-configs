#!/bin/sh

#SPACE_ICONS=("1" "2" "3" "4")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sketchybar --add event aerospace_workspace_change
#echo $(aerospace list-workspaces --monitor 1 --visible no --empty no) >> ~/aaaa

for m in $(aerospace list-monitors | awk '{print $1}'); do
  for i in $(aerospace list-workspaces --monitor $m); do
    if [ "$i" -eq "1" ]; then display="2"; else display="1"; fi

    space=(
      space="$i"
      icon="$i"
      icon.highlight_color=$RED
      icon.padding_left=10
      icon.padding_right=10
      display=$display
      padding_left=2
      padding_right=2
      label.padding_right=20
      label.color=$GREY
      label.highlight_color=$WHITE
      label.font="sketchybar-app-font:Regular:16.0"
      label.y_offset=-1
      background.color=$BACKGROUND_1
      background.border_color=$BACKGROUND_2
      script="$PLUGIN_DIR/space.sh"
    )

    # echo space[@] >> ~/aaaa
    sketchybar --add space space.$i left \
               --set space.$i "${space[@]}" \
               --subscribe space.$i mouse.clicked

    apps=$(aerospace list-windows --workspace $i | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

    # sets up the app icons for each aerospace workspace
    icon_strip=" "
    if [ "${apps}" != "" ]; then
      while read -r app
      do
        icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
      done <<< "${apps}"
    else
      icon_strip=" —"
    fi

    sketchybar --set space.$i label="$icon_strip"
  done

  for a in $(aerospace list-workspaces --monitor $m --empty); do
    sketchybar --set space.$a display=0
  done

done


space_creator=(
  icon=􀆊
  icon.font="$FONT:Heavy:16.0"
  padding_left=10
  padding_right=8
  label.drawing=off
  display=active
  script="$PLUGIN_DIR/space_windows.sh"
  # script="$PLUGIN_DIR/aerospace.sh"
  icon.color=$WHITE
)

sketchybar --add item space_creator left               \
           --set space_creator "${space_creator[@]}"   \
           --subscribe space_creator aerospace_workspace_change
