import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ourvoice/config/palette.dart';

import 'app.dart';

class CompletedScreen extends StatefulWidget {
  final String postType;

  CompletedScreen(this.postType);

  @override
  _CompletedScreenState createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
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
    return WillPopScope(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   automaticallyImplyLeading: false,
        //   actions: <Widget>[
        //     IconButton(
        //       icon: Icon(
        //         Icons.close,
        //         size: 30,
        //       ),
        //       onPressed: () => Navigator.push(
        //         context,
        //         new MaterialPageRoute(
        //           builder: (context) => new App(),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        body:

        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new App(),
              ),
            );
          },
          child: Container(
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
                    widget.postType == 'Completed' ? 'I Completed!' : 'Posted!',
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
                    widget.postType == 'Completed'
                        ? 'Thank you for taking action'
                        : 'Your action has been shared.',
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
      ),
      onWillPop: () async {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new App(),
          ),
        );
        return false;
      },
    );
  }
}
