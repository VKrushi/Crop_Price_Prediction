import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:frontend/view/screens/auth/login_screen.dart';
import 'package:frontend/view/screens/auth/profile_creation_screen.dart';
import 'package:frontend/view/screens/home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('UserDetails')
                  .doc(snapshot.data!.phoneNumber)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.data!.exists) {
                    return const HomeScreen();
                  } else {
                    return const ProfileCreationScreen();
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            );
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
