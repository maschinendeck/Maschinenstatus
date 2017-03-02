import json, requests, datetime

class MateKasse():

    def __init__(self, url):
        self.url = url

    def getAudits(self, start, end):
        payload = { "start_date[year]"  : start.year,
                    "start_date[month]" : start.month,
                    "start_date[day]"   : start.day,
                    "end_date[year]"    : end.year,
                    "end_date[month]"   : end.month,
                    "end_date[day]"     : end.day }
        r = requests.get(self.url + 'audits.json', params=payload)
        audits = json.loads(r.text)
        return(audits[u'audits'])

    def getDrinks(self):
        r = requests.get(self.url + 'drinks.json')
        drinks = json.loads(r.text)
        return(drinks)

    def drinkCaffeine(self, drinks, drinkID):
        if drinkID == 0:
            return(0)
        drink = next(x for x in drinks if x[u'id'] == drinkID)
        caffeine = drink[u'caffeine'] * float(drink[u'bottle_size']) * 10
        return(caffeine)
        
    def caffeineUsage(self, start, end):
        audits = self.getAudits(start,end)
        drinks = self.getDrinks()
        caff = [self.drinkCaffeine(drinks,x[u'drink']) for x in audits]
        return(sum(caff))
