import 'package:flutter/material.dart';
import 'package:frontend/view/screens/auth/auth_gate.dart';
import 'package:frontend/view/screens/auth/profile_creation_screen.dart';
import 'package:frontend/view/screens/crop_price_prediction_screen.dart';
import 'package:frontend/view/screens/crop_recommendation_screen.dart';
import 'package:frontend/view/screens/govt_scheme_screen.dart';
import 'package:frontend/view/screens/home_screen.dart';
import 'package:frontend/view/screens/latest_news_screen.dart';
import 'package:frontend/view/screens/profile_screen.dart';
import 'package:frontend/view/screens/profit_calculator_screen.dart';

const authGateRoute = '/auth';
const homeScreenRoute = '/home';
const cropRecommendationScreenRoute = '/home/crop-recommendation-system';
const cropPricePredictionScreenRoute = '/home/crop-price-predictor';
const profitCalculatorScreenRoute = '/home/profit-calculator';
const latestNewsScreenRoute = '/home/news';
const govtSchemesScreenRoute = '/home/govt-schemes';
const profileScreenRoute = '/home/profile';
const profileCreationScreen = '/auth/profile';

Map<String, WidgetBuilder> routes = {
  authGateRoute: (context) => const AuthGate(),
  homeScreenRoute: (context) => const HomeScreen(),
  cropRecommendationScreenRoute: (context) => const CropRecommendationScreen(),
  cropPricePredictionScreenRoute: (context) =>
      const CropPricePredictionScreen(),
  latestNewsScreenRoute: (context) => const LatestNewsScreen(),
  govtSchemesScreenRoute: (context) => const GovtSchemeScreen(),
  profitCalculatorScreenRoute: (context) => const ProfitCalculatorScreen(),
  profileScreenRoute: (context) => const ProfileScreen(),
  profileCreationScreen: (context) => const ProfileCreationScreen(),
};
