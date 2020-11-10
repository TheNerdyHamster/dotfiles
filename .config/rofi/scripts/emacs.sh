#!/bin/bash

selected=$(echo "hamster
doom
spacemacs" | rofi -dmenu -p "Emacs")
if [ -n "$selected" ]; then
   emacs --with-profile $selected
fi
