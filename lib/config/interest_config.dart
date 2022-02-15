import 'dart:math';

import 'package:flutter/material.dart';

class Item {
  final String name;
  final String path;
  final backgrdColor;
  bool selected;

  Item(this.name, this.path, this.backgrdColor, this.selected);
}

List<Item> itemList = [
  Item(
    'Racial Justice',
    'assets/images/Interests/RacialJustice.png',
    Color.fromRGBO(165, 42, 42, 0.34),
    false,
  ),
  Item(
    'Religious Justice',
    'assets/images/Interests/religion.png',
    Color.fromRGBO(255, 148, 36, 0.47),
    false,
  ),
  Item(
    'covid-19',
    'assets/images/Interests/covid.png',
    Color.fromRGBO(255, 192, 203, 0.34),
    false,
  ),
  Item(
    'Climate change',
    'assets/images/Interests/climate.png',
    Color.fromRGBO(0, 0, 255, 0.3),
    false,
  ),
  Item(
    'gun control',
    'assets/images/Interests/gunsafety.png',
    Color.fromRGBO(97, 97, 97, 0.2),
    false,
  ),
  Item(
    'women’s rights',
    'assets/images/Interests/women.png',
    Color.fromRGBO(236, 185, 249, 0.5),
    false,
  ),
  Item(
    "LGBTQ+ RightS",
    'assets/images/Interests/equity.png',
    Color.fromRGBO(246, 202, 146, 0.46),
    false,
  ),
  Item(
    'Immigration',
    'assets/images/Interests/immigration.png',
    Color.fromRGBO(165, 42, 42, 0.34),
    false,
  ),
  Item(
    'MENTAL HEALTH',
    'assets/images/Interests/mentalhealth.png',
    Color.fromRGBO(117, 212, 234, 0.43),
    false,
  ),
  Item(
    'EDUCATION',
    'assets/images/Interests/education.png',
    Color.fromRGBO(31, 139, 36, 0.2),
    false,
  ),
  Item(
    'Healthcare',
    'assets/images/Interests/health.png',
    Color.fromRGBO(235, 59, 53, 0.42),
    false,
  ),
  Item(
    'ECONOMY',
    'assets/images/Interests/money.png',
    Color.fromRGBO(6, 189, 1, 0.34),
    false,
  ),
];

dynamic listImagesFound = [
  'assets/images/Interests/education.png',
  'assets/images/Interests/blm.png',
  'assets/images/Interests/health.png',
  'assets/images/Interests/immigration.png',
  'assets/images/Interests/money.png',
];
Random rnd;

String img() {
  int min = 0;
  int max = listImagesFound.length - 1;
  rnd = new Random();
  int r = min + rnd.nextInt(max - min);
  String imageNname = listImagesFound[r].toString();
  return imageNname;
}
