import 'package:flutter/material.dart';
import 'package:second_project/packages/weather_module.dart';
import '../../constants/constants.dart';
import 'success_landing_page.dart';
import 'package:intl/intl.dart';
import '../components/second_page_components/Rest_of_the_week_display_tiles.dart';
import '../components/second_page_components/tomorrow_display_card.dart';

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
                    childObj: TomorrowWeatherCard(
                        //done at length of 4 to find the middle of the next day as the average min max in the day
                        //not efficient but fuck the weather its not the main focus
                        weatherStateObject: dailyWeatherList[4]))),
            const SizedBox(
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
                        return index % 3 == 0
                            ? DailyWeatherTile(
                                weekday: DateFormat('EEE')
                                    .format(weatherObj.dateTime),
                                weather: weatherObj.weather,
                                maxTemp: weatherObj.tempMax.toStringAsFixed(0),
                                minTemp: weatherObj.tempMin.toStringAsFixed(0),
                                assetPath: weatherObj.assetPath,
                              )
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
