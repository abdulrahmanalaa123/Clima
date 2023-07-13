import 'package:flutter/material.dart';
import '../../pages/remaining_4_days.dart';

class BottomDisplay extends StatelessWidget {
  const BottomDisplay({this.daysPage, required this.restOfList, super.key});
  final Widget? daysPage;
  final List<dynamic> restOfList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Today',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          daysPage ??
                          RestDaysPage(dailyWeatherList: restOfList)));
            },
            child: const Row(
              children: [
                Text(
                  '4 days',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white30,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.white30,
                  size: 14,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
