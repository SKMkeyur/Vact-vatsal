import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ourvoice/config/palette.dart';
import 'package:ourvoice/constants/colors.dart';
import 'package:ourvoice/widgets/app.dart';
import 'package:ourvoice/widgets/success.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String _chosenValue;

  final postName = TextEditingController();
  final actionType = TextEditingController();
  final description = TextEditingController();
  final attachLink = TextEditingController();
  var movements = [];

  bool movementError = false;

  final _formKey = GlobalKey<FormState>();
  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();

  List typeList = [
    {'name': "Racial Justice".toString().toUpperCase()},
    {'name': "Religious Justice".toString().toUpperCase()},
    {'name': "Climate Change".toString().toUpperCase()},
    {'name': "COVID-19".toString().toUpperCase()},
    {'name': "Gun Control".toString().toUpperCase()},
    {'name': "Women’s Rights".toString().toUpperCase()},
    {'name': "LBGTQ+ Rights".toString().toUpperCase()},
    {'name': "Immigration".toString().toUpperCase()},
    {'name': "Mental Health".toString().toUpperCase()},
    {'name': "EDUCATION".toString().toUpperCase()},
    {'name': "Healthcare".toString().toUpperCase()},
    {'name': "ECONOMY".toString().toUpperCase()},
  ];

  @override
  void initState() {
    super.initState();
    postName.text = '';
    actionType.text = '';
    description.text = '';
    attachLink.text = '';
    movements = [];
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
      //  backgroundColor: Color.fromRGBO(229, 229, 229, 0.2),
        appBar: AppBar(
          //backgroundColor: Color.fromRGBO(229, 229, 229, 0.2),
          backgroundColor: LightOrange,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Post an Action',
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFff862e)),
            ),
          ),
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
                  builder: (context) => new App(),
                ),
              ),
            ),
          ],
        ),
        body: Container(
            color: LightOrange,
            child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
            return true;
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Name your Post',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: postName,
                      keyboardType: TextInputType.text,
                      maxLength: 100,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Your text here',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.black12, width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 1.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.black12, width: 1.0),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Create a compelling call to action!';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    //'Choose the action type',
                    'Choose the Action Type',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: DropdownButtonFormField(
                      value: _chosenValue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.black12, width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 1.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.black12, width: 1.0),
                        ),
                      ),
                      items: <String>[
                        'Petition',
                        'Donate',
                        'Email',
                        'Call',
                        'Event',
                        'Other',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: value.toString() == _chosenValue ? Colors.blue : Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        setState(() {
                          actionType.text = value;
                          _chosenValue = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Choose the one that best describes your action!';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Description of Action item',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Share what users need to do to complete this action',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    controller: description,
                    maxLines: 10,
                    maxLength: 1000,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Your text here',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Colors.black12, width: 1.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Colors.redAccent, width: 1.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Colors.redAccent, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Colors.black12, width: 1.0),
                      ),
                    ),
                    textInputAction: TextInputAction.newline,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Include context or instructions for others!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    //'Attach link',
                    'Attach Link',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: attachLink,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText:
                            'Add link to petition, phone number, event, etc',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.black12, width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 1.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.black12, width: 1.0),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Hey! Share a valid link, phone number, etc';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'What movement is this action helping?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Select the topic that are related to your action!",
                    style: TextStyle(
                      color: movementError ? Colors.green : Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: _buildHorizontalTile(),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: kToolbarHeight,
                      child: FlatButton(
                        onPressed: () {
                          callSavePostApi();
                        },
                        child: Text(
                          'Post',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        color: CompletedGreenButtonColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: CompletedGreenButtonColor,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        )),
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

  Widget _buildHorizontalTile() {
    // return GridView.builder(
    //   shrinkWrap: true,
    //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    //     maxCrossAxisExtent: 200,
    //     mainAxisExtent: 50,
    //     mainAxisSpacing: 4,
    //     crossAxisSpacing: 2,
    //   ),
    //   physics: NeverScrollableScrollPhysics(),
    //   itemCount: typeList.length,
    //   itemBuilder: (context, index) {
    //     var item = typeList[index];
    //     return GestureDetector(
    //       onTap: () {
    //         setState(() {
    //           if (movements.contains(item['name'])) {
    //             movements.remove(item['name']);
    //           } else {
    //             if (movements.length < 3) {
    //               movements.add(item['name']);
    //             }
    //           }
    //           print(movements);
    //         });
    //       },
    //       child: Card(
    //         color: Color.fromRGBO(229, 229, 229, 0.2),
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.all(
    //             Radius.circular(25.0),
    //           ),
    //           side: new BorderSide(
    //               color: movements.contains(item['name'])
    //                   ? CompletedGreenButtonColor
    //                   : InputGreyBorderColor,
    //               width: 1.0),
    //         ),
    //         elevation: 0,
    //         child: Center(
    //           child: Container(
    //             padding: EdgeInsets.symmetric(
    //               horizontal: 10,
    //             ),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   Padding(
    //                     padding: EdgeInsets.only(
    //                       right: 5,
    //                     ),
    //                     child: Icon(
    //                       Icons.check,
    //                       color: InputGreyBorderColor,
    //                       size: 18,
    //                     ),
    //                   ),
    //                   Text(
    //                     item['name'],
    //                     style: TextStyle(
    //                       color: Colors.black,
    //                       fontSize: 11,
    //                       fontWeight: FontWeight.w400,
    //                     ),
    //                     maxLines: 1,
    //                     overflow: TextOverflow.ellipsis,
    //                   ),
    //                 ],
    //               ),
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      children: typeList.map(
              (e) => GestureDetector(
                onTap: (){
                  setState(() {
                    if (movements.contains(e['name'])) {
                      movements.remove(e['name']);
                    } else {
                      if (movements.length < 3) {
                        movements.add(e['name']);
                      }
                    }
                    print(movements);
                  });
                },
                child: Card(
                //  color: Color.fromRGBO(229, 229, 229, 0.2),
                  color: movements.contains(e['name'])
                      ? NewCompletedGreenButtonColor
                      : Color.fromRGBO(229, 229, 229, 0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                    side: new BorderSide(
                        color: movements.contains(e['name'])
                            ? NewCompletedGreenButtonColor
                            : InputGreyBorderColor,
                        width: 1.0),
                  ),
                  elevation: 0,
                  child: Container(
                    height: 40.0,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: 5,
                          ),
                          child: Icon(
                            Icons.check,
                            color: movements.contains(e['name'])
                                ? Colors.white
                                : InputGreyBorderColor,
                            size: 18,
                          ),
                        ),
                        Text(
                          e['name'],
                          style: TextStyle(
                            color: movements.contains(e['name'])
                                ? Colors.white
                                : Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ).toList(),
    );
  }

  Future<void> callSavePostApi() async {
    try {
      setState(() {
        movementError = false;
      });
      if (_formKey.currentState.validate() && movements.length > 0) {
        final SharedPreferences prefs = await _sprefs;
        String userId = prefs.getInt("ID").toString();
        String userName = prefs.getString("user_login").toString();
        String allMovement = movements.join(', ');

        var uri =
            'https://vact.tech/wp-json/wp/v2/save_action_post?user_id=$userId&post_name=${postName.text}&action_type=${actionType.text}&desc_action_item=${description.text}&attach_link=${attachLink.text}&user_name=$userName&movement_name=$allMovement';
        print('uri : ' + uri);
        var response = await post(Uri.parse(uri));
        log('response :' + response.body);
        Map data = new Map();
        data = json.decode(response.body) as Map;

        if (data['success']) {
          Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(
              builder: (context) => CompletedScreen('Posted'),
            ),
          );
        }
      } else {
        if (movements.length == 0) {
          setState(() {
            movementError = true;
          });
        }
        print('ok' + movementError.toString());
      }
    } catch (e) {
      print(e);
    }
  }
}
