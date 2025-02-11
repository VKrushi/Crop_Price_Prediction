import 'package:flutter/material.dart';
import 'package:frontend/controller/providers/auth_state_provider.dart';
import 'package:provider/provider.dart';

class MobileDrawer extends StatelessWidget {
  final void Function() onClickLatestNews;
  final void Function() onClickGovtSchemes;
  const MobileDrawer({
    super.key,
    required this.onClickLatestNews,
    required this.onClickGovtSchemes,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: const Icon(
              Icons.person,
              size: 100,
            ),
          ),
          const Text('User Name'),
          const SizedBox(height: 32),
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text(
                'Profile',
                style: TextStyle(
                  letterSpacing: 0.8,
                ),
              ),
              onTap: () {},
            ),
          ),
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text(
                'Latest News',
                style: TextStyle(
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
              title: const Text(
                'Govt. Schemes',
                style: TextStyle(
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
              title: const Text(
                'Logout',
                style: TextStyle(
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
