import 'package:flutter/material.dart';
import 'status_button.dart';
import 'main_page_text_column.dart';
import 'package:second_project/constants/constants.dart';
import 'package:intl/intl.dart';

class WeatherDisplayComponent extends StatelessWidget {
  const WeatherDisplayComponent({
    required this.temp,
    required this.weather,
    required this.date,
    required this.windspeed,
    required this.humidity,
    this.rain,
    super.key,
  });

  final double temp;
  final String weather;
  final DateTime date;
  final double windspeed;
  final double? rain;
  final double humidity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const StatusButton(),
        TextCol(
          temp: temp.toStringAsFixed(0),
          weather: weather,
          date: DateFormat('EEEE, d MMMM').format(date),
          windSpeed: windspeed,
          rainProb: rain ?? 0.2,
          humidity: humidity,
        ),
        ImageBox(
          imgPath: 'assets/images/sunny.png',
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
