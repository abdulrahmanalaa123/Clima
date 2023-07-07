import 'package:flutter/material.dart';
import 'package:second_project/components/main_page_container_components/layout_element_combination.dart';
import 'package:second_project/components/main_page_container_components/weather_details_component.dart';
import 'package:second_project/packages/weather_module.dart';
import '../../constants/constants.dart';
import '../components/main_page_container_components/custom_nav_bar.dart';
import 'main_page.dart';
import 'package:flutter_glow/flutter_glow.dart';

class RestDaysPage extends StatelessWidget {
  const RestDaysPage({required this.dailyWeatherList, super.key});
  final List<dynamic> dailyWeatherList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const Scaffold(
        backgroundColor: Constants.primaryThemeColor,
        body: SecondPageLayout(),
      ),
    );
  }
}

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

class SecondContainerElements extends StatelessWidget {
  const SecondContainerElements({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: CustomNavBar(
              firstIcon: Icons.arrow_back_ios_sharp,
              firstIconFunction: () {
                Navigator.pop(context);
              },
              secondIcon: Icons.calendar_month_rounded,
              thirdIcon: Icons.more_vert,
              secondIconText: ' 4 days'),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 4,
          child: WeatherDisplay(),
        ),
        Divider(
          color: Colors.white30,
          indent: 60,
          endIndent: 60,
        ),
        Expanded(
          flex: 3,
          child: ExtraWeather(windSpeed: 13, humidity: 40, rainProb: 20),
        )
      ],
    );
  }
}

/**/
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

class TextElement extends StatelessWidget {
  const TextElement({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Tomorrow',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          Row(
            children: [
              GlowText(
                '20',
                style: TextStyle(fontSize: 60, color: Colors.white),
              ),
              Text(
                '/17\u00B0',
                style: TextStyle(fontSize: 30, color: Colors.white30),
              )
            ],
          ),
          Text(
            'Rainy-Cloudy',
            style: TextStyle(fontSize: 20, color: Colors.white30),
          )
        ]);
  }
}
