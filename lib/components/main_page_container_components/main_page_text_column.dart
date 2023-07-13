import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter/material.dart';
import 'package:second_project/constants/constants.dart';
import 'weather_details_component.dart';

class WeatherTextDetails extends StatelessWidget {
  const WeatherTextDetails(
      {required this.temp,
      required this.weather,
      required this.date,
      required this.humidity,
      required this.windSpeed,
      this.rainProb,
      super.key});
  final String temp;
  final String weather;
  final String date;
  final double windSpeed;
  final double humidity;
  final double? rainProb;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: Constants.paddingTextColFlex, child: const SizedBox()),
        Expanded(
          flex: Constants.textColFlex,
          child: SizedBox(
            child: Column(
              children: [
                GlowText(
                  '$temp\u00B0',
                  style: const TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Text(
                  weather,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                      color: Colors.white),
                ),
                Text(
                  date,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.white60),
                ),
                const Divider(
                  color: Colors.white30,
                  indent: 50,
                  endIndent: 50,
                ),
                ExtraWeatherDetails(
                  windSpeed: windSpeed,
                  humidity: humidity,
                  rainProb: rainProb ?? 0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
