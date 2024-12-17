import 'package:flutter/material.dart';
import 'package:frontend/controller/api/crop_price_prediction_api.dart';
import 'package:provider/provider.dart';
import '../constants/enums.dart';

class CropPricePredictionScreen extends StatefulWidget {
  const CropPricePredictionScreen({super.key});

  @override
  State<CropPricePredictionScreen> createState() =>
      _CropPricePredictionScreenState();
}

class _CropPricePredictionScreenState extends State<CropPricePredictionScreen> {
  List<String> cropList = ['Wheat', 'Rice'];
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
      provider.predictPrice(crop: '');
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
        title: const Text(
          'Crop Price Prediction System',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Column(
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
              hint: const Text(' Select Crop '),
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
                  return value.predictionApiState == ApiState.error
                      ? Text(value.error!)
                      : Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
