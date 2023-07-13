import 'package:flutter/material.dart';
import 'packages/location_module.dart';
import 'packages/weather_module.dart';
import 'package:second_project/components/landing_page_components/transitioning.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  final Position pos = Position();
  late final Future<List<dynamic>> listOfCities;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    widget.listOfCities = initializeAccess();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: PageTransition(
        futureData: widget.listOfCities,
        errorText:
            'Make sure Location service is allowed, Or check your internet connection',
      ),
    );
  }

  Future<List<dynamic>> initializeAccess() async {
    await widget.pos.requestLocationService();
    await widget.pos.requestPermissionLocation();
    await widget.pos.init();
    Future<List<dynamic>> list3Hour =
        Weather(widget.pos.latitude, widget.pos.longitude).getData();
    return list3Hour;
  }
}
