import requests
from bs4 import BeautifulSoup

url1 = "https://agriwelfare.gov.in/en/Major"
url2 = "https://www.maharashtra.gov.in/Site/1604/scheme"

def extractData(url1,url2):
    scheme_dict = {}

    data1 = requests.get(url1,verify=False)
    soup1 = BeautifulSoup(data1.content,'html.parser')

    table_body = soup1.find('tbody')
    rows = table_body.find_all('tr')

    for row in rows:
        title = row.find_all('td')[1].text
        site_url = row.find_all('td')[-1].find_all('a')[-1]['href']

        if ".pdf" not in site_url:
            scheme_dict[title] = site_url
        else:
            scheme_dict[title] = f"https://agriwelfare.gov.in/{site_url}"

    data2 = requests.get(url2,verify=False)
    soup2 = BeautifulSoup(data2.content,'html.parser')
    schemeData = soup2.find_all('div',{"class": "pannel mt-3"})

    for scheme in schemeData:
        title = scheme.find('h3').text
        site_url = scheme.find('div',{"class": "w-100"}).find_all('p')[-1].find('a')['href']

        scheme_dict[title] = site_url

    # print(schemeData)

    return scheme_dict

print(extractData(url1,url2))