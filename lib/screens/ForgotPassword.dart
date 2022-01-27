import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ourvoice/screens/otpValidationScreen.dart';

import 'loginpage.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _formKey = GlobalKey<FormState>();
  final _secondFormKey = GlobalKey<FormState>();
  final _emailD = TextEditingController();
  final _emailFocusNodeD = FocusNode();
  var tempObject;
  bool showOtherFelds = false;
  bool showMessage = false;
  bool loadingButton = false;
  bool redirectButton = false;
  String message = '';

  final _otp = TextEditingController();

  final _password = TextEditingController();
  final _cPassword = TextEditingController();
  bool _isObscure = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: TextStyle(
              fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context, false),
          /* onPressed: () => exit(0), */
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            height: height,
            width: width,
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 40.0,
            ),
            child: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      new Image(
                        image: new AssetImage('assets/images/forget_password.png'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      TextFormField(
                        focusNode: _emailFocusNodeD,
                        controller: _emailD,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 16.0,
                            color: Colors.black),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(color: Colors.black12),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                            size: 20,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black45,width: 2.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                              BorderSide(color: Color(0xFFff862e), width: 2.0)),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                        (value.isEmpty || !validateEmail(value))
                            ? 'Invalid Email'
                            : null,
                        onFieldSubmitted: (value) {
                          if (value.isEmpty || !validateEmail(value)) {
                            FocusScope.of(context)
                                .requestFocus(_emailFocusNodeD);
                          }
                        },
                      ),
                      showMessage
                          ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Center(
                          child: Text(
                            tempObject['message'],
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                      )
                          : Center(),
                      SizedBox(
                        height: 10,
                      ),
                    loadingButton
                        ? SizedBox(
                        height: 15, width: 15, child: CircularProgressIndicator())
                        : Center(),
                      SizedBox(
                        height: 10,
                      ),
                      new RaisedButton(
                        color: loadingButton ? Colors.grey : Color(0xFFff862e),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () async {
                          !loadingButton
                              ? setState(() {
                            final FormState form =
                                _formKey.currentState;
                            if (form.validate()) {
                              print('Form is valid');
                              _formKey.currentState.save();
                              FocusScopeNode currentFocus =
                              FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              callPasswordApi(_emailD.text);
                            } else {
                              print('Form is invalid');
                              FocusScope.of(context)
                                  .requestFocus(_emailFocusNodeD);
                            }
                          })
                              : {};
                        },
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text(
                          'Send Email',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffffffff)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  String validatorPassword(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters in length';
    }
    // Return null if the entered password is valid
    return null;
  }

  String validatorConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    }
    if (value != _password.text) {
      return 'Password not match';
    }
    // Return null if the entered password is valid
    return null;
  }

  // Get the proportionate height as per screen size
  double getProportionateScreenHeight(double inputHeight) {
    double screenHeight = MediaQuery.of(context).size.height;
    // 812 is the layout height that designer use
    return (inputHeight / 812.0) * screenHeight;
  }

// Get the proportionate height as per screen size
  double getProportionateScreenWidth(double inputWidth) {
    double screenWidth = MediaQuery.of(context).size.width;
    // 375 is the layout width that designer use
    return (inputWidth / 375.0) * screenWidth;
  }

  Future<void> callPasswordApi(String email) async {
    try {
      setState(() {
        loadingButton = true;
        showMessage = false;
      });
      var uri =
          'https://vact.tech/wp-json/wp/v2/forget_password?email=${email}';
      print(uri);
      var response = await post(Uri.parse(uri));
      print('response :' + response.body);
      tempObject = json.decode(response.body) as Map;
      //print(tempObject['message']);
     // _otp.text = tempObject['otp'].toString();
      if(tempObject['otp'].toString()!=null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PasswordChangeScreen(email: _emailD.text,otp: tempObject['otp'].toString(),tempObject: tempObject['ID'].toString(),)));
      }
      Timer(Duration(seconds: 1), () {
        setState(() {
          loadingButton = false;
          showMessage = true;
        });
      });
      Timer(Duration(seconds: 3), () {
        setState(() {
          showOtherFelds = tempObject['success'];
          //print(showOtherFelds);
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

  Future<void> callResetPasswordApi(
      String email, String password, String otp) async {
    try {
      setState(() {
        loadingButton = true;
        showMessage = false;
      });
      var userId = tempObject['ID'];
      var uri =
          'https://vact.tech/wp-json/wp/v2/verify_otp?email=${email}&user_id=${userId}&otp=${otp}&password=${password}';
      //print(uri);
      var response = await post(Uri.parse(uri));
      //print('response :' + response.body);
      Map data = json.decode(response.body) as Map;
      message = data['message'];
      Timer(Duration(seconds: 1), () {
        setState(() {
          loadingButton = false;
          showMessage = true;
          redirectButton = data['success'];
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

}