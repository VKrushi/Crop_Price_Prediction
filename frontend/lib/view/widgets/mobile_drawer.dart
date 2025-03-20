import 'package:flutter/material.dart';
import 'package:frontend/controller/providers/auth_state_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MobileDrawer extends StatelessWidget {
  final void Function() onClickLatestNews;
  final void Function() onClickGovtSchemes;
  final void Function() onClickProfile;
  const MobileDrawer({
    super.key,
    required this.onClickLatestNews,
    required this.onClickGovtSchemes,
    required this.onClickProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/profile_pic.png',
            fit: BoxFit.contain,
          ),
          const Text('User Name'),
          const SizedBox(height: 32),
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: Text(
                AppLocalizations.of(context)!.profileMenuText,
                style: const TextStyle(
                  letterSpacing: 0.8,
                ),
              ),
              onTap: onClickProfile,
            ),
          ),
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: Text(
                AppLocalizations.of(context)!.latestNewsMenuText,
                style: const TextStyle(
                  letterSpacing: 0.8,
                ),
              ),
              onTap: onClickLatestNews,
            ),
          ),
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: Text(
                AppLocalizations.of(context)!.govtSchemesMenuText,
                style: const TextStyle(
                  letterSpacing: 0.8,
                ),
              ),
              onTap: onClickGovtSchemes,
            ),
          ),
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: Text(
                AppLocalizations.of(context)!.logoutMenuText,
                style: const TextStyle(
                  letterSpacing: 0.8,
                ),
              ),
              onTap: () =>
                  Provider.of<AuthStateProvider>(context, listen: false)
                      .logout(),
            ),
          ),
        ],
      ),
    );
  }
}
