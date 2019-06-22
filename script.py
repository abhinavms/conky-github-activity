import requests
from lxml import html
from datetime import datetime

def user(user):
    page = requests.get('https://github.com/'+ user)
    tree = html.fromstring(page.content)

    # Getting Year Links
    stack =tree.xpath('//a[starts-with(@class, "js-year-link")] /@href')

    day=False
    # Reverse iterate each years
    for iter in range(len(stack)):
        day = year(stack[iter])
        if(day):
            return day
        else:
            return 0

# Create log of contritubtions
def year(string):
    page = requests.get('https://github.com/'+ string)
    tree = html.fromstring(page.content)
  
    #This will create a list of data and count
    date = tree.xpath('//rect[@class="day"]/@data-date')
    count = tree.xpath('//rect[@class="day"]/@data-count')
          
    # Appending days when contributions are made
    i = len(count)-1;
    while (i >= 0):
        if count[i] != '0':
            return date[i]
        i = i-1


username = "abhinavms" # <----- Change your username here 

# Calculating the days between the last contribution and present day
LastActivity = datetime.strptime(user(username), "%Y-%m-%d")
TimeInactive = datetime.now() - LastActivity
print("{:02}".format(TimeInactive.days))
