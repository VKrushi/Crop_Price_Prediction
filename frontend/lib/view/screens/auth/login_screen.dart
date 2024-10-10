import 'package:flutter/material.dart';
import 'package:frontend/controller/providers/auth_state_provider.dart';
import 'package:frontend/view/constants/enums.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController phoneController;
  late TextEditingController otpController;

  @override
  void initState() {
    phoneController = TextEditingController();
    otpController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthStateProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.green,
        body: SafeArea(
          child: Center(
            child: value.authState == AuthState.loading
                ? const CircularProgressIndicator()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Icon(
                          Icons.lock,
                          size: 100,
                          color: Colors.grey[200],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          'VKrushi',
                          style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Welcome back you have been missed',
                          style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        value.authState == AuthState.loggedOut
                            ? CustomTextField(
                                controller: phoneController,
                                hintText: 'Phone',
                                isObscureText: false,
                                textInputType: TextInputType.phone,
                              )
                            : Container(),
                        const SizedBox(
                          height: 15,
                        ),
                        value.authState == AuthState.unverified
                            ? CustomTextField(
                                controller: otpController,
                                hintText: 'OTP',
                                isObscureText: false,
                                textInputType: TextInputType.phone,
                              )
                            : Container(),
                        const SizedBox(
                          height: 15,
                        ),
                        value.authException != null
                            ? Text(
                                value.authException!,
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                              )
                            : Container(),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: CustomButton(
                            text: 'Verify',
                            onTap: () => value.authState == AuthState.loggedOut
                                ? value.verifyPhone(phone: phoneController.text)
                                : value.verifyOTP(otp: otpController.text),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
