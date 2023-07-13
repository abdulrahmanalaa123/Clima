import 'package:flutter/material.dart';
import 'status_button.dart';
import 'main_page_text_column.dart';
import 'package:second_project/constants/constants.dart';
import 'package:intl/intl.dart';

class WeatherCardDisplay extends StatelessWidget {
  const WeatherCardDisplay({
    required this.temp,
    required this.weather,
    required this.date,
    required this.windSpeed,
    required this.humidity,
    this.rain,
    required this.assetPath,
    super.key,
  });

  final double temp;
  final String weather;
  final DateTime date;
  final double windSpeed;
  final double? rain;
  final double humidity;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const StatusButton(),
        WeatherTextDetails(
          temp: temp.toStringAsFixed(0),
          weather: weather,
          date: DateFormat('EEEE, d MMMM').format(date),
          windSpeed: windSpeed,
          rainProb: rain ?? 0.2,
          humidity: humidity,
        ),
        ImageBox(
          imgPath: assetPath,
        ),
      ],
    );
  }
}

class ImageBox extends StatelessWidget {
  const ImageBox({
    required this.imgPath,
    super.key,
  });
  final String imgPath;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Expanded(child: SizedBox()),
        Expanded(
          flex: Constants.imgColFlex,
          child: SizedBox(
            child: Image(
              image: AssetImage(
                imgPath,
              ),
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
        ),
        Expanded(flex: Constants.imgPaddingColFlex, child: const SizedBox()),
      ],
    );
  }
}
