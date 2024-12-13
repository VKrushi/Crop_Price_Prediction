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
          user = AppUser(
            username: null,
            phone: phone,
          );
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

  void logout() async {
    await _firebaseAuth.signOut();
    user = null;
    authException = null;
    authState = AuthState.loggedOut;
    notifyListeners();
  }
}
