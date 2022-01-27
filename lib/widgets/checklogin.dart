import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ourvoice/screens/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ourvoice/widgets/app.dart';

class CheckPage extends StatefulWidget {
  CheckPage({Key key}) : super(key: key);
  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  SharedPreferences sharedPreferences;
  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  String login;

  String count;

  @override
  void initState() {
    super.initState();
    getProfileData();
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<void> getProfileData() async {
    final SharedPreferences prefs = await _sprefs;
    bool login = (prefs.getBool("login") ?? false);
    if (login) {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => new App()));
    } else {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new LoginPage()));
    }
  }
}
