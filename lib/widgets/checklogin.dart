import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ourvoice/ip_service.dart';
import 'package:ourvoice/screens/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ourvoice/widgets/app.dart';
import 'package:http/http.dart' as http;

import 'homepage_act.dart';

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
      const url = 'https://api.ipify.org';
      final response = await http.get(Uri.parse(url));
      print("-----");
      print(response.body);
      print("------");
      String ip1 = response.body;
      String url1 = "https://vact.tech/wp-json/wp/v2/get_news_id_by_ip?user_ip="+ip1;
      var response1 = await http.get(Uri.parse(url1));
      print(response1.body);
      String nullChecker = response1.body.toString().substring(27,31);
      if(nullChecker=="null"){
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => new App()));
      }else{

        Ip ip = ipFromJson(response1.body);
        print(ip);
        String newsId = "";
        if(ip.data!=null && int.parse(ip.data.userId)!=-1 && int.parse(ip.data.newsId)!=-1){
          newsId = ip.data.newsId;
          print(newsId);
          print(ip.data.userId);
          var response22 = await http.get(Uri.parse("https://vact.tech/wp-json/wp/v2/share_action?act_id=-1&user_id=-1"));
          Navigator.push(context,  MaterialPageRoute(
            builder: (context) => TakeAction(newsId, ip.data.userId),
          ));
        }else{
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => new App()));
        }
      }




    } else {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new LoginPage()));
    }
  }
}
