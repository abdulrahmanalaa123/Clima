import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar(
      {required this.firstIcon,
      this.firstIconFunction,
      this.firstIconSize,
      required this.secondIcon,
      required this.thirdIcon,
      required this.secondIconText,
      super.key});
  final IconData firstIcon;
  final IconData secondIcon;
  final IconData thirdIcon;
  final String secondIconText;
  final double? firstIconSize;
  final void Function()? firstIconFunction;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                    color: Colors.white30, style: BorderStyle.solid)),
            child: IconButton.outlined(
              onPressed: firstIconFunction ?? () {},
              icon: Icon(
                firstIcon,
                size: firstIconSize ?? 20,
              ),
              color: Colors.white,
            ),
          ),
        ),
        Row(
          children: [
            Icon(
              secondIcon,
              color: Colors.white,
            ),
            Text(
              secondIconText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
        IconButton.outlined(
          onPressed: () {},
          icon: Icon(thirdIcon),
          color: Colors.white,
          iconSize: 20,
        ),
      ],
    );
  }
}
