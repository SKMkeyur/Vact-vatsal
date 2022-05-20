import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:ourvoice/model/countryModel.dart';
import 'package:ourvoice/screens/SelectInterestSelection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todo {
  final String firstName;
  final String secondName;
  final String emailOrPhone;
  final String psswrd;
  final String userName;
  final String dob;
  final String country;
  final String state;
  final String interest;

  Todo(
    this.firstName,
    this.secondName,
    this.emailOrPhone,
    this.psswrd,
    this.userName,
    this.dob,
    this.country,
    this.state,
    this.interest,
  );
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SharedPreferences sharedPreferences;

  final firstName = TextEditingController();
  final secondName = TextEditingController();
  final emailOrPhone = TextEditingController();
  final psswrd = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isEmail(String input) => RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(input);


  void _loadCounter(phone,identifier) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString(identifier, phone);
    });
  }


  bool showPass = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 44.0,
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Getting Started",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 32.0,
                        color: Color(0xFFff862e),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 21.0,
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    child: Text(
                      "First, we want to learn more about you!",
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    height: 20.0,
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    child: Text(
                      "First Name",
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 05.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: firstName,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'First Name',
                        hintStyle: TextStyle(color: Colors.black12),
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
                          return 'Let us know your first name!';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 20.0,
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Last Name",
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 05.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: secondName,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Last Name',
                        hintStyle: TextStyle(color: Colors.black12),
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
                          return 'Don\'t forget to share your last name!';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 20.0,
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    child: Text(
                      /* "Email or phone number", */
                      "Email",
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 05.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      inputFormatters: [],
                      controller: emailOrPhone,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        /* hintText: 'Email or phone number', */
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.black12),
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
                        if (!isEmail(value)) {
                            return 'Please enter a valid email';
                          }
                        return null;
                      },
                      // MultiValidator([
                      //   RequiredValidator(errorText: "We might slide into your inbox to say hi."),
                      //   EmailValidator(errorText: "Enter Valid Email.")
                      // ]),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 20.0,
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Set Your Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 05.0,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 50.0),
                    child: TextFormField(

                      controller: psswrd,
                      obscureText: !showPass,
                      decoration: InputDecoration(
                        errorMaxLines: 2,
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Set Your Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPass = !showPass;
                            });
                            print(showPass);
                          },
                          icon: Icon(
                            showPass
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.black12,
                          ),
                        ),
                        hintStyle: TextStyle(color: Colors.black12),
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
                          return 'Password should be at least 6 characters with at least one symbol (\$, #, %) and one number';
                        }
                        if (!(value.contains("\$") || value.contains("#") || value.contains("%"))){
                          return "Password should have atlest \$, # or %";
                        }else if(!value.contains(new RegExp(r'[0-9]'))){
                          return "Password should have atlest one number";
                        }else if(value.length<6){
                          return "Password should have atlest six characters";
                        }
                        return null;
                      },
                    ),
                  ),
                ]
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 43.0,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(top: 50.0),
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              bool status = await emailIdValidation(emailOrPhone.text, context);
              if (status) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Page2(),
                    settings: RouteSettings(
                        arguments: Todo('${firstName.text}','${secondName.text}', '${emailOrPhone.text}',
                            '${psswrd.text}', '', '', '','', '')),
                  ),
                );
              }
            } else {
              return;
            }
            print(_formKey.currentState.validate());
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
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<bool> emailIdValidation(String userName, BuildContext context) async {
    try {
      var uri =
          'https://vact.tech/wp-json/wp/v2/check_email?email=$userName';
      print('uri :' + uri);
      var response = await post(Uri.parse(uri));
      print(response.body);
      final data = json.decode(response.body) as Map;

      if (data['success'] == true) {
      } else {
        _duplicateAlert(context);
      }
      return data['success'];
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> _duplicateAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('This email has already been registered'),
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

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final userName = TextEditingController();

  final dob = TextEditingController();

  final loaction = TextEditingController();

  final _secondFormKey = GlobalKey<FormState>();

  List<CountryModel> countryModelList = [];
  List<StateModel> stateModelList = [];

  bool showPass = false;
  bool isCheck = false;


  String country = "Select Country";
  String state = "Select State";

  var bDateValue = "";

  DateTime selectedDate = DateTime.now();
  DateTime currentDate = DateTime.now();
  final df = new DateFormat('MM-dd-yyyy');
  final senddf = new DateFormat('MM-dd-yyyy');
  bool editDate = true;

  Future getCountryList() async{
    try {
      var uri =
          'https://vact.tech/wp-json/wp/v2/getcountries';
      print('uri :' + uri);
      var response = await get(Uri.parse(uri));
      final data = json.decode(response.body) as Map;
      if(data['status']==true){
        for(var country in data['data']){
          countryModelList.add(CountryModel(
            countryName: country['name'],
            id: country['id'],
            sortName: country['sortname'],
            phoneCode: country['phonecode']
          ));
        }
        country = countryModelList[countryModelList.indexWhere((element) => element.countryName=="United States")].countryName;
        getStateList(countryModelList[countryModelList.indexWhere((element) => element.countryName=="United States")].id);
        setState(() {});
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future getStateList(String countryId) async{
    try {
      var uri =
          'https://vact.tech/wp-json/wp/v2/getstatebycountry?country_id=$countryId';
      print('uri :' + uri);
      var response = await get(Uri.parse(uri));
      final data = json.decode(response.body) as Map;
      stateModelList.clear();
      if(data['status']==true){
        for(var state in data['data']){
          stateModelList.add(StateModel(
            id: state['id'],
            countryId: state['country_id'],
            stateName: state['name']
          ));
        }
        state = stateModelList[0].stateName;
        setState(() {});
      }else{
        state = "";
      }

    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    getCountryList();
  }

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context).settings.arguments as Todo;
    print('--------Second Screen------' + todo.firstName);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _secondFormKey,
          child: SingleChildScrollView(
            child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 44.0,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "About you",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 32.0,
                      color: Color(0xFFff862e),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 21.0,
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child: Text(
                    //"Almost there, just a few more things.",
                    "Almost there! Just a few more things about you",
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  height: 20.0,
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Choose a username",
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 05.0,
                ),
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: userName,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.black12),
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
                        return 'Field must not be empty';
                      }
                      else if(!RegExp(r'^[a-zA-Z0-9_.]+$').hasMatch(value)){
                        return "only . and _ is allowed as special character";
                      }else if(value.length < 6){
                        return "you have to enter at least 6 characters";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 20.0,
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "What is your date of birth?",
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 05.0,
                ),
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: dob,
                    keyboardType: TextInputType.datetime,
                    readOnly: true,

                   // enabled: editDate,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'mm-dd-yyyy',
                      hintStyle: TextStyle(color: Colors.black12),
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
                    onChanged: (value){
                      if(value.length!=0){
                        if (!bDateValue.contains(value)) {
                          if (value.length == 2 || value.length == 5) {
                            value = value + "-";
                            dob.text = value;
                            dob.selection = TextSelection.fromPosition(
                                TextPosition(offset: dob.text.length));
                            bDateValue = value;
                          }
                        }
                      }
                      else{
                        bDateValue = "";
                      }
                    },
                    onTap: () {
                      editDate=false;
                      _selectDate(context);
                    },
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'When is your birthday?';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 20.0,
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Country",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 05.0,
                ),
                countryModelList.isNotEmpty ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(5.0),
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    value: country,
                    icon: Icon(Icons.arrow_drop_down),
                    items: countryModelList.map(
                            (e) => DropdownMenuItem(
                              value: e.countryName,
                              child: Text(
                                e.countryName
                              ),
                            ),
                    ).toList(),
                    onChanged: (value){
                      setState(() {
                        country = value;
                        print(country);
                        if(country.toString() == "United States") {
                          getStateList(
                              countryModelList[countryModelList.indexWhere((
                                  element) => element.countryName == country)]
                                  .id);
                        }else{
                          stateModelList.clear();
                        }
                      });
                    },
                  ),
                ) : Container(),
                SizedBox(
                  height: 20.0,
                ),
                stateModelList.isNotEmpty ?Container(
                  height: 20.0,
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "State",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 15.0,
                    ),
                  ),
                ) : Container(),
                SizedBox(
                  height: 05.0,
                ),
                stateModelList.isNotEmpty ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(5.0),
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    value: state,
                    icon: Icon(Icons.arrow_drop_down),
                    items: stateModelList.map(
                            (e) => DropdownMenuItem(
                              value: e.stateName,
                              child: Text(
                                e.stateName
                              ),
                            ),
                    ).toList(),
                    onChanged: (value){
                      setState(() {
                        state = value;
                      });
                    },
                  ),
                ) : Container(),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isCheck,
                      onChanged: (value){
                        setState(() {
                          isCheck = value;
                        });
                      },
                    ),
                    Flexible(
                      /*child: Text(
                          "Given, Information are true and reliable. and I confirm that i am above 13 years.",
                      ),*/
                      child: InkWell(

                        onTap: (){
                          setState(() {
                            isCheck = !isCheck;
                          });
                        },
                        child: Text(
                           // "Confirm that you're above the age of 13.",
                          //"Confirm that you're at least 13 years old",
                          //"I can confirm I am 13 years or older",
                          "Confirm you're above the age of 13"
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 43.0,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          onPressed: () async {
            if(isCheck){
              if (_secondFormKey.currentState.validate()) {
                bool ageRestrict = false;
                int year = int.parse(dob.text.split("-").last);
                int currentYear = DateTime.now().year.toInt();
                if(userName.text.toString().length < 6){
                  //_alert(context, "Your age is below 13.");
                }
                //else if (currentYear - year >= 13) {
                else if (currentYear - year <= 13) {
                  //ageRestrict = true;
                  _alert(context, "Your age is below 13");
                }else{
                //if (ageRestrict) {

                  bool status =
                      await userNameValidation(userName.text, context);
                  if (status) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SelectInterestSelection(),
                        settings: RouteSettings(
                            arguments: Todo(
                                '${todo.firstName}',
                                '${todo.secondName}',
                                '${todo.emailOrPhone}',
                                '${todo.psswrd}',
                                '${userName.text}',
                                '${dob.text}',
                                '$country',
                                '$state',
                                '')),
                      ),
                    );
                  }
                }
               /* else {
                  _alert(context, "Your age is below 13.");
                }*/
              } else {
                return;
              }
              print(_secondFormKey.currentState.validate());
            }
            else{
             // _alert(context, "Please select the checkbox to Confirm that you're above the age of 13.");
              _alert(context, "Please select the checkbox to Confirm that you're at least 13 years old.");
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
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<bool> userNameValidation(String userName, BuildContext context) async {
    try {
      var uri =
          'https://vact.tech/wp-json/wp/v2/check_username?user_name=$userName';
      print('uri :' + uri);
      var response = await post(Uri.parse(uri));
      print(response.body);
      final data = json.decode(response.body) as Map;

      if (data['success'] == true) {
      } else {
        _alert(context,'This Username is Already Registered');
      }
      return data['success'];
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> _alert(BuildContext context,String alertString) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(alertString),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        //firstDate: DateTime.now(),
        firstDate: DateTime(1900, 01, 01),
        lastDate: DateTime(
            currentDate.year, currentDate.month, currentDate.day));
    if (picked != null && picked != selectedDate)
      setState(() {
        editDate = true;
        selectedDate = picked;
        print("...Date select..$selectedDate");

        dob.text = df.format(selectedDate);

      });
  }
}
