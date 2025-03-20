import 'package:flutter/material.dart';
import 'package:frontend/controller/providers/auth_state_provider.dart';
import 'package:frontend/view/constants/enums.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                          AppLocalizations.of(context)!.appName,
                          style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          AppLocalizations.of(context)!.appWelcomeMessage,
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
                                hintText:
                                    AppLocalizations.of(context)!.phoneHintText,
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
                                hintText:
                                    AppLocalizations.of(context)!.otpHintText,
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
                            text:
                                AppLocalizations.of(context)!.verifyButtonText,
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
