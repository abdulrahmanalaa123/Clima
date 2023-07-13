import 'package:flutter/material.dart';
import 'package:second_project/constants/constants.dart';

class DailyWeatherTile extends StatelessWidget {
  const DailyWeatherTile(
      {required this.weekday,
      required this.weather,
      required this.maxTemp,
      required this.minTemp,
      required this.assetPath,
      super.key});
  final String weekday;
  final String weather;
  final String maxTemp;
  final String minTemp;
  final String assetPath;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        child: Row(
          children: [
            Text(
              weekday,
              style: Constants.secondPageListStyle,
            ),
            const Expanded(child: SizedBox()),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Image(
                        image: AssetImage(
                          assetPath,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(weather, style: Constants.secondPageListStyle),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            Text('$maxTemp\u00B0 ',
                style: Constants.secondPageListStyle
                    .copyWith(color: Colors.white)),
            Text('$minTemp\u00B0 ', style: Constants.secondPageListStyle),
          ],
        ),
      ),
    );
  }
}
