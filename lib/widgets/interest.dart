import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ourvoice/config/interest_config.dart';
import 'package:ourvoice/config/palette.dart';
import 'package:ourvoice/screens/homepage.dart';
import 'package:ourvoice/screens/profilepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeInterestSelection extends StatefulWidget {
  final String interests;
  final String callFrom;
  ChangeInterestSelection(this.interests, this.callFrom);

  @override
  _ChangeInterestSelectionState createState() =>
      _ChangeInterestSelectionState();
}

class _ChangeInterestSelectionState extends State<ChangeInterestSelection> {
  var intresrt = [];
  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    for (var item in itemList) {
      item.selected = false;
    }
    print(widget.interests);
    intresrt = widget.interests.toUpperCase().split(', ');
    for (var item in itemList) {
      if (intresrt.contains(item.name.toUpperCase())) {
        item.selected = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Change Interests',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Choose issues that you care about! What gets you fired up?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overscroll) {
                    overscroll.disallowGlow();
                    return true;
                  },
                  child: grid(context),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: kToolbarHeight,
                  child: FlatButton(
                    onPressed: () {
                      callUpdateInterestApi();
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    color: ProfileOrangeColor,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: ProfileOrangeColor,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new ProfilePage(),
          ),
        );
        return false;
      },
    );
  }

  Widget grid(BuildContext context) {
    return itemList.length > 0
        ? GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.9
            ),
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              var item = itemList[index];
              return GestureDetector(
                onTap: () {
                  if (item.selected) {
                    setState(() {
                      item.selected = false;
                      intresrt.remove(item.name.toUpperCase());
                    });
                  } else {
                    setState(() {
                      item.selected = true;
                      intresrt.add(item.name.toUpperCase());
                    });
                  }
                  print(intresrt);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: item.selected ? item.backgrdColor : Colors.white,
                    border: Border.all(width: 1, color: Colors.grey[300]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Center(
                        child: Image.asset(
                          item.path,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Center(
                        child: Text(
                          item.name.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : Center(
            child: const Text(
              'No Data Found',
              style: TextStyle(color: Color(0XFF808080), fontSize: 20.0),
            ),
          );
  }

  Future<void> callUpdateInterestApi() async {
    try {
      final SharedPreferences prefs = await _sprefs;
      String userId = prefs.getInt("ID").toString();

      if(intresrt.isNotEmpty){
        String allInterest = intresrt.join(', ');
        print(allInterest);
        var uri =
            'https://vact.tech/wp-json/wp/v2/update_profile_interest?user_id=$userId&user_interests=$allInterest';
        print('uri : ' + uri);
        var response = await post(Uri.parse(uri));
        log('response :' + response.body);
        Map data = new Map();
        data = json.decode(response.body) as Map;
        if (data['success']) {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new ProfilePage(),
            ),
          );
        }
      }
      else{
        _noInterestSelectedAlert(context);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _noInterestSelectedAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Select at least one Issue.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok', style: TextStyle(color: Color(0xff042e4d))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
