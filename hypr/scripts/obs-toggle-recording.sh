#!/bin/bash
if pgrep -x obs > /dev/null; then
    obs-cmd --websocket obsws://localhost:4455 recording toggle
else
    obs &
    echo "OBS PID: $!"
    for i in $(seq 1 10); do
        echo "Attempt $i..."
        obs-cmd --websocket obsws://localhost:4455 recording start && break
        sleep 1
    done
fi
