import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ourvoice/config/interest_config.dart';
import 'package:ourvoice/config/palette.dart';
import 'package:ourvoice/config/report.dart';
import 'package:ourvoice/screens/privacyPolicy.dart';
import 'package:ourvoice/screens/termsAndConditions.dart';
import 'package:ourvoice/widgets/interest.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'homepage.dart';
import 'loginpage.dart';

class ScreenArguments {
  final String message;

  ScreenArguments(this.message);
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int present = 0;
  int perPage = 3;

  int actionTaken = 0;
  int actionPosted = 0;

  String name;
  String backgroundImage = "";
  String profileImage = "";
  bool _displayAll = false;

  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Report> originalItems = [];
  List<Report> items = List<Report>();

  String userInterest;

  int backGroundId = -1;
  int selectedBackgroundId = -1;

  List<Item> userInterestList = [];
  var interest = [];

  List<String> backGroundList = [
    "assets/Background/back_image_1.jpg",
    "assets/Background/back_image_2.jpg",
    "assets/Background/back_image_3.jpg",
    "assets/Background/back_image_6.png",
    "assets/Background/back_image_5.jpg",
  ];


  bool isBackgroundSet = false;
  bool isViewMore = true;

  ProgressDialog pr;


  @override
  void initState() {
    super.initState();
    callGetProfileApi();
  }

  setBackgroundProfile(String profilePath,String backgroundImage) async{
    try {
      pr.show();
      final SharedPreferences prefs = await _sprefs;
      var uri =
          'https://vact.tech/wp-json/wp/v2/update_profile_photo';
      String userId = prefs.getInt("ID").toString();
      var request = MultipartRequest("POST",Uri.parse(uri));
      if(profilePath!=""){
        String fileName = profilePath.split("/").last;
        var stream =
        new ByteStream(Stream.castFrom(File(profilePath).openRead()));

        var length = await File(profilePath).length(); //imageFile is your image file

        // multipart that takes file
        var multipartFileSign = new MultipartFile(
          "profile",
          stream,
          length,
          filename: fileName,
        );
        request.files.add(multipartFileSign);
      }
      request.fields['user_id']=userId;
      request.fields['background']=backgroundImage.split("/").last;
      print(request.fields);
      var response = await Response.fromStream(await request.send());
      final data = json.decode(response.body) as Map;
      print(data);
      if(data['success']==true){
        print(data['success']);
        pr.hide();
        setState(() {
          callGetProfileApi();
        });
      }
    } catch (e) {
      print(e);
      pr.hide();
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var toolBar = (MediaQuery.of(context).padding.top + kToolbarHeight);
    var height = MediaQuery.of(context).size.height - toolBar;
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Uploading Image...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 50.0,
        progressTextStyle: TextStyle(
            color: Color(0xFFff862e), fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 11.0)
    );

    return WillPopScope(
      child: Scaffold(
        key: _scaffoldKey,
        endDrawerEnableOpenDragGesture: false,
        endDrawer: Drawer(
          child: Container(
            color: Color.fromRGBO(43, 43, 43, 1),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      DrawerHeader(
                        margin: EdgeInsets.all(0.0),
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 15,
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: FittedBox(
                            child: Text(
                              'Hi, ' + name.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'About Us',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/images/arrow-top-right.svg',
                            ),
                          ],
                        ),
                        onTap: ()  {
                          setState(() {
                            _openUrl('https://vact.tech');
                          });
                        },
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Get Help',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/images/arrow-top-right.svg',
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _openUrl('mailto:support@vact.tech');
                            });
                        },
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Privacy Policy',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/images/arrow-top-right.svg',
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => privacyPolicy(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Terms and Conditions',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/images/arrow-top-right.svg',
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => TermsAndConditions(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: MaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.clear();

                      Navigator.of(context, rootNavigator: true)
                          .pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage(),
                        ),
                        (Route route) => false,
                      );
                    },
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.white,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    overflow: Overflow.visible,
                    alignment: Alignment.center,
                    children: <Widget>[
                      Stack(
                        children: [
                          backgroundImage=="" ?
                          Shimmer.fromColors(
                            baseColor: Color(0xFFEBEBF4),
                            highlightColor: Color(0xFFF4F4F4),
                            child: Container(
                              height: height / 3.5,
                              width: MediaQuery.of(context).size.width,
                              color: Theme.of(context).hintColor.withAlpha(170),
                            ),
                          ) :
                          Container(
                            height: height / 3.5,
                            decoration: BoxDecoration(
                              image: isBackgroundSet ? DecorationImage(
                                  image: AssetImage(
                                    getBackgroundImage(backGroundId!=-1 ? backGroundId : selectedBackgroundId),
                                  ),
                                  fit: BoxFit.cover
                              ) : null,
                              color: !isBackgroundSet ? ProfileGreyColor : Colors.white,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.menu_outlined,
                              color: Color(0xFFC4C4C4),
                            ),
                            onPressed: () {
                              _scaffoldKey.currentState.openEndDrawer();
                            },
                          ),
                          Positioned(
                            bottom: 10.0,
                            right: 5.0,
                            child: GestureDetector(
                              onTap: (){
                                backGroundId = -1;
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context){
                                  return Container(
                                    height: MediaQuery.of(context).size.height/3,
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context).size.height/4,
                                          width: double.infinity,
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: backGroundList.length,
                                              itemBuilder: (context, index){
                                                return GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      backGroundId = index;
                                                      isBackgroundSet = true;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: Container(
                                                      height: MediaQuery.of(context).size.height/4,
                                                      width: MediaQuery.of(context).size.width/1.5,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(backGroundList[index]),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius: BorderRadius.circular(10.0),
                                                        border: Border.all(color: selectedBackgroundId==index ? Colors.green : Colors.black45),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          trailing: IconButton(
                                            icon: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                            onPressed: (){
                                              setState(() {
                                                backGroundId = -1;
                                              });
                                              Navigator.pop(context);
                                            },
                                          ),
                                          leading: IconButton(
                                            icon: Icon(
                                                Icons.done,
                                                color: Colors.green,

                                            ),
                                            onPressed: (){
                                              if(backGroundId!=-1){
                                                  setBackgroundProfile(
                                                      "",
                                                      getBackgroundImage(
                                                          backGroundId));
                                                  Navigator.pop(context);
                                                }
                                              },
                                          ),
                                          title: Text(
                                            "Backgrounds"
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0),
                                  ),
                                ),
                                  isDismissible: false,
                                  enableDrag: false,
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50.0) ,
                                  border: Border.all(color: Colors.black45)
                                ),
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.edit,
                                  size: 25.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                        alignment: Alignment.topRight,
                      ),
                      Positioned(
                        bottom: -50,
                        child:  GestureDetector(
                          child: CircleAvatar(
                            backgroundColor: ProfileOrangeColor,
                            radius: 56,
                            backgroundImage: profileImage!="" ? NetworkImage(
                              profileImage,
                            ) : null,
                            //child: profileImage=="" ? Image.asset("assets/images/emoji.png") : Container(),
                            child: profileImage=="" ? Container() : Container(),
                            ),

                        ),
                      ),

                    ],
                  ),
                  GestureDetector(
                    onTap: () async{
                      if(await Permission.storage.isGranted){
                        var profileImage = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                          maxWidth: 1800,
                          maxHeight: 1800,
                          imageQuality: 100,
                        );
                        if(profileImage!=null){
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: Text("Update Profile Pic"),
                              content: Text("Are you sure you want to update your profile picture?"),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    File image = File(profileImage.path);
                                    Navigator.pop(context);
                                    setBackgroundProfile(image.path, "");

                                  },
                                  child: Text("Yes"),
                                ),
                                TextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  child: Text("No"),
                                ),
                              ],
                            );
                          });
                        }
                      }
                      else{
                        await Permission.storage.request();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 70,top: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50.0) ,
                          border: Border.all(color: Colors.black45)
                      ),
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.camera_alt,
                        size: 25.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 4.4 - 130,
                  ),
                  name == null
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
                          name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          Text(
                            actionTaken.toString(),
                            style: TextStyle(
                              color: ProfileTextOrangeColor,
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Actions taken',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            actionPosted.toString(),
                            style: TextStyle(
                              color: ProfileTextOrangeColor,
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Actions posted',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'My Interests'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => ChangeInterestSelection(
                                        userInterest, 'Profile'),
                                  ),
                                );
                              },
                              child: Text(
                                'Edit',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    width: double.infinity,
                    height: 100,
                    child: grid(context),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Completed actions'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  _loadingDataList(context),
                  originalItems.isNotEmpty || originalItems.length>3 ? Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      child: Text(
                        isViewMore ? "View More" : "View Less",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          if(isViewMore){
                              if ((present + perPage) > originalItems.length) {
                                items.addAll(originalItems.getRange(
                                    present, originalItems.length));
                                isViewMore = false;
                              } else {
                                items.addAll(originalItems.getRange(
                                    present, present + perPage));

                              }
                              present = present + perPage;

                            }
                          else{
                           /* present = 3;
                            items.removeRange(3, originalItems.length-1);
                            isViewMore = true;*/
                             present = 0;
                             perPage = 3;
                             items.clear();
                             if ((present + perPage) > originalItems.length) {
                               items.addAll(originalItems.getRange(
                                   present, originalItems.length));
                             } else {
                               items.addAll(originalItems.getRange(
                                   present, present + perPage));
                             }
                             present = present + perPage;
                             isViewMore = true;
                          }
                          },
                        );
                      },
                    ),
                  ) : Container(),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new MyHomePage(),
          ),
        );
        return false;
      },
    );
  }

  Widget _loadingDataList(BuildContext context) {
    return originalItems.length > 0
        ? Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: (present <= originalItems.length)
                    ? items.length
                    : items.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        color: ProfileOrangeColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          child: Row(
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/images/check-o.svg',
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: new Container(
                                  child: new Text(
                                    items[index].postName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        : Center(
            child: const Text(
              'No Data Found',
              style: TextStyle(color: Color(0XFF808080), fontSize: 20.0),
            ),
          );
  }

  Widget grid(BuildContext context) {
    return userInterestList.length > 0
        ? GridView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: userInterestList.length,
            itemBuilder: (context, index) {
              var item = userInterestList[index];
              return Container(
                decoration: BoxDecoration(
                  color: item.backgrdColor,
                  border: Border.all(width: 1, color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(7),
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Center(
                        child: Image.asset(
                          item.path,
                          fit: BoxFit.cover,
                          scale: 1.5,
                        ),
                      ),
                      Center(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            item.name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : GridView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(7),
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: Color(0xFFEBEBF4),
                        highlightColor: Color(0xFFF4F4F4),
                        child: Container(
                          height: 60,
                          width: 60,
                          color: Theme.of(context).hintColor.withAlpha(170),
                        ),
                      ),
                      Center(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Shimmer.fromColors(
                            baseColor: Color(0xFFEBEBF4),
                            highlightColor: Color(0xFFF4F4F4),
                            child: Container(
                              height: 20.0,
                              width: MediaQuery.of(context).size.width * 0.25,
                              color: Theme.of(context).hintColor.withAlpha(170),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Future<void> callGetProfileApi() async {
    try {
      final SharedPreferences prefs = await _sprefs;
      String userId = prefs.getInt("ID").toString();

      var uri =
          'https://vact.tech/wp-json/wp/v2/get_profile?user_id=$userId';
      print('uri : ' + uri);
      var response = await post(Uri.parse(uri));
      log('response :' + response.body);
      Map data = new Map();
      data = json.decode(response.body) as Map;
      if (data['success']) {
        setState(() {
          name = data['data']['first_name']
              .toString()
              .replaceAll("[", "")
              .replaceAll("]", "")+" "+data['data']['last_name'].toString().replaceAll("[", "")
              .replaceAll("]", "");
          actionPosted = data['no_of_action_posted'];
          actionTaken = data['no_of_action_taken'];

          if(data['data']['background_photo'][0]!=null){
            for (var background in backGroundList) {
              if (background.contains(data['data']['background_photo'][0])) {
                selectedBackgroundId = backGroundList.indexOf(background);
                backgroundImage = background;
                break;
              } else {
                selectedBackgroundId = 1;
                backgroundImage = "back_image_1.jpg";
              }
            }
            isBackgroundSet = true;
          }else{
            selectedBackgroundId = 1;
            backgroundImage = "back_image_1.jpg";
          }

          if(data['data']['profile_photo'].toString()
              .replaceAll("[", "")
              .replaceAll("]", "")!="null"){
            profileImage = data['data']['profile_photo']
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", "");
          }
          originalItems.clear();
          for (var item in data['completed_action']) {
            originalItems.add(Report(
              id: item['post_action_id'],
              userId: item['user_id'],
              name: item['user_name'],
              description: item['desc_action_item'],
              postName: item['post_name'],
              datetime: item['created_date'],
            ));
          }
          if (originalItems.length > 0) {
            if (originalItems.length > 4) {
              items.addAll(originalItems.getRange(present, present + perPage));
              present = present + perPage;
            } else {
              present = 0;
              perPage = originalItems.length;
              items.addAll(originalItems.getRange(present, present + perPage));
              present = present + perPage;
            }
          } else {
            present = 0;
            perPage = 0;
          }
          userInterest = data['data']['interests']
              .toString()
              .replaceAll("[", "")
              .replaceAll("]", "");
          interest = userInterest.toUpperCase().split(', ');
          userInterestList.clear();
          for (var item in itemList) {
            if (interest.contains(item.name.toUpperCase())) {
              userInterestList.add(item);
            }
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  convertDataToList(List data) {
    List<Report> tempList = [];
    setState(() {
      originalItems = [];
    });
    for (var item in data) {
      tempList.add(Report(
        id: item['post_action_id'],
        userId: item['user_id'],
        name: item['user_name'],
        description: item['desc_action_item'],
        postName: item['post_name'],
        datetime: item['created_date'],
      ));
    }

    setState(() {
      originalItems = tempList;
    });
  }

  getBackgroundImage(int id) {
    if(backGroundList.contains(backGroundList[id])){
      return backGroundList[id];
    }
  }

  Future<void> _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
