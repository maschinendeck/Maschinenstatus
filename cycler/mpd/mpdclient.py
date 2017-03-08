import socket, re, time, os
from mpd import MPDClient
from shutil import copyfile

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
client = MPDClient()

connected = False
while not connected:
    try:
        client.connect('maschinenpi.fftr',6600)
        connected = True
    except:
        time.sleep(1)

musicDir = "/home/pi/Music/"

while 1:
    response = client.status()
    status = response['state']
    sock.sendto('Maschinenstatus/cycler/mpd/status/set:%s' % status, ('127.0.0.1', 4444))
    print("sending status :" + status)

    if status in ['play', 'pause']:
        songID = int(response['songid'])
        song = client.playlistid(songID)[0]

        title = artist = album = "unknown"
        if ('title' in song):
            title = song['title']
        if ('artist' in song):
            artist = song['artist']
        if ('album' in song):
            album = song['album']

        sock.sendto('Maschinenstatus/cycler/mpd/title/set:%s' % title, ('127.0.0.1', 4444))
        sock.sendto('Maschinenstatus/cycler/mpd/artist/set:%s' % artist, ('127.0.0.1', 4444))
        sock.sendto('Maschinenstatus/cycler/mpd/album/set:%s' % album, ('127.0.0.1', 4444))

        # look for covers
        if musicDir:
            path = musicDir + re.search('.*/',song['file']).group(0)
            cover = False
            if os.path.isdir(path):
                for p in os.listdir(path):
                    if p in ['cover.jpg','Cover.jpg']:
                        copyfile(path + p, 'cycler/mpd/cover.jpg')
                        print("cover found: " + path + p)
                        cover = True
            if not cover:
                copyfile('cycler/mpd/nocover.jpg', 'cycler/mpd/cover.jpg')

        # playback modes
        modes = ""
        options = ["repeat","random","consume","single"]
        for o in options:
            if response[o] == "1":
                modes += o + " "
        sock.sendto('Maschinenstatus/cycler/mpd/modes/set:%s' % modes, ('127.0.0.1', 4444))
        print ("sending modes" + modes)

    client.idle()
