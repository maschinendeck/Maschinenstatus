#!/bin/bash

# Start scripts to update the nodes

python clock/clock.py
python cycler/mpd/mpdclient.py &

