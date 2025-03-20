import 'package:flutter/material.dart';
import 'package:frontend/controller/api/crop_price_prediction_api.dart';
import 'package:frontend/view/widgets/crop_price_line_chart.dart';
import 'package:provider/provider.dart';
import '../constants/enums.dart';
import '../constants/raw_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CropPricePredictionScreen extends StatefulWidget {
  const CropPricePredictionScreen({super.key});

  @override
  State<CropPricePredictionScreen> createState() =>
      _CropPricePredictionScreenState();
}

class _CropPricePredictionScreenState extends State<CropPricePredictionScreen> {
  String? selectedCrop;

  @override
  void initState() {
    Provider.of<CropPricePredictionApi>(context, listen: false)
        .predictionApiState = ApiState.none;
    super.initState();
  }

  void onClickEnter() {
    final provider =
        Provider.of<CropPricePredictionApi>(context, listen: false);

    if (isValid()) {
      provider.predictPrice(crop: selectedCrop!);
    } else {
      provider.predictionApiState = ApiState.error;
      provider.error = 'Invalid Input';
      provider.forecastedPrice = null;
      setState(() {});
    }
  }

  bool isValid() {
    return selectedCrop != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.cropPricePredictorText,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                // color: Colors.grey[200],
                border: Border.all(
                  color: Colors.grey[300]!,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButton<String>(
                value: selectedCrop,
                underline: Container(),
                hint: Text(
                  AppLocalizations.of(context)!.cropSelectionText,
                ),
                icon: const Icon(Icons.arrow_drop_down_sharp),
                items: cropList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedCrop = value;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => onClickEnter(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]!),
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey[800]!,
                ),
                child: Text(
                  AppLocalizations.of(context)!.predictButtonText,
                  style: TextStyle(
                    color: Colors.grey[200]!,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
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
            Consumer<CropPricePredictionApi>(
              builder: (context, value, child) {
                switch (value.predictionApiState) {
                  case ApiState.none:
                    return Container();
                  case ApiState.loading:
                    return const CircularProgressIndicator();
                  default:
                    List<double> data = [];
                    for (Map map in value.forecastedPrice!) {
                      data.add(map['price']);
                    }
                    return Column(
                      children: [
                        DataTable(
                            border: TableBorder.all(color: Colors.black),
                            columns: const [
                              DataColumn(label: Text('Month')),
                              DataColumn(
                                  label: Text('Crop Price per quintal (₹)')),
                            ],
                            rows: List.generate(value.forecastedPrice!.length,
                                (index) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(
                                      value.forecastedPrice![index]['month'])),
                                  DataCell(Text(value.forecastedPrice![index]
                                          ['price']
                                      .toStringAsFixed(1))),
                                ],
                              );
                            })),
                        CropPriceLineChart(
                          data: data,
                        ),
                      ],
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
