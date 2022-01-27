import 'package:flutter/material.dart';

// App Primary color Hex code - #ff862e
// App lite shade Hex Code - #fbe5c9

const PrimaryColor = Color(0xFFff862e);
const SecondaryColor = Color(0xFFfbe5c9);
const AppBarOrangeColor = Color.fromRGBO(255, 148, 36, 0.47);
const OrangeBoxColor = Color.fromRGBO(246, 202, 146, 0.46);
const ProfileOrangeColor = Color.fromRGBO(246, 202, 146, 1);
const CompletedGreenButtonColor = Color.fromRGBO(255, 134, 46, 1);
const NewCompletedGreenButtonColor = Color.fromRGBO(0, 128, 0, 1);
const LinkBlueColor = Color.fromRGBO(22, 114, 236, 1);
const CheckboxBlueColor = Color.fromRGBO(47, 128, 237, 1);
const InputGreyBorderColor = Color.fromRGBO(196, 196, 196, 1);
const ProfileGreyColor = Color.fromRGBO(237, 237, 237, 0.62);
const ProfileTextOrangeColor = Color.fromRGBO(249, 106, 2, 1);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
