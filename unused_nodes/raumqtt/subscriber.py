#!/usr/bin/env python
import paho.mqtt.client as mqtt
import socket, json

def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))
    for topic in userdata.keys():
        client.subscribe(topic)

def on_message(client, userdata, msg):
    userdata[msg.topic](msg.payload)
    print(msg.topic + " " + str(msg.payload))

def on_raumstatus(status):
    send_to_infobeamer("status",status)

def on_clients(clients):
    c = json.loads(clients)
    wireless = c[u'wireless']
    total = c[u'total']
    send_to_infobeamer("clients_w",wireless)
    send_to_infobeamer("clients_t",total)

def send_to_infobeamer(var, msg):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.sendto('Maschinenstatus/cycler/raumqtt/%s/set:%s' % (var,msg),\
                ('127.0.0.1', 4444))
    


topics = {  "/maschinendeck/raum/status"    : on_raumstatus,
            "/maschinendeck/raum/clients"   : on_clients }

client = mqtt.Client(userdata=topics)
client.on_connect = on_connect
client.on_message = on_message

client.connect("mqtt.starletp9.de", 1883, 60)

client.loop_forever()
