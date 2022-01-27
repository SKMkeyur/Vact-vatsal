import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ourvoice/screens/SelectedInterestSection.dart';
import 'package:ourvoice/screens/loginpage.dart';
import 'package:ourvoice/screens/signuppage.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({Key key}) : super(key: key);

  @override
  _SubmitScreenState createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  @override
  void initState() {
    super.initState();

    // Timer(Duration(seconds: 1), () {
    //   Navigator.push(
    //     context,
    //     new MaterialPageRoute(
    //       builder: (context) => new LoginPage(),
    //     ),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
  //  final todo = ModalRoute.of(context).settings.arguments as Todo;
   // print('--------Last Screen------' + todo.interest);
    return WillPopScope(
      onWillPop: () {  },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.close,
                size: 30,
              ),
              onPressed: () => Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new LoginPage(),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/icegif.gif',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'Welcome to Vact!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "Now let's go take action!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
