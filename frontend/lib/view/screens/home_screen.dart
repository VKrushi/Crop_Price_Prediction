import 'package:flutter/material.dart';
import 'package:frontend/controller/api/govt_schemes_api.dart';
import 'package:frontend/controller/api/latest_news_api.dart';
import 'package:frontend/view/constants/enums.dart';
import 'package:frontend/view/constants/routes.dart';
import 'package:frontend/view/widgets/feature_tile.dart';

import 'package:frontend/view/widgets/mobile_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void onClickLatestNews(BuildContext context) async {
    final provider = Provider.of<LatestNewsApi>(context, listen: false);
    if (provider.newsApiState != ApiState.succesful) {
      provider.getNews();
    }

    Navigator.pushNamed(context, latestNewsScreenRoute);
  }

  void onClickGovtSchemes(BuildContext context) async {
    final provider = Provider.of<GovtSchemesApi>(context, listen: false);
    if (provider.schemeApiState != ApiState.succesful) {
      provider.getSchemes();
    }

    Navigator.pushNamed(context, govtSchemesScreenRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: MobileDrawer(
        onClickLatestNews: () => onClickLatestNews(context),
        onClickGovtSchemes: () => onClickGovtSchemes(context),
      ),
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
                    cropPricePredictionScreenRoute,
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
                    profitCalculatorScreenRoute,
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
