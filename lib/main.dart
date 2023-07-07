import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'packages/location_module.dart';
import 'packages/weather_module.dart';
import 'pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  Position pos = Position();
  @override
  Widget build(BuildContext context) {
    try {
      pos.requestAccess();
      pos.init();
    } catch (e) {
      Navigator.of(context).pop;
      SystemNavigator.pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Hello woqjfoeqjfe"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
              onPressed: (() async {
                List<dynamic> daily3HourList =
                    await Weather(pos.latitude, pos.longitude).getData();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FirstPage(
                              weatherList: daily3HourList,
                            )));
              }),
              child: Text(
                'Get Location',
                style: TextStyle(color: Colors.black),
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
