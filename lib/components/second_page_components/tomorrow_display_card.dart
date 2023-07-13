import 'package:flutter/material.dart';
import '../../packages/weather_module.dart';
import '../main_page_container_components/custom_nav_bar.dart';
import 'weather_text_details.dart';
import '../main_page_container_components/weather_details_component.dart';

class TomorrowWeatherCard extends StatelessWidget {
  const TomorrowWeatherCard({required this.weatherStateObject, super.key});
  final WeatherState weatherStateObject;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: CustomNavBar(
              firstIcon: Icons.arrow_back_ios_rounded,
              firstIconSize: 15,
              firstIconFunction: () {
                Navigator.pop(context);
              },
              secondIcon: Icons.calendar_month_rounded,
              thirdIcon: Icons.more_vert,
              secondIconText: ' 4 days'),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 4,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: Image(
                image: AssetImage(weatherStateObject.assetPath),
                fit: BoxFit.contain,
              )),
              Expanded(
                  child: TomorrowCardTextDetails(
                minTemp: weatherStateObject.tempMin.toStringAsFixed(0),
                maxTemp: weatherStateObject.tempMax.toStringAsFixed(0),
                weather: weatherStateObject.weather,
              ))
            ],
          ),
        ),
        const Divider(
          color: Colors.white30,
          indent: 60,
          endIndent: 60,
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 3,
          child: ExtraWeatherDetails(
              windSpeed: weatherStateObject.windspeed,
              humidity: weatherStateObject.humidity.toDouble(),
              rainProb: weatherStateObject.rainProb ?? 20),
        )
      ],
    );
  }
}
