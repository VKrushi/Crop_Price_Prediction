import 'package:flutter/material.dart';
import 'package:frontend/view/widgets/feature_tile.dart';

import 'package:frontend/view/widgets/mobile_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List featureList = [
    {
      'title': 'Crop Price Predictor',
      'image': Image.asset(
        'assets/images/price_prediction.png',
        fit: BoxFit.fill,
      ),
      'onTap': () {},
    },
    {
      'title': 'Crop Recommendation System',
      'image': Image.asset(
        'assets/images/crop_recommendation.png',
        fit: BoxFit.fill,
      ),
      'onTap': () {},
    },
    {
      'title': 'Profit Calculator',
      'image': Image.asset(
        'assets/images/profit_calculator.png',
        fit: BoxFit.fill,
      ),
      'onTap': () {},
    },
  ];

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
            ListView.builder(
              shrinkWrap: true,
              itemCount: featureList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return FeatureTile(
                  title: featureList[index]['title'],
                  onTap: featureList[index]['onTap'],
                  image: featureList[index]['image'],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
