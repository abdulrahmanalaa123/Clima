import 'package:flutter/material.dart';
import '../../pages/success_landing_page.dart';
import '../../pages/loading_page.dart';
import '../../pages/failure_landing_page.dart';

class PageTransition extends StatelessWidget {
  const PageTransition(
      {required this.futureData,
      required this.errorText,
      this.city,
      super.key});

  final Future<List<dynamic>> futureData;
  final String errorText;
  final String? city;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: futureData,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else if (snapshot.hasError) {
            print(snapshot.error);
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              errorBox(context, errorText);
            });
            return const SearchInitializationPage();
          } else {
            return TodayWeatherPage(
              weatherList: snapshot.data ?? [],
              cityName: city,
            );
          }
        });
  }

  errorBox(BuildContext context, String errorText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(errorText),
          content: const Text('Please retry calling the service'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK')),
          ],
        );
      },
    );
  }
}
