import 'package:flutter/material.dart';
import 'package:frontend/view/screens/auth/auth_gate.dart';
import 'package:frontend/view/screens/crop_recommendation_screen.dart';
import 'package:frontend/view/screens/home_screen.dart';

const authGateRoute = '/auth';
const homeScreenRoute = '/home';
const cropRecommendationScreenRoute = '/home/crop-recommendation';

Map<String, WidgetBuilder> routes = {
  authGateRoute: (context) => const AuthGate(),
  homeScreenRoute: (context) => const HomeScreen(),
  cropRecommendationScreenRoute: (context) => const CropRecommendationScreen(),
};
