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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage(
            //         'assets/images/Interests/giphy.gif'),
            //     fit: BoxFit.contain,
            //   ),
            // ),
            child: Stack(
              children: [
                Column(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/tick_icon.png',
                        fit: BoxFit.fitHeight,
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
                          fontWeight: FontWeight.bold,
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
