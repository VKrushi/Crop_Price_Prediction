import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user.dart';
import '../../view/constants/enums.dart';

class AuthStateProvider extends ChangeNotifier {
  AuthState authState = AuthState.loggedOut;
  String? authException;
  String? verificationId;
  AppUser? user;
  bool showLoginScreen = true;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  verifyPhone({
    required String phone,
  }) async {
    phone = "+91$phone";
    try {
      authState = AuthState.loading;
      notifyListeners();

      await _firebaseAuth.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
          // print('verificationComplete');

          notifyListeners();
        },
        verificationFailed: (FirebaseAuthException error) {
          authState = AuthState.loggedOut;
          authException = error.message;
          notifyListeners();
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          authState = AuthState.unverified;

          this.verificationId = verificationId;
          authException = null;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        phoneNumber: phone,
      );
    } on Exception catch (e) {
      authException = e.toString();
      notifyListeners();
    }
  }

  verifyOTP({required String otp}) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on Exception catch (e) {
      authException = e.toString();
      notifyListeners();
    }
  }

  saveDetails({
    required String userName,
    required String userLocation,
  }) async {
    authState = AuthState.loading;
    notifyListeners();
    try {
      await _firebaseFirestore
          .collection('UserDetails')
          .doc(_firebaseAuth.currentUser!.phoneNumber)
          .set({
        'userName': userName,
        'userLocation': userLocation,
      });
      user = AppUser(
        username: userName,
        phone: _firebaseAuth.currentUser!.phoneNumber!,
        userLocation: userLocation,
      );
    } on Exception catch (e) {
      authException = e.toString();
      notifyListeners();
    }
  }

  void getUserDetails() async {
    final doc = await _firebaseFirestore
        .collection('UserDetails')
        .doc(_firebaseAuth.currentUser!.phoneNumber)
        .get();
    user = AppUser(
      username: doc.data()!['userName'],
      phone: doc.id,
      userLocation: doc.data()!['userLocation'],
    );
  }

  void logout() async {
    await _firebaseAuth.signOut();
    user = null;
    authException = null;
    authState = AuthState.loggedOut;
    notifyListeners();
  }
}
