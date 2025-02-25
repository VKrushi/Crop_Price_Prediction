import 'package:flutter/material.dart';
import 'package:frontend/controller/providers/language_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(value.appCurrentLanguage),
        ),
        body: Column(
          children: [
            RadioListTile(
              title: const Text("English"),
              value: "English",
              groupValue: value.appCurrentLanguage,
              onChanged: (language) =>
                  value.changeLanguage(language: language!),
            ),
            RadioListTile(
              title: const Text("मराठी"),
              value: "Marathi",
              groupValue: value.appCurrentLanguage,
              onChanged: (language) =>
                  value.changeLanguage(language: language!),
            ),
          ],
        ),
      ),
    );
  }
}
