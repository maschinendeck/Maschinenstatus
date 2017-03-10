import requests, json
from datetime import datetime

args = {    'todayWindowNegative' : 0,
            'todayWindowPositive' : 40 }
url = 'http://wiki.maschinendeck.org/kalender-json.php'

r = requests.get(url)
events = json.loads(r.content)[u'results']

eventList = [{  'timestamp' : int(v[u'printouts'][u'start'][0][u'timestamp']),
                'title'     : v[u'fulltext'],
                'location'  : v[u'printouts'][u'location'][0][u'fulltext'] }
            for v in events.values()
            if (len(v[u'printouts'][u'summary']) == 0) ] # non-regular events only

# only events that are in the future. Remove this if the API works correctly
import time
eventList = [x for x in eventList if x['timestamp'] > int(time.time()) ]

# Add human readable time
for e in eventList:
    dt = datetime.fromtimestamp(e['timestamp'])
    e.update({  'date'  : dt.strftime('%d.%m.%Y'),
                'time'  : dt.strftime('%H:%M')  })


            
sortedList = sorted(eventList, key=lambda k: k['timestamp'])

out = json.dumps(sortedList[:2], ensure_ascii=False).encode("utf8")
file("events.json", "wb").write(out)

                
