import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'config/palette.dart';
import 'widgets/checklogin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Our Voice',
      theme: ThemeData(
        fontFamily: GoogleFonts.openSans().fontFamily,
        primarySwatch: createMaterialColor(
          Color(0xFFff862e),
        ),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CheckPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
