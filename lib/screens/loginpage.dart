import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ourvoice/assets/ov_icons.dart';
import 'package:ourvoice/config/palette.dart';
import 'package:ourvoice/screens/ForgotPassword.dart';
import 'package:ourvoice/screens/ForgotUsername.dart';
import 'package:ourvoice/screens/homepage.dart';
import 'package:ourvoice/screens/profilepage.dart';
import 'package:ourvoice/screens/signuppage.dart';
import 'package:ourvoice/widgets/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userName = TextEditingController();
  final _password = TextEditingController();
  SharedPreferences sharedPreferences;

  bool showProgressloading = false;
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool isLoading  = true;

  String count = "";

  bool loading = false;
  bool _validateUserName = false;
  bool _validatePassword = false;
  bool loadingButton = false;
  bool _isObscure = true;

  @override
  void dispose() {
    _userName.dispose();
    _password.dispose();
    super.dispose();
  }

  getActionsCount() async {
    setState(() {
      isLoading=true;
    });
    try {
      var uri = 'https://vact.tech/wp-json/wp/v2/getactioncount';
      print('uri :' + uri);
      var response = await get(Uri.parse(uri));
      final data = json.decode(response.body) as Map;
      if (data != null) {
        setState(() {
          count = data['action_count'];
          print(count);
          isLoading=false;
        });
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    getActionsCount();
  }
  // Container(
  // width: 100,
  // height: 100,
  // color: Colors.red,
  // )
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: SecondaryColor,
      body:
      GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/Interests/login_background.png'),
              fit: BoxFit.fill,
            ),
          ),
          height: height,
          width: width,
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                SizedBox(
                  height: 150.0,
                ),
                Container(
                  height: height*0.08,
                  width: width*0.4,
                  child:
                  Image.asset("assets/images/app_heading.png",),
                  // Text(
                  //   "Welcome",
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //       fontFamily: 'Open Sans',
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 32.0,
                  //       color: Color(0xFFff862e)),
                  // ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  height: 38.0,
                  width: 299.0,
                  child: Text(
                    "Make an impact on the issues you care about",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 13.0,
                        color: Colors.black),
                  ),
                ),
                isLoading==false ?
                int.parse(count) < 100 ? Container() : Text("$count Actions Taken")
                :
                    Container()
                ,
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  child: TextFormField(
                    focusNode: _emailFocusNode,
                    controller: _userName,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 16.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.black12),
                      prefixIcon: Icon(
                        OVUser.user,
                        color: Colors.black,
                        size: 20,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(color: Color(0xFFff862e), width: 2.0)),
                      errorText:
                          _validateUserName ? 'Username can\'t be empty' : null,
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      setState(() {
                        if (value.isEmpty || value == null) {
                          _validateUserName = true;
                        }
                      });
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _validateUserName = false;
                      });
                    },
                    onFieldSubmitted: (value) {
                      if (_validateUserName) {
                        FocusScope.of(context).requestFocus(_emailFocusNode);
                      }
                    },
                  ),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ]),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    child: Text(
                      'Forgot username?',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 10.0,
                        //fontWeight: FontWeight.bold,
                        //     color: Color(0xff376FDF),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotUsername()));
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: TextFormField(
                    focusNode: _passwordFocusNode,
                    controller: _password,
                    //obscureText: true,
                    obscureText: _isObscure,
                    style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 16.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.black12),
                      prefixIcon: Icon(
                        OVLock.lock,
                        color: Colors.black,
                        size: 20,
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      errorText:
                          _validatePassword ? 'Password can\'t be empty' : null,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(color: Color(0xFFff862e), width: 2.0)),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      setState(() {
                        if (value.isEmpty || value == null) {
                          _validatePassword = true;
                        }
                      });
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _validatePassword = false;
                      });
                    },
                    onFieldSubmitted: (value) {
                      if (_validatePassword) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      }
                    },
                  ),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ]),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 10.0,
                        //fontWeight: FontWeight.bold,
                        //     color: Color(0xff376FDF),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotPassword()));
                    },
                  ),
                ),
                SizedBox(
                  height: 75.0,
                ),
                loadingButton
                    ? SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator())
                    : Center(),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                    width: width,
                    height: height * 0.06,
                    padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 0.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: loading
                          ? CircularProgressIndicator()
                          : Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 16.0, color: Color(0xffffffff)),
                            ),
                      color: loadingButton ? Colors.grey : Color(0xFFff862e),
                      onPressed: () async {
                        !loadingButton
                            ? setState(() {
                                (_userName.text.isEmpty ||
                                        _userName.text == null)
                                    ? _validateUserName = true
                                    : _validateUserName = false;
                                (_password.text.isEmpty ||
                                        _password.text == null)
                                    ? _validatePassword = true
                                    : _validatePassword = false;
                                if (!_validateUserName && !_validatePassword) {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  callLoginApi();
                                  setState(() {
                                    showProgressloading =
                                        true; // then login button is pressed the circular flutter indicator will get active
                                  });
                                  // stop the Progress indicator after 5 seconds
                                  new Future.delayed(const Duration(seconds: 3),
                                      () {
                                    setState(() => showProgressloading = false);
                                  });
                                } else {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  _validatePassword
                                      ? FocusScope.of(context)
                                          .requestFocus(_passwordFocusNode)
                                      : null;
                                  _validateUserName
                                      ? FocusScope.of(context)
                                          .requestFocus(_emailFocusNode)
                                      : null;
                                }
                              })
                            : {};
                      },
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    )),
                SizedBox(
                  height: 75.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Text.rich(
                    TextSpan(text: '', children: [
                      TextSpan(
                        text: 'New here? Sign Up',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18.0,
                          //fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      )



      ,
    );
  }

  Future<void> callLoginApi() async {
    try {
      print("here" + _userName.text);
      setState(() {
        loadingButton = true;
      });
      if (_userName.text != '' && _password.text != '') {
        print(_userName.text);
        print(_password.text);
        print("password  =   "+_password.text);
        String pass = _password.text.replaceAll("#", "%23");
        print(_password.text);
        print(pass);
        var uri =
            'https://vact.tech/wp-json/wp/v2/login?username=${_userName.text}&password=${pass}';
        print('uri : ' + uri);
        var response = await post(Uri.parse(uri));
        print('response :' + response.body);
        Map data = new Map();
        Map data1 = new Map();
        data = json.decode(response.body) as Map;
        print("login page ");
        print(data);
        if (data['success'] == true) {
          print('success');
          if (data['data'] != null) {
            data1 = data['data'];
            print(data['data']);
            print(data1['data']);
            print(data1['ID']);
            var uri1 =
                'https://vact.tech/wp-json/wp/v2/get_profile?user_id=${data1['ID']}';

            print('uri : ' + uri1);
            var response1 = await post(Uri.parse(uri1));
            print('response :' + response1.body);
            Map data2 = new Map();
            Map data3 = new Map();
            String name = "";
            int id = 0;
            data2 = json.decode(response1.body) as Map;
            if (data2['success'] == true) {
              data3 = data2['data'];
              name = data3['first_name']
                      .toString()
                      .replaceAll("[", "")
                      .replaceAll("]", "") +
                  " " +
                  data3['last_name']
                      .toString()
                      .replaceAll("[", "")
                      .replaceAll("]", "");
              print(data3['first_name']);
              print(name);
              id = data1['ID'];
              print(data1['ID']);
            }
            print(data2);
            _saveProfileData(name, id);
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new App()));
          } else {
            _ackAlert(context);
          }
        } else {
          _ackAlert(context);
          print('failed');
        }
      } else {
        _alert1(context);
      }
      Timer(Duration(seconds: 1), () {
        setState(() {
          loadingButton = false;
        });
      });
    } catch (e) {
      Timer(Duration(seconds: 1), () {
        setState(() {
          loadingButton = false;
        });
      });
      print(e);
    }
  }

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Invalid Credentials',
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: const Text('Please enter the correct username and password'),
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

  Future<void> _alert1(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text(
          //   ,
          //   style: TextStyle(
          //       color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          // ),
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

  _saveProfileData(String status, int id) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      print(id);
      sharedPreferences.setString("name", status);
      sharedPreferences.setInt("ID", id);
      sharedPreferences.setString('user_login', _userName.text);
      sharedPreferences.setString('_password', _password.text);
      sharedPreferences.setBool('login', true);

      sharedPreferences.commit();
    });
  }
}
