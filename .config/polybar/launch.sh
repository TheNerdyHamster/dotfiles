#!/bin/sh
#!/bin/bash

# Kill all polybar instaces
killall -q polybar

# Wait until polybar has been shutdown
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar panel 2> $HOME/.config/polybar/log.txt &
echo "Polybar got launcher"
