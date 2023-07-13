import 'package:flutter/material.dart';
import 'package:second_project/packages/weather_module.dart';
import '../../constants/constants.dart';
import '../components/main_page_container_components/layout_element_combination.dart';
import '../components/main_page_container_components/bottom_display.dart';
import '../components/main_page_container_components/sub_container.dart';
import 'package:intl/intl.dart';

class TodayWeatherPage extends StatefulWidget {
  const TodayWeatherPage({required this.weatherList, this.cityName, super.key});
//warning: This class (or a class that this class inherits from) is marked as '@immutable', but one or more of its instance fields aren't final: FirstPage.currIndex, FirstPage.status (must_be_immutable at [second_project] lib\pages\success_landing_page.dart:9)
// how should it be done?
  //it was because you shouldnt put a non final value in the initialization of a stateful widget
  final List<dynamic> weatherList;
  final String? cityName;
  @override
  State<TodayWeatherPage> createState() => _TodayWeatherPageState();
}

class _TodayWeatherPageState extends State<TodayWeatherPage> {
  int currIndex = 0;
  //List<bool> status = List<bool>.filled(4, false);

  List<bool> status = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryThemeColor,
      body: SafeArea(
        child: Column(children: [
          Expanded(
            flex: 12,
            child: MainContainer(
              childObj: WeatherCardLayout(
                weatherObj: widget.weatherList[currIndex],
                cityName: widget.cityName,
              ),
            ),
          ),
          SizedBox(
              child: BottomDisplay(
            restOfList:
                //divide from the first to the end
                widget.weatherList.sublist(8),
          )),
          Expanded(
            flex: 3,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                WeatherState weatherObj = widget.weatherList[index * 2];
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        //to get the staus of the current skipped timestamp
                        status[currIndex ~/ 2] = false;
                        //make the current element light up and cant turn off except by selecting another
                        status[index] = true;
                        //to divide the day into 4 timeStamps
                        currIndex = 2 * index;
                      });
                    },
                    child: TodayHourlyCards(
                      temp: weatherObj.avgtemp.toStringAsFixed(0),
                      currentHour:
                          DateFormat('HH:mm').format(weatherObj.dateTime),
                      active: status[index],
                      assetPath: weatherObj.assetPath,
                    ));
              },
            ),
          ),
        ]),
      ),
    );
  }
}

class MainContainer extends StatelessWidget {
  const MainContainer({
    required this.childObj,
    super.key,
  });
  final Widget childObj;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: Constants.buildBoxDecoration(true, true, true),
      child: childObj,
    );
  }
}
