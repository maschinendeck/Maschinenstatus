import socket, datetime

def beatsTime():
    utcPlus1 = datetime.datetime.utcnow() + datetime.timedelta(hours = 1)
    beats = (utcPlus1.second + utcPlus1.minute * 60 + utcPlus1.hour * 3600) / 86.4
    return(beats)

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.sendto('beats/time/set:%d' % beatsTime(), ('127.0.0.1', 4444))
