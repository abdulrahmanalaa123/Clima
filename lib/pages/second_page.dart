import 'package:flutter/material.dart';
import 'package:second_project/components/main_page_container_components/weather_details_component.dart';
import 'package:second_project/packages/weather_module.dart';
import '../../constants/constants.dart';
import '../components/main_page_container_components/custom_nav_bar.dart';
import 'main_page.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:intl/intl.dart';

class RestDaysPage extends StatelessWidget {
  const RestDaysPage({required this.dailyWeatherList, super.key});
  final List<dynamic> dailyWeatherList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.primaryThemeColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 3,
                child: MainContainer(
                    childObj: SecondContainerElements(
                        //done at length of 4 to find the middle of the next day as the average min max in the day
                        //not efficient but fuck the weather its not the main focus
                        weatherStateObject: dailyWeatherList[4]))),
            SizedBox(
              height: 20,
            ),
            Expanded(
                flex: 4,
                child: SizedBox(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: dailyWeatherList.length - 8,
                      itemBuilder: (BuildContext context, int index) {
                        WeatherState weatherObj = dailyWeatherList[index];
                        //didnt use list tile because the effort i would spend customizing it would take much longer than just doing a row
                        //as well in the page before in using the already set container properties
                        //could've changed the count to be constant and just adjust the index values like done in the currIndex in the past page
                        return index % 4 == 0
                            ? ViewingElement(
                                weekday: DateFormat('EEE')
                                    .format(weatherObj.dateTime),
                                weather: weatherObj.weather,
                                maxTemp: weatherObj.tempMax.toStringAsFixed(0),
                                minTemp: weatherObj.tempMin.toStringAsFixed(0))
                            : const SizedBox.shrink();
                      }),
                ))
          ],
        ),
      ),
    );
  }
}

//the layout is deprecated due to the lack of a state provider and needing to pass the list thorugh multiple layers
//which should be optimized by reducing the number of passes reducing the number of instances of the passed object i think
/*
class SecondPageLayout extends StatelessWidget {
  const SecondPageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            flex: 3, child: MainContainer(childObj: SecondContainerElements())),
        Expanded(flex: 4, child: SizedBox())
      ],
    );
  }
}
*/
class SecondContainerElements extends StatelessWidget {
  const SecondContainerElements({required this.weatherStateObject, super.key});
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
                image: AssetImage('assets/images/sunny.png'),
                fit: BoxFit.contain,
              )),
              Expanded(
                  child: TextElement(
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
          child: ExtraWeather(
              windSpeed: weatherStateObject.windspeed,
              humidity: weatherStateObject.humidity.toDouble(),
              rainProb: weatherStateObject.rainProb ?? 20),
        )
      ],
    );
  }
}

// this same element is removed because of the same lack of a state provider issue
/*
class WeatherDisplay extends StatelessWidget {
  const WeatherDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: Image(
          image: AssetImage('assets/images/sunny.png'),
          fit: BoxFit.contain,
        )),
        Expanded(child: TextElement())
      ],
    );
  }
}
*/
class TextElement extends StatelessWidget {
  const TextElement(
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

class ViewingElement extends StatelessWidget {
  const ViewingElement(
      {required this.weekday,
      required this.weather,
      required this.maxTemp,
      required this.minTemp,
      super.key});
  final String weekday;
  final String weather;
  final String maxTemp;
  final String minTemp;

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
                          'assets/images/rainy_2d.png',
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
