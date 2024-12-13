import 'package:flutter/material.dart';
import 'package:frontend/view/constants/routes.dart';
import 'package:frontend/view/widgets/feature_tile.dart';

import 'package:frontend/view/widgets/mobile_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: const MobileDrawer(),
      appBar: AppBar(
        title: const SearchBar(
          leading: Icon(Icons.search),
          constraints: BoxConstraints.expand(height: 32),
          hintText: 'Search',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Card(
                  elevation: 8,
                  shape: const CircleBorder(),
                  child: Container(
                    height: 128,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.amber,
                      image: DecorationImage(
                        image: Image.asset(
                          'assets/images/logo.png',
                        ).image,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Text(
              'App_Name',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                FeatureTile(
                  title: 'Crop Price Predictor',
                  onTap: () => Navigator.pushNamed(
                    context,
                    cropRecommendationScreenRoute,
                  ),
                  image: Image.asset(
                    'assets/images/price_prediction.png',
                    fit: BoxFit.fill,
                  ),
                ),
                FeatureTile(
                  title: 'Crop Recommendation System',
                  onTap: () => Navigator.pushNamed(
                    context,
                    cropRecommendationScreenRoute,
                  ),
                  image: Image.asset(
                    'assets/images/crop_recommendation.png',
                    fit: BoxFit.fill,
                  ),
                ),
                FeatureTile(
                  title: 'Profit Calculator',
                  onTap: () => Navigator.pushNamed(
                    context,
                    cropRecommendationScreenRoute,
                  ),
                  image: Image.asset(
                    'assets/images/profit_calculator.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
