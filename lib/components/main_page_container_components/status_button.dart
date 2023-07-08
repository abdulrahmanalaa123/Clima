import 'package:flutter/material.dart';

class StatusButton extends StatelessWidget {
  const StatusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Expanded(
        child: SizedBox(),
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.white30, width: 1),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.trip_origin_rounded,
                color: Colors.greenAccent,
                size: 10,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Got Location',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
      const Expanded(
        child: SizedBox(),
      ),
    ]);
  }
}
