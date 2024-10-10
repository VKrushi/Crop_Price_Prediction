import 'package:flutter/material.dart';

class FeatureTile extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final Image image;
  const FeatureTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 24,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 8,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Container(child: image),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    'Try it now >>',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
