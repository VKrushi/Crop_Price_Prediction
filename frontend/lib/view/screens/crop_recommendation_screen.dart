import 'package:flutter/material.dart';
import 'package:frontend/controller/api/crop_recommendation_api.dart';
import 'package:frontend/view/constants/enums.dart';
import 'package:frontend/view/widgets/parameter_textfield.dart';
import 'package:provider/provider.dart';

class CropRecommendationScreen extends StatefulWidget {
  const CropRecommendationScreen({super.key});

  @override
  State<CropRecommendationScreen> createState() =>
      _CropRecommendationScreenState();
}

class _CropRecommendationScreenState extends State<CropRecommendationScreen> {
  late final TextEditingController controller1;
  late final TextEditingController controller2;
  late final TextEditingController controller3;
  late final TextEditingController controller4;
  late final TextEditingController controller5;

  @override
  void initState() {
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    controller4 = TextEditingController();
    controller5 = TextEditingController();
    Provider.of<CropRecommendationApi>(context, listen: false)
        .recommendationApiState = ApiState.none;
    super.initState();
  }

  void onClickEnter() {
    final provider = Provider.of<CropRecommendationApi>(context, listen: false);

    if (isValid()) {
      var nitrogen = double.parse(controller1.text);
      var temperature = double.parse(controller2.text);
      var humidity = double.parse(controller3.text);
      var pH = double.parse(controller4.text);
      var rainfall = double.parse(controller5.text);
      provider.recommendCrop(
        nitrogen: nitrogen,
        temperature: temperature,
        humidity: humidity,
        pH: pH,
        rainfall: rainfall,
      );
    } else {
      provider.recommendationApiState = ApiState.error;
      provider.error = 'Invalid Input';
      provider.recommendedCrop = null;
      setState(() {});
    }
  }

  bool isValid() {
    if (controller1.text.isEmpty ||
        controller2.text.isEmpty ||
        controller3.text.isEmpty ||
        controller4.text.isEmpty ||
        controller5.text.isEmpty) {
      print(false);
      return false;
    }
    print(true);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crop Recommendation System',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: ParameterTextField(
                  controller: controller1,
                  label: 'Nitrogen',
                  hintText: 'cg/kg',
                ),
              ),
              Flexible(
                flex: 1,
                child: ParameterTextField(
                  controller: controller2,
                  label: 'Temperature',
                  hintText: '℃',
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: ParameterTextField(
                  controller: controller3,
                  label: 'Humidity',
                  hintText: 'g/m3',
                ),
              ),
              Flexible(
                flex: 1,
                child: ParameterTextField(
                  controller: controller4,
                  label: 'pH',
                  hintText: '',
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Flexible(
                flex: 2,
                child: ParameterTextField(
                  controller: controller5,
                  label: 'Rainfall',
                  hintText: 'mm',
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Flexible(
                flex: 2,
                child: GestureDetector(
                  onTap: () => onClickEnter(),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[400]!),
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey[800]!,
                    ),
                    child: Text(
                      'Enter',
                      style: TextStyle(
                        color: Colors.grey[200]!,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
            ],
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
          Consumer<CropRecommendationApi>(
            builder: (context, value, child) {
              switch (value.recommendationApiState) {
                case ApiState.none:
                  return Container();
                case ApiState.loading:
                  return const CircularProgressIndicator();
                default:
                  return Text(
                    value.recommendationApiState == ApiState.error
                        ? value.error!
                        : value.recommendedCrop!,
                    style: TextStyle(
                      color: value.recommendationApiState == ApiState.error
                          ? Colors.red
                          : Colors.grey[800],
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
