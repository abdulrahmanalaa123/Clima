import 'package:flutter/material.dart';
import 'package:second_project/constants/constants.dart';

class SubContainer extends StatelessWidget {
  const SubContainer({
    required this.active,
    required this.temp,
    required this.currentHour,
    required this.assetPath,
    super.key,
  });
  final bool active;
  final String temp;
  final String currentHour;
  final String assetPath;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            Constants.buildBoxDecoration(false, false, active).copyWith(),
        margin: Constants.subMargin,
        padding: Constants.subPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                '$temp\u00B0',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                child: Image(
                  image: AssetImage(assetPath),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
                //padding the top only instead of sized box because i dont want to use
                //a sized box might mess with expande elements
                child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                currentHour,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.white60),
              ),
            ))
          ],
        ));
  }
}
