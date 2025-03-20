import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SchemesTile extends StatelessWidget {
  final String schemeTitle;
  final String schemeUrl;
  const SchemesTile({
    super.key,
    required this.schemeTitle,
    required this.schemeUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(schemeTitle),
      onTap: () async {
        Uri uri = Uri.parse(schemeUrl);
        await launchUrl(uri);
      },
    );
  }
}
