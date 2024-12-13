import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controller/api/crop_recommendation_api.dart';
import 'package:frontend/controller/providers/auth_state_provider.dart';
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
