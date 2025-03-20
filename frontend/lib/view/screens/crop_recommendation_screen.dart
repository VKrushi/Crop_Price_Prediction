import 'package:flutter/material.dart';
import 'package:frontend/controller/api/crop_recommendation_api.dart';
import 'package:frontend/view/constants/enums.dart';
import 'package:frontend/view/widgets/parameter_textfield.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  @override
  void initState() {
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    Provider.of<CropRecommendationApi>(context, listen: false)
        .recommendationApiState = ApiState.none;
    super.initState();
  }

  void onClickEnter() async {
    final provider = Provider.of<CropRecommendationApi>(context, listen: false);

    if (isValid()) {
      var location = controller1.text;
      var weather = controller2.text;
      var soil = controller3.text;
      await provider.recommendCrop(
        location: location,
        weather: weather,
        soil: soil,
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
        controller3.text.isEmpty) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.cropReccomendationText,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ParameterTextField(
              controller: controller1,
              label: 'Location',
              hintText: 'Name of Place/City',
            ),
            ParameterTextField(
              controller: controller2,
              label: 'Weather',
              hintText: 'Rainfall, climate, etc',
            ),
            ParameterTextField(
              controller: controller3,
              label: 'Soil',
              hintText: 'Nature of soil',
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
                        AppLocalizations.of(context)!.recommendButtonText,
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          value.recommendationApiState == ApiState.error
                              ? value.error!
                              : value.recommendedCrop!,
                          style: TextStyle(
                            color:
                                value.recommendationApiState == ApiState.error
                                    ? Colors.red
                                    : Colors.grey[800],
                            fontSize: 16,
                          ),
                        ),
                      ),
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
