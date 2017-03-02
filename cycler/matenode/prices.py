import mete

def printPrices(tupel):
    x = 30 - len(tupel[0])
    print tupel[0] + " " * x + tupel[1]

        

def main():
    mate = mete.MateKasse('http://mate.fftr:3000/')

    drinks = mate.getDrinks()
    names = [x[u'name'] for x in drinks]
    prices = [x[u'donation_recommendation'] for x in drinks]
    print "Preise (in Euro)"
    map(printPrices,zip(names,prices))


if __name__ == "__main__":
    main()
