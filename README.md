# Maschinenstatus
### A statusscreen for our Hackerspace using info-beamer

This project uses [info-beamer](https://info-beamer.com/) do display status information.

It's (for now) grouped into a top and bottom node.
The top node displays the clock while the bottom node cycles between different nodes.

* clock -> display the time
* cycler -> cycle between nodes:
    * mpd -> display the current song from the mpd
    * raumqtt -> display information from MQTT (e.g. raumstatus, clients)


### Planned nodes:
* twitterwall -> display tweets by [@Maschinendeck\_](https://twitter.com/Maschinendeck_) and others.
* mate -> display prices of beverages and maybe some beverage related stats.
