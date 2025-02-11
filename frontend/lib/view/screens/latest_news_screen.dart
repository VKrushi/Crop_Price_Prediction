import 'package:flutter/material.dart';
import 'package:frontend/controller/api/latest_news_api.dart';
import 'package:frontend/view/constants/enums.dart';
import 'package:frontend/view/widgets/news_tile.dart';
import 'package:provider/provider.dart';

class LatestNewsScreen extends StatefulWidget {
  const LatestNewsScreen({super.key});

  @override
  State<LatestNewsScreen> createState() => _LatestNewsScrennState();
}

class _LatestNewsScrennState extends State<LatestNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latest News'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<LatestNewsApi>(
              builder: (context, value, child) {
                switch (value.newsApiState) {
                  case ApiState.loading:
                    return const CircularProgressIndicator();
                  case ApiState.error:
                    return Text(
                      value.error!,
                      style: const TextStyle(color: Colors.red),
                    );
                  case ApiState.none:
                    return Container();
                  default:
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.news!.length,
                      itemBuilder: (context, index) {
                        return NewsTile(
                          imageUrl: value.news![index]['image_url'],
                          articleUrl: value.news![index]['link'],
                          headline: value.news![index]['title'],
                        );
                      },
                    );
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
