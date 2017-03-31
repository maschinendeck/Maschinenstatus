import socket, datetime
import time;

def beatsTime():
    utc1 = datetime.datetime.utcnow() + datetime.timedelta(hours = 1)
    beats = (utc1.second + utc1.minute * 60 + utc1.hour * 3600) / 86.4
    beatsStr = str(int(round(beats)))
    beatsStr = '0' * (3 - len(beatsStr)) + beatsStr
    if beatsStr == '001':
        beatsStr = '@ ' + beatsStr + ' .beat'
    else:
        beatsStr = '@ ' + beatsStr + ' .beats'
    return(beatsStr)

def humanTime():
    return(datetime.datetime.now().strftime("%H:%M"))
    


sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
while 1:
    sock.sendto('Maschinenstatus/clock/beats/set:%s' % beatsTime(),\
        ('127.0.0.1', 4444))
    sock.sendto('Maschinenstatus/clock/time/set:%s' % humanTime(),\
        ('127.0.0.1', 4444))
    time.sleep(10)
    
