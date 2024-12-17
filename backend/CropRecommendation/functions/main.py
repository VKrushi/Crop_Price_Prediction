# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
# Deploy with `firebase deploy`

from firebase_functions import https_fn,options
from firebase_admin import initialize_app
import pickle
import json
import numpy as np
from sklearn.preprocessing import MinMaxScaler
from sklearn.ensemble import RandomForestClassifier

initialize_app()

@https_fn.on_request(
    cors=options.CorsOptions(
        cors_origins=[r"firebase\.com$", r"https://flutter\.com"],
        cors_methods=["get", "post"],
    )
)
def on_request_example(req: https_fn.Request) -> https_fn.Response:

    req = json.loads(req.data)

    N = req['N']
    temperature = req['temperature']
    humidity = req['humidity']
    ph = req['ph']
    rainfall = req['rainfall']

    model = pickle.load(open('rfc_model.pkl','rb'))
    ms = pickle.load(open('minmaxscaler.pkl','rb'))

    features = np.array([[N,temperature,humidity,ph,rainfall]])
    transformed_features = ms.fit_transform(features)
    prediction = model.predict(transformed_features)

    crop_dict = {1: "Rice", 2: "Maize", 3: "Jute", 4: "Cotton", 5: "Coconut", 6: "Papaya", 7: "Orange", 8: "Apple", 9: "Muskmelon", 10: "Watermelon", 11: "Grapes", 12: "Mango", 13: "Banana", 14: "Pomegranate", 15: "Lentil", 16: "Blackgram", 17: "Mungbean", 18: "Mothbeans", 19: "Pigeonpeas", 20: "Kidneybeans", 21: "Chickpea", 22: "Coffee"}

    return https_fn.Response(crop_dict[prediction[0]])