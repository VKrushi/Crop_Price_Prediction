from firebase_functions import https_fn,options
from firebase_admin import initialize_app
import pickle
import json
import numpy as np
from sklearn.preprocessing import MinMaxScaler
from sklearn.ensemble import RandomForestClassifier
from statsmodels.tsa.statespace.sarimax import SARIMAX
import pandas as pd
import requests
from bs4 import BeautifulSoup

initialize_app()

@https_fn.on_request(
    cors=options.CorsOptions(
        cors_origins=[r"firebase\.com$", r"https://flutter\.com"],
        cors_methods=["get", "post"],
    )
)
def on_request_recommendation(req: https_fn.Request) -> https_fn.Response:

    req = json.loads(req.data)

    N = req['N']
    temperature = req['temperature']
    humidity = req['humidity']
    ph = req['ph']
    rainfall = req['rainfall']

    model = pickle.load(open('models/Recommendation/rfc_model.pkl','rb'))
    ms = pickle.load(open('models/Recommendation/minmaxscaler.pkl','rb'))

    features = np.array([[N,temperature,humidity,ph,rainfall]])
    transformed_features = ms.fit_transform(features)
    prediction = model.predict(transformed_features)

    crop_dict = {1: "Rice", 2: "Maize", 3: "Jute", 4: "Cotton", 5: "Coconut", 6: "Papaya", 7: "Orange", 8: "Apple", 9: "Muskmelon", 10: "Watermelon", 11: "Grapes", 12: "Mango", 13: "Banana", 14: "Pomegranate", 15: "Lentil", 16: "Blackgram", 17: "Mungbean", 18: "Mothbeans", 19: "Pigeonpeas", 20: "Kidneybeans", 21: "Chickpea", 22: "Coffee"}

    return https_fn.Response(crop_dict[prediction[0]])

@https_fn.on_request(
    cors=options.CorsOptions(
        cors_origins=[r"firebase\.com$", r"https://flutter\.com"],
        cors_methods=["get", "post"],
    )
)
def on_request_prediction(req: https_fn.Request) -> https_fn.Response:

    req = json.loads(req.data)

    crop = req['crop']

    model = pickle.load(open(f'models/PricePrediction/{crop}.pkl','rb'))

    forecast_sarima = model.get_forecast(steps=12)
    forecast_sarima_mean = forecast_sarima.predicted_mean
    
    return forecast_sarima_mean.to_json(orient='records')

@https_fn.on_request()
def on_request_schemes(req: https_fn.Request) -> https_fn.Response:
    url1 = "https://agriwelfare.gov.in/en/Major"
    url2 = "https://www.maharashtra.gov.in/Site/1604/scheme"

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

    df = pd.DataFrame(scheme_dict.items(),columns=['Title','Link'])
    
    return df.to_json(orient='records')