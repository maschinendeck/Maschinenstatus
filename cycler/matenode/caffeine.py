import datetime, mete, socket

def main():
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    mate = mete.MateKasse('http://mate.fftr:3000/')

    startOfMonth = datetime.datetime.now().replace(day=1)
    startOfDay = datetime.datetime.now().replace(hour=0,minute=0,second=0)
    tomorrow = datetime.datetime.now() + datetime.timedelta(days=1)

    caffd = mate.caffeineUsage(startOfDay, tomorrow)
    sock.sendto('Maschinenstatus/cycler/matenode/caffeine_day/set:%s' % caffd, ('127.0.0.1', 4444))

    caffm = mate.caffeineUsage(startOfMonth, tomorrow)
    sock.sendto('Maschinenstatus/cycler/matenode/caffeine_month/set:%s' % caffm, ('127.0.0.1', 4444))


if __name__ == "__main__":
    main()
