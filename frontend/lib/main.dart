import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controller/api/crop_price_prediction_api.dart';
import 'package:frontend/controller/api/crop_recommendation_api.dart';
import 'package:frontend/controller/api/govt_schemes_api.dart';
import 'package:frontend/controller/api/latest_news_api.dart';
import 'package:frontend/controller/providers/auth_state_provider.dart';
import 'package:frontend/controller/providers/expense_benefit_provider.dart';
import 'package:frontend/firebase_options.dart';
import 'package:frontend/view/constants/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthStateProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CropRecommendationApi(),
        ),
        ChangeNotifierProvider(
          create: (context) => CropPricePredictionApi(),
        ),
        ChangeNotifierProvider(
          create: (context) => LatestNewsApi(),
        ),
        ChangeNotifierProvider(
          create: (context) => GovtSchemesApi(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExpenseBenefitProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        routes: routes,
        initialRoute: homeScreenRoute,
      ),
    );
  }
}
