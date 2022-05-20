import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ourvoice/screens/SelectedInterestSection.dart';
import 'package:ourvoice/screens/loginpage.dart';
import 'package:ourvoice/screens/signuppage.dart';
import 'package:ourvoice/widgets/app.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({Key key}) : super(key: key);

  @override
  _SubmitScreenState createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new App(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
  //  final todo = ModalRoute.of(context).settings.arguments as Todo;
   // print('--------Last Screen------' + todo.interest);
    return WillPopScope(
      onWillPop: () {  },
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   automaticallyImplyLeading: false,
        //   actions: <Widget>[
        //     // IconButton(
        //     //   icon: Icon(
        //     //     Icons.close,
        //     //     size: 30,
        //     //   ),
        //     //   onPressed: () => Navigator.push(
        //     //     context,
        //     //     new MaterialPageRoute(
        //     //       builder: (context) => new LoginPage(),
        //     //     ),
        //     //   ),
        //     // ),
        //   ],
        // ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new LoginPage(),
              ),
            );
          },
          child: Container(
            height: height,
            child: Stack(
              children: [
                Container(
                  height: height,
                  child: Column(
                    children: [
                      Container(
                        height: height*0.33,
                        child: Image.asset(
                          'assets/images/Interests/giphy.gif',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: height*0.33,
                        child: Image.asset(
                          'assets/images/Interests/giphy.gif',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: height*0.33,
                        child: Image.asset(
                          'assets/images/Interests/giphy.gif',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/tick_icon.png',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
