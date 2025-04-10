!/usr/bin/env bash

killall -q polybar

# Launch bar
echo "---" | tee -a /tmp/polybar1.log
polybar main 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Bars launched..."
