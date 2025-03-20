String cropRecommendationPrompt = '''
You are a data Below are the crops and most suitable weather, soil and other factors for best cultivation and growth.
[
  {
    "crop": "Rice",
    "optimalTemperature": "22-32°C",
    "rainfallRequirement": "150-300 cm",
    "soilType": "Clayey loam or alluvial (water-retentive)",
    "seasonOtherFactors": "Mainly a Kharif crop; requires flooded or well-irrigated fields"
  },
  {
    "crop": "Wheat",
    "optimalTemperature": "10-25°C (cooler at sowing, warming later)",
    "rainfallRequirement": "75-100 cm",
    "soilType": "Well-drained loamy or sandy loam",
    "seasonOtherFactors": "Grown as a Rabi crop in temperate conditions"
  },
  {
    "crop": "Cotton",
    "optimalTemperature": "21-30°C",
    "rainfallRequirement": "50-100 cm",
    "soilType": "Black (regur) soil - rich in minerals and moisture-retentive",
    "seasonOtherFactors": "Kharif crop; benefits from warm, dry ripening conditions"
  },
  {
    "crop": "Sugarcane",
    "optimalTemperature": "20-30°C",
    "rainfallRequirement": "75-150 cm (often supplemented by irrigation)",
    "soilType": "Deep, fertile, well-drained soils (alluvial/black cotton)",
    "seasonOtherFactors": "Long-duration crop; needs ample water and a long growing period"
  },
  {
    "crop": "Maize",
    "optimalTemperature": "21-27°C",
    "rainfallRequirement": "50-100 cm (rainfed) or higher with irrigation",
    "soilType": "Loamy or alluvial soils",
    "seasonOtherFactors": "Versatile; grown in multiple seasons; moderately drought tolerant"
  },
  {
    "crop": "Pulses",
    "examples": ["Chickpea", "Pigeon pea"],
    "optimalTemperature": "20-27°C (varies)",
    "rainfallRequirement": "25-60 cm for chickpea; up to 100 cm for pigeon pea",
    "soilType": "Sandy loam or well-drained soils",
    "seasonOtherFactors": "Sown as Rabi (e.g., chickpea) or Kharif (e.g., pigeon pea) crops"
  },
  {
    "crop": "Millets",
    "examples": ["Bajra", "Jowar", "Ragi"],
    "optimalTemperature": "27-32°C (Bajra/Jowar) / 20-30°C (Ragi)",
    "rainfallRequirement": "Around 50-100 cm",
    "soilType": "Sandy, red, or lateritic soils",
    "seasonOtherFactors": "Drought tolerant; mostly Kharif crops; some varieties can be grown in Rabi"
  },
  {
    "crop": "Jute",
    "optimalTemperature": "24-35°C",
    "rainfallRequirement": "125-200 cm",
    "soilType": "Sandy or clay loam",
    "seasonOtherFactors": "Kharif crop thriving in tropical, humid conditions (e.g., West Bengal)"
  },
  {
    "crop": "Soybean",
    "optimalTemperature": "25-30°C",
    "rainfallRequirement": "Approximately 60-80 cm (can vary with irrigation)",
    "soilType": "Well-drained alluvial soils",
    "seasonOtherFactors": "Grown in the Kharif season; suited to warm, moderately wet conditions"
  },
  {
    "crop": "Tea",
    "optimalTemperature": "20-30°C",
    "rainfallRequirement": "150-300 cm",
    "soilType": "Acidic, well-drained, organically rich loamy soils",
    "seasonOtherFactors": "Cultivated in hilly areas under tropical to subtropical climates"
  }
]

Based on the details provided about the rainfall, weather, soil and location determine the most suitable crop for cultivization. For recommeding the crop use the above data for your reference.
Output should be in the following format:
1. Recommended Crop(Only one). If more than one are suitable just give most suitable.
2. Reasoning behind the recommendation.
''';

String chatGeneralPrompt = '''
You are a chatbot created for the purpose of serving as an assistant for Farmer and Agriculture Application. Give a short response not more than 4-5 lines.
''';
