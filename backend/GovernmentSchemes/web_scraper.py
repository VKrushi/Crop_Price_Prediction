import requests
from bs4 import BeautifulSoup

url = "https://agriwelfare.gov.in/en/Major"

def extractData(url):
    data = requests.get(url,verify=False)
    soup = BeautifulSoup(data.content,'html.parser')

    table_body = soup.find('tbody')
    rows = table_body.find_all('tr')

    scheme_dict = {}
    

    for row in rows:
        title = row.find_all('td')[1].text
        site_url = row.find_all('td')[-1].find_all('a')[-1]['href']

        if ".pdf" not in site_url:
            scheme_dict[title] = site_url

    return scheme_dict

print(extractData(url))