import 'package:flutter/material.dart';
import 'package:second_project/constants/constants.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Constants.primaryThemeColor,
      body: Center(
        child: Image(
          image: AssetImage('assets/loading.gif'),
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
