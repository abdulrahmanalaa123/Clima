import 'package:flutter/material.dart';
import 'transitioning.dart';
import 'package:second_project/packages/weather_module.dart';

class CitiesSearchBar extends StatelessWidget {
  const CitiesSearchBar({
    super.key,
    required this.myController,
    required this.onChanged,
    required this.queryList,
    required this.chosenIndex,
    required this.xFunction,
  });

  final TextEditingController myController;
  final void Function(String) onChanged;
  final List<dynamic> queryList;
  final int chosenIndex;
  final void Function() xFunction;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2)),
      child: Row(
        children: [
          const Expanded(
            child: Icon(
              Icons.location_city_outlined,
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 6,
            child: TextField(
              decoration: InputDecoration(
                icon: const Icon(Icons.search),
                iconColor: Colors.white38,
                border: InputBorder.none,
                suffixIcon: myController.text != ''
                    ? GestureDetector(
                        onTap: xFunction,
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      )
                    : null,
                hintText: 'Enter your City',
              ),
              controller: myController,
              textDirection: TextDirection.ltr,
              showCursor: true,
              cursorRadius: const Radius.circular(10),
              onChanged: onChanged,
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () async {
                final daily3HourList = Weather(
                        queryList[chosenIndex].lat, queryList[chosenIndex].lon)
                    .getData();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PageTransition(
                              futureData: daily3HourList,
                              errorText: 'Check your Internet Connection ',
                              city: queryList[chosenIndex].toString(),
                            )));
              },
              icon: const Icon(Icons.arrow_circle_right_rounded),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
