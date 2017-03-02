import datetime, mete

def main():
    mate = mete.MateKasse('http://mate.fftr:3000/')

    startOfMonth = datetime.datetime.now().replace(day=1)
    tomorrow = datetime.datetime.now() + datetime.timedelta(days=1)
    caff = mate.caffeineUsage(startOfMonth, tomorrow)
    print caff


if __name__ == "__main__":
    main()
