import 'package:flutter/material.dart';
import 'package:frontend/controller/providers/expense_benefit_provider.dart';
import 'package:frontend/view/constants/colors.dart';

import 'package:frontend/view/constants/raw_data.dart';
import 'package:frontend/view/widgets/expense_or_benefit_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/parameter_textfield.dart';

class ProfitCalculatorScreen extends StatefulWidget {
  const ProfitCalculatorScreen({super.key});

  @override
  State<ProfitCalculatorScreen> createState() => _ProfitCalculatorScreenState();
}

class _ProfitCalculatorScreenState extends State<ProfitCalculatorScreen> {
  late final TextEditingController controller1;
  late final TextEditingController controller2;
  String? selectedExpenseOption;
  String? selectedBenefitOption;

  @override
  void initState() {
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    super.initState();
  }

  void onCalculateProfit() {
    int profit = Provider.of<ExpenseBenefitProvider>(context, listen: false)
        .calculateProfit();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Calculated Profit'),
        content: profit < 0
            ? Text(
                'You have incurred a loss of ₹ ${-profit} as per your given data',
                style: const TextStyle(color: Colors.red),
              )
            : Text(
                'The calculated profit as per your given data is ₹ $profit',
                style: const TextStyle(color: Colors.green),
              ),
        actions: [
          GestureDetector(
            child: const Text('Close'),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseBenefitProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.profitCalculatorText,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(AppLocalizations.of(context)!.addExpenseText),
            ),
            Row(
              children: [
                Flexible(
                  flex: 4,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    alignment: Alignment.center,
                    value: selectedExpenseOption,
                    underline: Container(),
                    hint: Text(
                      AppLocalizations.of(context)!.expenseTypeText,
                    ),
                    icon: const Icon(Icons.arrow_drop_down_sharp),
                    items: expenseOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedExpenseOption = value;
                      setState(() {});
                    },
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: ParameterTextField(
                    controller: controller1,
                    label: AppLocalizations.of(context)!.amountHintText,
                    hintText: 'Cost in ₹',
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[800]!,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => value.addNewExpense(
                          expenseType: selectedExpenseOption!,
                          amount: int.parse(controller1.text),
                          context: context,
                        ),
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: appBgColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(AppLocalizations.of(context)!.addBenefitText),
            ),
            Row(
              children: [
                Flexible(
                  flex: 4,
                  child: DropdownButton<String>(
                    value: selectedBenefitOption,
                    isExpanded: true,
                    alignment: Alignment.center,
                    underline: Container(),
                    hint: Text(AppLocalizations.of(context)!.benefitTypeText),
                    icon: const Icon(Icons.arrow_drop_down_sharp),
                    items: benefitOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedBenefitOption = value;
                      setState(() {});
                    },
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: ParameterTextField(
                    controller: controller2,
                    label: AppLocalizations.of(context)!.amountHintText,
                    hintText: 'Cost in ₹',
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[800]!,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => value.addNewBenefit(
                          benefitType: selectedBenefitOption!,
                          amount: int.parse(controller2.text),
                          context: context,
                        ),
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: appBgColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: onCalculateProfit,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]!),
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey[800]!,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.calculateProfitButtonText,
                    style: TextStyle(
                      color: Colors.grey[200]!,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: List.generate(
                50,
                (index) => Expanded(
                  child: Container(
                    color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                    height: .5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Expenses'),
            StreamBuilder(
              stream: value.getExpenses(context: context),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                    if (snapshot.hasData) {
                      final expenseList = snapshot.data!.docs;
                      value.totalExpense = 0;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: expenseList.length,
                        itemBuilder: (context, index) {
                          String expenseType = expenseList
                              .elementAt(index)
                              .data()['expenseType'];
                          int amount = expenseList
                              .elementAt(index)
                              .data()['amount'] as int;
                          value.totalExpense += amount;
                          return ExpenseOrBenefitTile(
                            onTap: () => value.deleteExpense(
                              context: context,
                              expenseType: expenseType,
                            ),
                            text: expenseType,
                            amount: amount,
                          );
                        },
                      );
                    } else {
                      return const Text('no data');
                    }
                  default:
                    return const CircularProgressIndicator();
                }
              },
            ),
            const Text('Benefits'),
            StreamBuilder(
              stream: value.getBenefits(context: context),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                    if (snapshot.hasData) {
                      final benefitList = snapshot.data!.docs;
                      value.totalBenefit = 0;
                      return ListView.builder(
                        itemCount: benefitList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          int amount = benefitList
                              .elementAt(index)
                              .data()['amount'] as int;
                          String benefitType = benefitList
                              .elementAt(index)
                              .data()['benefitType'];
                          value.totalBenefit += amount;

                          return ExpenseOrBenefitTile(
                            onTap: () => value.deleteBenefit(
                              benefitType: benefitType,
                              context: context,
                            ),
                            text: benefitType,
                            amount: amount,
                          );
                        },
                      );
                    } else {
                      return const Text('no data');
                    }

                  default:
                    return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
