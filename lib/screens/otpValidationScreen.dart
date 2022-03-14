import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ourvoice/screens/loginpage.dart';

class PasswordChangeScreen extends StatefulWidget {

  final String email;
  final String otp;
  final String tempObject;
  const PasswordChangeScreen({Key key, this.email, this.otp,this.tempObject}) : super(key: key);

  @override
  _PasswordChangeScreenState createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {

  final _secondFormKey = GlobalKey<FormState>();

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
  void initState() {
    super.initState();
    // if(!redirectButton){
    // }else{
    //
    // }

    //_otp.text = widget.otp;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double safe = MediaQuery.of(context).padding.top;
    double height1=height-safe;

    return Scaffold(

      // appBar:
      // !redirectButton ?
      // AppBar(
      //   title: Text(
      //     'Update Password',
      //     style: TextStyle(
      //         fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w600),
      //   ),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   automaticallyImplyLeading: true,
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back_ios_outlined,
      //       color: Colors.black,
      //     ),
      //     onPressed: () => Navigator.pop(context, false),
      //     /* onPressed: () => exit(0), */
      //   ),
      // )
      //     :
      // PreferredSize(preferredSize: Size(0.0, 0.0),child: Container(),)


      body: !redirectButton
          ? SingleChildScrollView(
            child: Form(
        key: _secondFormKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AppBar(
                  title: Text(
                    'Update Password',
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
                SizedBox(
                  height: 20,
                ),
                new Image(
                  image: new AssetImage('assets/images/forget_password.png'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text("OTP has been sent to "+widget.email,style: TextStyle(color: Color(0xFFff862e),fontWeight: FontWeight.w600),)
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "Verification",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
                TextFormField(
                  controller: _otp,
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 16.0,
                      color: Colors.black),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Enter Verification Code',
                    hintStyle: TextStyle(color: Colors.black12),
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
                  (value.isEmpty) ? 'Verification Code is required' : null,
                ),
                SizedBox(height: 10.0,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "Password",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
                TextFormField(
                  controller: _password,
                  keyboardType: TextInputType.visiblePassword,
                  autofocus: false,
                  obscureText: true,
                  style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 16.0,
                      color: Colors.black),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Must be at least 6 characters',
                    hintStyle: TextStyle(color: Colors.black12),
                    prefixIcon: Icon(
                      Icons.lock,
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
                  validator: (value) => (value.isEmpty ||
                      validatorPassword(value) != null)
                      ? validatorPassword(value)
                      : null,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "Confirm Password",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
                TextFormField(
                  controller: _cPassword,
                  keyboardType: TextInputType.visiblePassword,
                  autofocus: false,
                  obscureText: _isObscure,
                  style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 16.0,
                      color: Colors.black),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Must be at least 6 characters',
                    hintStyle: TextStyle(color: Colors.black12),
                    prefixIcon: Icon(
                      Icons.lock,
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
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.black45,width: 2.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                        BorderSide(color: Color(0xFFff862e), width: 2.0)),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) => (value.isEmpty ||
                      validatorConfirmPassword(value) != null)
                      ? validatorConfirmPassword(value)
                      : null,
                ),
                SizedBox(
                  height: 10,
                ),
                showMessage
                    ? Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      message,
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
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator())
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
                          _secondFormKey.currentState;
                      if (form.validate()) {
                        print('Form is valid');
                        _secondFormKey.currentState.save();
                        FocusScopeNode currentFocus =
                        FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        callResetPasswordApi(widget.email,
                            _password.text, _otp.text,widget.tempObject);
                      }
                    })
                        : {};
                  },
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Text(
                    //'Reset Password',
                    'Update Password',
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
          )
          : GestureDetector(
         behavior: HitTestBehavior.opaque,
           onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new LoginPage(),
            ),
          );
        },
            child: Center(
        child: Container(
            height: height,
            width: width,
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

                Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/tick_icon.png",
                          height: 100, //40%
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Visibility(
                        visible: false,
                        child: ElevatedButton(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffffffff),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => new LoginPage(),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
        ),
      ),
          ),
    );
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

  Future<void> callResetPasswordApi(
      String email, String password, String otp,String userId) async {
    try {
      setState(() {
        loadingButton = true;
        showMessage = false;
      });
      //String userId = tempObject;
      var uri =
          'https://vact.tech/wp-json/wp/v2/verify_otp?email=${email}&user_id=${userId}&otp=${otp}&password=${password}';
      print(uri);
      var response = await post(Uri.parse(uri));
      print('response :' + response.body);
      Map data = json.decode(response.body) as Map;
      message = data['message'];
      Timer(Duration(seconds: 1), () {
        setState(() {
          loadingButton = false;
          showMessage = true;
          redirectButton = data['success'];
        });
      });
      Timer(Duration(seconds: 3), () {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new LoginPage(),
          ),
        );
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
