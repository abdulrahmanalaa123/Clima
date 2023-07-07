import 'package:flutter/material.dart';
import 'package:second_project/packages/weather_module.dart';
import '../../constants/constants.dart';
import '../components/main_page_container_components/layout_element_combination.dart';
import '../components/main_page_container_components/bottom_display.dart';
import '../components/main_page_container_components/sub_container.dart';
import 'package:intl/intl.dart';
import 'second_page.dart';

class FirstPage extends StatefulWidget {
  FirstPage({required this.weatherList, super.key});

  final List<dynamic> weatherList;
  int currIndex = 0;
  //List<bool> status = List<bool>.filled(4, false);
  List<bool> status = [true, false, false, false];
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryThemeColor,
      body: SafeArea(
        child: Column(children: [
          Expanded(
            flex: 12,
            child: MainContainer(
              childObj: ContainerContents(
                  weatherObj: widget.weatherList[widget.currIndex]),
            ),
          ),
          SizedBox(
              child: BottomDisplay(
            restOfList:
                widget.weatherList.sublist(8, widget.weatherList.length - 1),
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
                        widget.status[widget.currIndex ~/ 2] = false;
                        //make the current element light up and cant turn off except by selecting another
                        widget.status[index] = true;
                        //to divide the day into 4 timeStamps
                        widget.currIndex = 2 * index;
                      });
                    },
                    child: SubContainer(
                      temp: weatherObj.avgtemp.toStringAsFixed(0),
                      currentHour:
                          DateFormat('HH:mm').format(weatherObj.dateTime),
                      active: widget.status[index],
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
