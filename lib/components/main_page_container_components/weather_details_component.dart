import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ExtraWeatherDetails extends StatelessWidget {
  const ExtraWeatherDetails(
      {required this.windSpeed,
      required this.humidity,
      required this.rainProb,
      super.key});
  final double windSpeed;
  final double humidity;
  final double rainProb;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconDisplay(
          icon: CupertinoIcons.wind,
          value: windSpeed,
          suffix: 'km/hr',
          type: 'Wind',
        ),
        IconDisplay(
          icon: CupertinoIcons.drop,
          value: humidity,
          suffix: '%',
          type: 'Humidity',
        ),
        IconDisplay(
          icon: Icons.waves,
          value: rainProb,
          suffix: '%',
          type: 'Chance of Rain',
        )
      ],
    );
  }
}

class IconDisplay extends StatelessWidget {
  const IconDisplay({
    required this.icon,
    required this.value,
    required this.suffix,
    required this.type,
    super.key,
  });
  final IconData icon;
  final double value;
  final String suffix;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(
          '$value $suffix',
          style:
              const TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
        ),
        Text(
          type,
          style: const TextStyle(
              fontWeight: FontWeight.w400, color: Colors.white38),
        )
      ],
    );
  }
}
