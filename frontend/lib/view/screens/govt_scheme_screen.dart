import 'package:flutter/material.dart';
import 'package:frontend/controller/api/govt_schemes_api.dart';
import 'package:frontend/view/widgets/schemes_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constants/colors.dart';
import '../constants/enums.dart';

class GovtSchemeScreen extends StatefulWidget {
  const GovtSchemeScreen({super.key});

  @override
  State<GovtSchemeScreen> createState() => _GovtSchemeScreenState();
}

class _GovtSchemeScreenState extends State<GovtSchemeScreen> {
  int categorySelectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.govtSchemesMenuText),
      ),
      body: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    categorySelectedIndex = 0;
                    setState(() {});
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    decoration: BoxDecoration(
                      color: categorySelectedIndex == 0
                          ? appPrimaryColor.withOpacity(0.1)
                          : appBgColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.indianGovText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: categorySelectedIndex == 0
                            ? appPrimaryColor
                            : appBlackColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    categorySelectedIndex = 1;
                    setState(() {});
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    decoration: BoxDecoration(
                      color: categorySelectedIndex == 1
                          ? appPrimaryColor.withOpacity(0.1)
                          : appBgColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.stateGovText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: categorySelectedIndex == 1
                            ? appPrimaryColor
                            : appBlackColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Consumer<GovtSchemesApi>(
            builder: (context, value, child) {
              switch (value.schemeApiState) {
                case ApiState.loading:
                  return const CircularProgressIndicator();
                case ApiState.error:
                  return Text(
                    value.error!,
                    style: const TextStyle(color: Colors.red),
                  );
                case ApiState.none:
                  return Container();
                default:
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.schemes!.length,
                    itemBuilder: (context, index) {
                      return Visibility(
                        visible: categorySelectedIndex ==
                            value.schemes![index]['Type'],
                        child: SchemesTile(
                          schemeTitle: value.schemes![index]['Title'],
                          schemeUrl: value.schemes![index]['Link'],
                        ),
                      );
                    },
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
