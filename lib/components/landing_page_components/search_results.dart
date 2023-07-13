import 'package:flutter/material.dart';
import 'transitioning.dart';
import 'package:second_project/constants/constants.dart';
import 'package:second_project/packages/weather_module.dart';

class CitiesListResults extends StatelessWidget {
  const CitiesListResults(
      {required this.currentQuery,
      required this.myController,
      required this.indexChanger,
      super.key});
  final List<dynamic> currentQuery;
  final TextEditingController myController;
  final void Function(int index) indexChanger;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: currentQuery.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              myController.text = currentQuery[index].toString();
              FocusScope.of(context).requestFocus(FocusNode());
              indexChanger(index);
              Future<List<dynamic>> daily3HourList =
                  Weather(currentQuery[index].lat, currentQuery[index].lon)
                      .getData();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PageTransition(
                            futureData: daily3HourList,
                            errorText: 'Check your Internet Connection',
                            city: currentQuery[index].toString(),
                          )));
            },
            child: Container(
              margin: const EdgeInsets.all(16),
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Constants.glowColor, width: 2),
                  color: Constants.primaryThemeColor,
                  boxShadow: const [
                    BoxShadow(
                        spreadRadius: 6,
                        blurStyle: BlurStyle.normal,
                        blurRadius: 5,
                        color: Colors.black),
                  ]),
              child: ListTile(
                enabled: true,
                leading: Text(
                  currentQuery[index].toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
            ),
          );
        });
  }
}
