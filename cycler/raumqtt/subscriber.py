#!/usr/bin/env python
import paho.mqtt.client as mqtt
import socket

def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))

    client.subscribe("/maschinendeck/raum/status")

def on_message(client, userdata, msg):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.sendto('Maschinenstatus/cycler/raumqtt/status/set:%s' % msg.payload,\
                ('127.0.0.1', 4444))
    print(msg.topic + " " + str(msg.payload))

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

client.connect("mqtt.starletp9.de", 1883, 60)

client.loop_forever()
