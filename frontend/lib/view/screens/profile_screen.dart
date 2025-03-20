import 'package:flutter/material.dart';
import 'package:frontend/controller/providers/auth_state_provider.dart';
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
            Consumer<AuthStateProvider>(
              builder: (context, value, child) => FutureBuilder(
                future: value.getUserDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Text(snapshot.data!.username!)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'Location',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(snapshot.data!.userLocation),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Language',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
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
