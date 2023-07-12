import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_nav_bar.dart';
import 'weather_display_component.dart';

class ContainerContents extends StatelessWidget {
  const ContainerContents({required this.weatherObj, this.cityName, super.key});

  final dynamic weatherObj;
  final String? cityName;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 8,
      ),
      Expanded(
          child: CustomNavBar(
        firstIcon: CupertinoIcons.square_grid_2x2,
        secondIcon: CupertinoIcons.map_pin_ellipse,
        thirdIcon: Icons.more_vert,
        secondIconText: cityName ?? 'Alexandria, Egypt',
      )),
      Expanded(
          flex: 9,
          child: WeatherDisplayComponent(
            temp: weatherObj.avgtemp,
            weather: weatherObj.weather,
            date: weatherObj.dateTime,
            windSpeed: weatherObj.windspeed,
            humidity: weatherObj.humidity.toDouble(),
            assetPath: weatherObj.assetPath,
          )),
    ]);
  }
}

/*
class Template extends StatelessWidget {
  const Template({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Container(
          child: StatusButton(),
        )),
        Expanded(
            flex: 3,
            child: Container(
              child: ImageBox(),
            )),
        Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: Constants.mainBorderRadius,
              ),
              child: TextCol(),
            ))
      ],
    );
  }
}
*/
