import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_nav_bar.dart';
import 'weather_display_component.dart';

class ContainerContents extends StatelessWidget {
  const ContainerContents({required this.weatherObj, super.key});

  final dynamic weatherObj;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 8,
      ),
      const Expanded(
          child: CustomNavBar(
        firstIcon: CupertinoIcons.square_grid_2x2,
        secondIcon: CupertinoIcons.map_pin_ellipse,
        thirdIcon: Icons.more_vert,
        secondIconText: 'Alexandria, Egypt',
      )),
      Expanded(
          flex: 9,
          child: WeatherDisplayComponent(
            temp: weatherObj.avgtemp,
            weather: weatherObj.weather,
            date: weatherObj.dateTime,
            windspeed: weatherObj.windspeed,
            humidity: weatherObj.humidity.toDouble(),
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
