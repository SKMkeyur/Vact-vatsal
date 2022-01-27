import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ourvoice/config/interest_config.dart';
import 'package:ourvoice/screens/SelectedInterestSection.dart';
import 'package:ourvoice/screens/signuppage.dart';
import 'package:ourvoice/screens/singnUpOtpValidationScreen.dart';
import 'package:ourvoice/widgets/submit.dart';

class SelectInterestSelection extends StatefulWidget {
  @override
  _SelectInterestSelectionState createState() =>
      _SelectInterestSelectionState();
}

class _SelectInterestSelectionState extends State<SelectInterestSelection> {
  var interest = [];
  String userInterest;

  @override
  void initState() {
    super.initState();
    for (var item in itemList) {
      item.selected = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context).settings.arguments as Todo;
    print('--------Second Last Screen------' + todo.userName);
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black38,
              size: 40.0,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 44.0,
                width: 320.0,
                alignment: Alignment.topLeft,
                child: Text(
                  "Interests",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    color: Color(0xFFff862e),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 64.0,
                width: 312.0,
                alignment: Alignment.topLeft,
                child: Text(
                  "Choose issues that you care about! What gets you fired up?",
                 // "Choose issues that you care about. This will help us recommend relevant action items for you",
                  //  textAlign: TextAlign.center,
                  style: TextStyle(
//                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  // ignore: missing_return
                  onNotification: (overscroll) {
                    overscroll.disallowGlow();
                  },
                  child: grid(context),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 43.0,
                  width: 350.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    onPressed: () {
                      if(interest.isNotEmpty){
                        setState(() {
                          userInterest = interest.join(', ');
                        });
                        callRegisterApi(
                            todo.firstName,
                            todo.secondName,
                            todo.emailOrPhone,
                            todo.psswrd,
                            todo.userName,
                            todo.dob,
                            todo.country,
                            todo.state,
                            '$userInterest');
                      }
                      else{
                        _noInterestSelectedAlert(context);
                      }
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.white),
                    ),
                    color: Color(0xFFff862e),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  )),
              /*Container(
                  height: 43.0,
                  width: 350.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    onPressed: () {
                      setState(() {
                        userInterest = intresrt.join(', ');
                      });
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SelectedInterestSection(userInterest),
                          settings: RouteSettings(
                            arguments: Todo(
                                '${todo.name}',
                                '${todo.emailOrPhone}',
                                '${todo.psswrd}',
                                '${todo.userName}',
                                '${todo.dob}',
                                '${todo.loaction}',
                                '$userInterest'),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.white),
                    ),
                    color: Color(0xFFff862e),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  )),*/
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
            builder: (context) => new Page2(),
            settings: RouteSettings(
              arguments: Todo(
                  '${todo.firstName}',
                  '${todo.secondName}',
                  '${todo.emailOrPhone}',
                  '${todo.psswrd}',
                  '${todo.userName}',
                  '${todo.dob}',
                  '${todo.country}',
                  '${todo.state}',
                  '${todo.interest}'),
            ),
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
              childAspectRatio: 0.9,
            ),
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              var item = itemList[index];
              return GestureDetector(
                onTap: () {
                  if (item.selected) {
                    setState(() {
                      item.selected = false;
                      interest.remove(item.name.toUpperCase());
                    });
                  } else {
                    setState(() {
                      item.selected = true;
                      interest.add(item.name.toUpperCase());
                    });
                  }
                  print(interest);
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

  Future<void> callRegisterApi(String firstName,String secondName, String emailOrPhone, String psswrd,
      String userName, String dob, String country,String state, String interest) async {
    print('--------Last Screen------' + interest);
    if (firstName != '' &&
        secondName != '' &&
        emailOrPhone != '' &&
        psswrd != '' &&
        userName != '' &&
        dob != '' &&
        country != '' &&
        // state != '' &&
        interest != '') {
      var uri =
          'https://vact.tech/wp-json/wp/v2/signup?first_name=$firstName&last_name=$secondName&birth_day=$dob&email=$emailOrPhone&country=$country&state=$state&user_name=$userName&password=$psswrd&interests=$interest';
      print('uri :' + uri);
      var response = await post(Uri.parse(uri));
      print(response.body);
      final data = json.decode(response.body) as Map;
      if (data['success'] == true) {
        /*Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new SubmitScreen(),
            settings: RouteSettings(
              arguments: Todo('$firstName','$secondName', '$emailOrPhone', '$psswrd', '$userName',
                  '$dob', '$country','$state', '$interest'),
            ),
          ),
        );*/

        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
            builder: (context) => new SingnUpOtpScreen(emailOrPhone),
          ),
        );
      } else {
        print('failed');
      }
    } else {
      _alert1(context);
    }
  }

  Future<void> _alert1(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Please fill the above detail.'),
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

  Future<void> _noInterestSelectedAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Choose at least one topic that makes your heart race!.'),
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
