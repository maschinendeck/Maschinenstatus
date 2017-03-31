#!/bin/bash

# Start scripts to update the nodes

python clock/clock.py &
python toggle_display.py &
python cycler/mpd/mpdclient.py &
./hourly.sh
./every5min.sh

