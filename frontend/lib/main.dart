import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controller/api/chatbot_api.dart';
import 'package:frontend/controller/api/crop_price_prediction_api.dart';
import 'package:frontend/controller/api/crop_recommendation_api.dart';
import 'package:frontend/controller/api/govt_schemes_api.dart';
import 'package:frontend/controller/api/latest_news_api.dart';
import 'package:frontend/controller/providers/auth_state_provider.dart';
import 'package:frontend/controller/providers/expense_benefit_provider.dart';
import 'package:frontend/controller/providers/language_provider.dart';
import 'package:frontend/firebase_options.dart';
import 'package:frontend/view/constants/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
        ChangeNotifierProvider(
          create: (context) => LanguageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatbotApi(),
        ),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.deepPurple,
            ),
            useMaterial3: true,
          ),
          locale: value.appLanguage,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('mr'),
          ],
          routes: routes,
          initialRoute: authGateRoute,
        ),
      ),
    );
  }
}
