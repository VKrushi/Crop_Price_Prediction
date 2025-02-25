import 'package:flutter/material.dart';
import 'package:frontend/view/constants/enums.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../controller/providers/auth_state_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class ProfileCreationScreen extends StatefulWidget {
  const ProfileCreationScreen({super.key});

  @override
  State<ProfileCreationScreen> createState() => _ProfileCreationScreenState();
}

class _ProfileCreationScreenState extends State<ProfileCreationScreen> {
  late final TextEditingController namecontroller;
  late final TextEditingController locationcontroller;

  @override
  void initState() {
    namecontroller = TextEditingController();
    locationcontroller = TextEditingController();
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
                        CustomTextField(
                          controller: namecontroller,
                          hintText: AppLocalizations.of(context)!.nameHintText,
                          isObscureText: false,
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          controller: locationcontroller,
                          hintText:
                              AppLocalizations.of(context)!.locationHintText,
                          isObscureText: false,
                          textInputType: TextInputType.text,
                        ),
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
                                AppLocalizations.of(context)!.proceedButtonText,
                            onTap: () => value.saveDetails(
                              userName: namecontroller.text,
                              userLocation: locationcontroller.text,
                            ),
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
