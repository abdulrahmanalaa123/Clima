import 'package:flutter/material.dart';

class Constants {
  static const mainColor = Color(0xFF15BDF5);
  static const secondaryColor = Color(0xFF1275F5);
  static const shadowColor = Color(0xFF073F8E);
  static const primaryThemeColor = Color(0xFF000B19);
  static const borderColor = Color(0xFF2F99EC);
  static const glowColor = Color(0xFF00A1FF);
  static int textColFlex = 4;
  static int paddingTextColFlex = 3;
  static int imgColFlex = 4;
  static int imgPaddingColFlex = 5;
  static const EdgeInsetsGeometry subMargin =
      EdgeInsets.only(left: 8, top: 8, bottom: 8);
  static const EdgeInsetsGeometry subPadding = EdgeInsets.all(8);
  static const TextStyle secondPageListStyle = TextStyle(
      fontWeight: FontWeight.w500, color: Colors.white30, fontSize: 20);

  static LinearGradient gradient = LinearGradient(
    colors: [
      secondaryColor,
      mainColor.withOpacity(0.95),
      mainColor.withOpacity(0.9),
      mainColor
    ],
    begin: Alignment.bottomRight,
  );
  static const mainBorderRadius = BorderRadiusDirectional.only(
      bottomEnd: Radius.elliptical(60, 50),
      bottomStart: Radius.elliptical(60, 50));
  static BorderRadius subBorderRadius = BorderRadius.circular(30);
  static const BoxShadow glowBorder = BoxShadow(
    color: Constants.glowColor,
    blurRadius: 6,
    offset: Offset(0, 1),
    spreadRadius: 0,
  );

  static BoxDecoration buildBoxDecoration(bool main, bool shadow, bool active) {
    return BoxDecoration(
      // all of those conditions to allow reusability across the main contianer and
      //sub container
      color: active ? primaryThemeColor : null,
      gradient: active ? gradient : null,
      borderRadius: main ? mainBorderRadius : subBorderRadius,
      border: Border.all(
        color: active ? borderColor : Colors.white12,
        width: 1,
      ),
      //if it is active the give a shaodw if not then check if it has a shadow or only a glow
      boxShadow: active
          ? shadow
              ? [
                  glowBorder,
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 0,
                    offset: const Offset(10, 20).scale(0, 1),
                    spreadRadius: -10,
                  ),
                ]
              : [
                  glowBorder,
                ]
          : null,
    );
  }

  static const Map<String, int> maxIds = {
    'Thunderstorm': 32,
    'Drizzle': 21,
    'Rain': 31,
    'Snow': 22,
    'Clear': 0,
    'Clouds': 4,
  };
  static Map<String, String> dayAssetsMap = {
    'Thunderstorm': 'assets/images/Thunderstorm.png',
    'Clear': 'assets/images/Clear.png',
    'Clouds': 'assets/images/Clouds.png',
    'Tornado': 'assets/images/Tornado.png',
    'Drizzle': 'assets/images/Rain.png',
    'Rain': 'assets/images/Rain.png',
    'Snow': 'assets/images/Snow.png',
  };
  static Map<String, String> nightAssetsMap = {
    'Thunderstorm': 'assets/images/ThunderstormSub.png',
    'Clear': 'assets/images/Clear.png',
    'Clouds': 'assets/images/Clouds.png',
    'Tornado': 'assets/images/Tornado.png',
    'Drizzle': 'assets/images/Tornado.png',
    'Rain': 'assets/images/Rain.png',
    'Snow': 'assets/images/Snow.png',
  };
}
