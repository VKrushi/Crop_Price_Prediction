import 'package:flutter/material.dart';

class ExpenseOrBenefitTile extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final int amount;
  const ExpenseOrBenefitTile({
    super.key,
    required this.onTap,
    required this.text,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("$text (₹ $amount)"),
      trailing: IconButton(
        onPressed: onTap,
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
