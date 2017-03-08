#!/usr/bin/env python
import paho.mqtt.client as mqtt
import socket, json
from subprocess import call

def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))
    client.subscribe("/maschinendeck/raum/status")

def on_message(client, userdata, msg):
    status = msg.payload
    if status == "closed":
        call(["tvservice","-o"])
        print "closed"
    elif status == "open":
        call(["tvservice","-p"])
        print "open"
    else:
        print "unknown"


client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

client.connect("mqtt.starletp9.de", 1883, 60)

client.loop_forever()
