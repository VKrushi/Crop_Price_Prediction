import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsTile extends StatelessWidget {
  final String articleUrl;
  final String headline;
  final String? imageUrl;
  const NewsTile({
    super.key,
    required this.headline,
    required this.articleUrl,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: imageUrl == null
          ? const Icon(
              Icons.newspaper,
              size: 40,
            )
          : Image.network(
              imageUrl!,
              width: 40,
            ),
      title: Text(headline),
      onTap: () async {
        Uri uri = Uri.parse(articleUrl);
        await launchUrl(uri);
      },
    );
  }
}
