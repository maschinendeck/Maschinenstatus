import socket, re
from os import listdir
from mpd import MPDClient
from shutil import copyfile

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
client = MPDClient()
client.connect('maschinenpi.fftr',6600)

musicDir = "/home/pi/Music/"

while 1:
    response = client.status()
    status = response['state']
    sock.sendto('Maschinenstatus/cycler/mpd/status/set:%s' % status, ('127.0.0.1', 4444))
    print("sending status :" + status)

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
        if ('album' in song):
            album = song['album']
        else:
            album = "unknown"
        sock.sendto('Maschinenstatus/cycler/mpd/title/set:%s' % title, ('127.0.0.1', 4444))
        print("sending title :" + title)
        sock.sendto('Maschinenstatus/cycler/mpd/artist/set:%s' % artist, ('127.0.0.1', 4444))
        print("sending artist :" + artist)
        sock.sendto('Maschinenstatus/cycler/mpd/album/set:%s' % album, ('127.0.0.1', 4444))
        print("sending album :" + album)
        if musicDir:
            path = musicDir + re.search('.*/',song['file']).group(0)
            cover = False
            for p in listdir(path):
                if p in ['cover.jpg','Cover.jpg']:
                    copyfile(path + p, 'cycler/mpd/cover.jpg')
                    print("cover found: " + path + p)
                    cover = True
            if not cover:
                copyfile('cycler/mpd/nocover.jpg', 'cycler/mpd/cover.jpg')

    client.idle()
