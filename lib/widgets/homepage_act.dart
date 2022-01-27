import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ourvoice/config/palette.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_url_preview/simple_url_preview.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app.dart';
import 'success.dart';

class TakeAction extends StatefulWidget {
  final String id;
  final String userId;


  TakeAction(this.id, this.userId);

  @override
  _TakeActionState createState() => _TakeActionState();
}

class _TakeActionState extends State<TakeAction> {
  List typeList = [];
  bool isCheck = false;
  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();

  bool loading = false;

  String postName, description, userName, attachLink;

  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    callGetPostApi();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final style = TextStyle(
    color: Colors.red,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.375,
  );

  @override
  Widget build(BuildContext context) {
    var toolBar = (MediaQuery.of(context).padding.top + kToolbarHeight);
    var height = MediaQuery.of(context).size.height - toolBar;
    return WillPopScope(
      child: ModalProgressHUD(
        inAsyncCall: loading,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppBarOrangeColor,
            elevation: 0,
            toolbarHeight: 40,
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
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppBarOrangeColor,
                      Color(0xFFF0F0F0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.3,
                      0.6,
                    ],
                  ),
                ),
                width: double.infinity,
                padding: EdgeInsets.only(
                  right: 25,
                  left: 25,
                  bottom: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    postName == null
                        ? Shimmer.fromColors(
                            baseColor: Color(0xFFEBEBF4),
                            highlightColor: Color(0xFFF4F4F4),
                            child: Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width / 2,
                              color: Theme.of(context).hintColor.withAlpha(170),
                            ),
                          )
                        : Text(
                            postName,
                            maxLines: 3,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                    SizedBox(
                      height: 5,
                    ),
                    userName == null
                        ? Shimmer.fromColors(
                            baseColor: Color(0xFFEBEBF4),
                            highlightColor: Color(0xFFF4F4F4),
                            child: Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width / 3,
                              color: Theme.of(context).hintColor.withAlpha(170),
                            ),
                          )
                        : Text(
                            'posted by ' + userName,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                  ],
                ),
              ),
              Positioned(
                top: toolBar + 40,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: height - 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5, vertical: 15.0),
                          child: _buildHorizontalTile(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: Text(
                            'Description of Action Item',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: OrangeBoxColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(6.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: description == null
                                ? Shimmer.fromColors(
                                    baseColor: Color(0xFFEBEBF4),
                                    highlightColor: Color(0xFFF4F4F4),
                                    child: Container(
                                      height: 30,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      color: Theme.of(context)
                                          .hintColor
                                          .withAlpha(170),
                                    ),
                                  )
                                : Text(
                                    description,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                            bottom: 10,
                          ),
                          child: Text(
                            'Link',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        attachLink == null
                            ? Shimmer.fromColors(
                                baseColor: Color(0xFFEBEBF4),
                                highlightColor: Color(0xFFF4F4F4),
                                child: Container(
                                  height: 30,
                                  width: MediaQuery.of(context).size.width / 3,
                                  color: Theme.of(context)
                                      .hintColor
                                      .withAlpha(170),
                                ),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  if (!isCompleted) {
                                    var url = attachLink.contains("http") ? attachLink : "http://" + attachLink;
                                    //var url = "https://pub.dev/packages/simple_url_preview";

                                    if (await canLaunch(url)) await launch(url);
                                    setState(() {
                                      isCompleted = true;
                                    });
                                  }
                                },
                                child: Text(
                                  attachLink,
                                  style: TextStyle(
                                    color: LinkBlueColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                        attachLink != null
                            ? attachLink.contains(".")
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    child: SimpleUrlPreview(
                                      //url: "http://" + attachLink,
                                      url: attachLink.contains("http") ? attachLink : "http://" + attachLink,
                                      bgColor: Colors.grey[200],
                                      previewHeight: MediaQuery.of(context).size.height/4,
                                      titleLines: 1,
                                      descriptionLines: 2,
                                      titleStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      descriptionStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                      siteNameStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.blue,
                                      ),
                                      onTap: () async {
                                       // var url = "http://" +attachLink;
                                        var url = attachLink.contains("http") ? attachLink : "http://" + attachLink;
                                        if (await canLaunch(url))
                                          await launch(url);
                                        setState(() {
                                          isCompleted = true;
                                        });
                                      },
                                    ),
                                  )
                                : Container()
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: Container(
            width: MediaQuery.of(context).size.width * 0.90,
            height: 100,
            //alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(!isCompleted)Row(
                  children: [
                    Checkbox(
                      value: isCheck,
                      onChanged: (value){
                        setState(() {
                          isCheck = value;
                        });
                      },
                    ),
                    Expanded(
                      /*child: Text(
                          "Given, Information are true and reliable. and I confirm that i am above 13 years.",
                      ),*/
                      child: Text(
                        // "Confirm that you're above the age of 13.",
                        //"Confirm that you're at least 13 years old",
                        "I certify that i took this action",
                      ),
                    ),
                  ],
                ),
                FlatButton(
                  onPressed: () {
                    if(!isCompleted ) {
                      isCheck ?
                        callUpdatePostApi()
                      : _alert(context,"Please confirm if you took this action by clicking the checkbox");

                    }
                  },
                  child: Text(
                    !isCompleted ? 'Complete' : 'Completed',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  color: isCompleted
                      ? Colors.grey[400]
                      : NewCompletedGreenButtonColor,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: NewCompletedGreenButtonColor,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
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

  GridView _buildHorizontalTile() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisExtent: 50,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: typeList.length,
      itemBuilder: (context, index) {
        var item = typeList[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25.0),
            ),
            side: new BorderSide(color: CompletedGreenButtonColor, width: 1.0),
          ),
          elevation: 0,
          child: GestureDetector(
            onTap: () => {},
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 10,
                            ),
                            child: Icon(
                              Icons.check,
                              color: CompletedGreenButtonColor,
                              size: 20,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: item['name'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> callGetPostApi() async {
    try {
      var uri =
          'https://vact.tech/wp-json/wp/v2/get_all_user_post_by_id?user_id=${widget.userId}&post_action_id=${widget.id}';
      print('uri : ' + uri);
      var response = await post(Uri.parse(uri));
      //log('response :' + response.body);
      Map data = new Map();
      data = json.decode(response.body) as Map;
      print(data);
      if (data['success']) {
        setState(() {
          postName = data['data'][0]['post_name'];
          description = data['data'][0]['desc_action_item'];
          attachLink = data['data'][0]['attach_link'];
          userName = data['data'][0]['user_name'];
          isCompleted = data['data'][0]['status'] == 'completed' ? true : false;

          for (var item in data['data'][0]['post_mov']) {
            typeList.add({'name': item['movement_name'].toString()});
          }
        });
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> callUpdatePostApi() async {
    try {
      final SharedPreferences prefs = await _sprefs;
      String userId = prefs.getInt("ID").toString();

      https://vact.tech/wp-json/wp/v2/save_completed_action_post?user_id=69&post_action_id=109&status=completed
      var uri = 'https://vact.tech/wp-json/wp/v2/save_completed_action_post?user_post_id=${widget.userId}&user_action_id=$userId&post_action_id=${widget.id}&status=completed';
      //var uri = 'https://vact.tech/wp-json/wp/v2/save_completed_action_post?user_id=${widget.userId}&post_action_id=${widget.id}&status=completed';

      print('uri : ' + uri);
      var response = await post(Uri.parse(uri));
      log('response :' + response.body);
      Map data = new Map();
      data = json.decode(response.body) as Map;
      if (data['success']) {
        Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(
            builder: (context) => CompletedScreen('Completed'),
          ),
        );
      }
    } catch (e) {
      print(e);
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
}
