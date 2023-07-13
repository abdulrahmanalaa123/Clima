import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

class TomorrowCardTextDetails extends StatelessWidget {
  const TomorrowCardTextDetails(
      {required this.minTemp,
      required this.maxTemp,
      required this.weather,
      super.key});

  final String minTemp;
  final String maxTemp;
  final String weather;
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Tomorrow',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GlowText(
                '$maxTemp\u00B0',
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 60, color: Colors.white),
              ),
              Text(
                '/$minTemp\u00B0',
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white30,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          Text(
            weather,
            textAlign: TextAlign.start,
            style: const TextStyle(
                fontSize: 20,
                color: Colors.white30,
                fontWeight: FontWeight.w500),
          )
        ]);
  }
}
