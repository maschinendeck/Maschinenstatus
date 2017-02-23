import socket
from mpd import MPDClient

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
client = MPDClient()
client.connect('maschinenpi.fftr',6600)
#client.connect('localhost',6600)

while 1:
    response = client.status()
    status = response['state']
    sock.sendto('mpd/status/set:%s' % status, ('127.0.0.1', 4444))

    if status in ['play', 'pause']:
        songID = int(response['songid'])
        song = client.playlistid(songID)[0]
        if ('title' in song):
            title = song['title']
        else:
            title = "unknown"
        if ('artist' in song):
            artist = song['artist']
        else:
            artist = "unknown"
        sock.sendto('mpd/title/set:%s' % title, ('127.0.0.1', 4444))
        sock.sendto('mpd/artist/set:%s' % artist, ('127.0.0.1', 4444))

    print(status)
    client.idle()
