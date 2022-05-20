import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:ourvoice/config/palette.dart';
import 'package:ourvoice/config/report.dart';
import 'package:ourvoice/widgets/homepage_act.dart';
import 'package:random_color/random_color.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:device_apps/device_apps.dart';
import 'package:uni_links/uni_links.dart';

import 'loginpage.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  final _search = TextEditingController();

  bool loading = false;
  bool isLoading = false;
  bool isEnd = false;

  List<Report> reportList = [];

  RandomColor _randomColor = RandomColor();

  List<String> text = ["Most Recent", "Action Type", "Your Interests"];

  List filterList = [];

  final _focusNode = FocusNode();

  int filterGroupValue;

  int pageNo = 1;

  ScrollController _scrollController = ScrollController();

  sharefunction() async{
    bool isInstalled = await DeviceApps.isAppInstalled('vact.politics.activism.community');

    print(isInstalled);
   // Application app = await DeviceApps.getApp('vact.politics.activism.community');
    //DeviceApps.openApp('vact.politics.activism.community');

  }

  Future<void> initUniLinks()async{
    try{
      Uri initialLink = await getInitialUri();
      print(initialLink);
    } on PlatformException {
      print('platfrom exception unilink');
    }
  }



  @override
  void initState() {
    super.initState();
    intitialMethod();
    sharefunction();
    initUniLinks();
    // callAllPostApi();
    // _scrollController.addListener(() {
    //   if(_scrollController.position.atEdge){
    //     if(!(_scrollController.position.pixels==0)){
    //       if(!isEnd){
    //         pageNo+=1;
    //         callAllPostApi();
    //         setState(() {
    //           isLoading = true;
    //         });
    //       }
    //     }
    //   }
    // });
    // _focusNode.unfocus();
  }

  intitialMethod() async {

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      filterGroupValue = (prefs.getInt('filterGroupValue') ?? 1);
      print(filterGroupValue);

    });

    if(filterGroupValue==0){
      callMostRecentApi();
    print(filterGroupValue);
    }else if(filterGroupValue==1) {
      callAllPostApi();
      print(filterGroupValue);

    }else if(filterGroupValue==-1){
      print(filterGroupValue);

      callAllPostApi();
      _scrollController.addListener(() {
        if(_scrollController.position.atEdge){
          if(!(_scrollController.position.pixels==0)){
            if(!isEnd){
              pageNo+=1;
              callAllPostApi();
              setState(() {
                isLoading = true;
              });
            }
          }
        }
      });
      _focusNode.unfocus();
    }else{
      print(filterGroupValue);

      callAllPostApi();
      _scrollController.addListener(() {
        if(_scrollController.position.atEdge){
          if(!(_scrollController.position.pixels==0)){
            if(!isEnd){
              pageNo+=1;
              callAllPostApi();
              setState(() {
                isLoading = true;
              });
            }
          }
        }
      });
      _focusNode.unfocus();
    }



  }

  @override
  Widget build(BuildContext context) {

    void _loadCounter(phone,identifier) async {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setString(identifier, phone);
      });
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        /*title: Text(
          'Vact',
          style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.w600, color: Colors.black),
        ),*/
        title: InkWell(
          onTap: ()async{
            initUniLinks();
          },
          child: Image.asset(
            "assets/images/VactType.png",height: 45,width: 70,
          ),
        ),
        backgroundColor: Color.fromRGBO(255, 148, 36, 0.47),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return true;
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: true,
              pinned: true,
              elevation: 0,
              backgroundColor: Colors.white,
              flexibleSpace: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                color: Color.fromRGBO(255, 148, 36, 0.47),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            border: Border.all(
                              color: const Color.fromRGBO(255, 148, 36, 0.47),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: TextField(
                            focusNode: _focusNode,
                            controller: _search,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              hintText: "Search",
                              contentPadding: EdgeInsets.only(top: 5.0),
                              border: InputBorder.none,
                              prefixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () => {},
                                iconSize: 25.0,
                              ),
                              suffixIcon: _search.text.length > 0
                                  ? IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => {
                                  setState(() {
                                    _search.text = '';
                                    callAllPostApi();
                                    _focusNode.unfocus();
                                  })
                                },
                                iconSize: 25.0,
                              )
                                  : SizedBox(),
                            ),
                            onChanged: (val) {},
                            onSubmitted: (val) {
                              callSearchPostApi(val);
                              _focusNode.unfocus();
                            },
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          openFilter();
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 5,
                                    right: 10,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/options.svg',
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: 'Filter'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    color: Colors.grey.shade200,
                    child:
                    NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowGlow();
                        return true;
                      },
                      child: loading
                          ? _loadingDataList(context)
                          : loadList(reportList),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadingDataList(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.only(top: 0.0),
          itemCount: 4,
          itemBuilder: (ctx, i) {
            return loadingCard(ctx);
          },
        ),
      ),
    );
  }

  Widget loadingCard(BuildContext ctx) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Shimmer.fromColors(
                      baseColor: Color(0xFFEBEBF4),
                      highlightColor: Color(0xFFF4F4F4),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: new BoxDecoration(
                          color: Theme.of(ctx).hintColor.withAlpha(170),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Color(0xFFEBEBF4),
                          highlightColor: Color(0xFFF4F4F4),
                          child: Container(
                            height: 20.0,
                            width: MediaQuery.of(context).size.width * 0.45,
                            color: Theme.of(ctx).hintColor.withAlpha(170),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Shimmer.fromColors(
                        baseColor: Color(0xFFEBEBF4),
                        highlightColor: Color(0xFFF4F4F4),
                        child: Container(
                          height: 20.0,
                          width: MediaQuery.of(context).size.width * 0.75,
                          color: Theme.of(ctx).hintColor.withAlpha(170),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Shimmer.fromColors(
                        baseColor: Color(0xFFEBEBF4),
                        highlightColor: Color(0xFFF4F4F4),
                        child: Container(
                          height: 20.0,
                          width: MediaQuery.of(context).size.width * 0.75,
                          color: Theme.of(ctx).hintColor.withAlpha(170),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {},
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                            right: 10,
                          ),
                          child: SvgPicture.asset(
                            'assets/images/flag.svg',
                            color: PrimaryColor,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: 'report'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                            right: 10,
                          ),
                          child: SvgPicture.asset(
                            'assets/images/arrow-right-o.svg',
                            color: PrimaryColor,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: 'act'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                            right: 10,
                          ),
                          child: SvgPicture.asset(
                            'assets/images/Union.svg',
                            color: PrimaryColor,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: 'share'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Card _buildRow(String id, String name, String postName, String description,
      String time, String userId, bool completed_status) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Container(

              width: double.infinity,
              child: InkWell (
                onTap: (){
                  print(id);
                  print(userId);

                  Navigator.of(context, rootNavigator: true).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => TakeAction(id, userId),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: _randomColor.randomColor(
                              colorBrightness: ColorBrightness.light),
                          child: Text(
                            getInitials(name).toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              convertToAgo(DateTime.parse(time)),
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: new Container(
                            child: new Text(
                              postName,
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: new Container(
                            child: new Text(
                              description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w400),
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
          Divider(
            thickness: 1,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  _showReportPopup(id, userId);
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                            right: 10,
                          ),
                          child: SvgPicture.asset(
                            'assets/images/flag.svg',
                            color: PrimaryColor,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: 'report'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => TakeAction(id, userId),
                    ),
                  );

                  /* Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) =>
                          new TakeAction(id, postName, description),
                    ),
                  ); */
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                            right: 10,
                          ),
                          child:
                          completed_status==true ?
                          Icon(FontAwesomeIcons.solidCheckCircle,color: Colors.green,size: 24,)
                              :
                          SvgPicture.asset(
                            'assets/images/arrow-right-o.svg',
                            color: PrimaryColor,
                          ),
                          // SvgPicture.asset(
                          //   'assets/images/arrow-right-o.svg',
                          //   color: PrimaryColor,
                          // ),
                        ),
                      ),
                      TextSpan(
                        text:
                        completed_status==true ?
                        'DONE'.toUpperCase()
                            :
                        'act'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  var shareText="Hey! I found this action via the app Vact and thought you’d be interested: '$postName' - '$description'";
                  //shareText=shareText+"\nTake Action Now: $a";
                  shareText=shareText+"\nSee the full action and learn about more ways to be an everyday activist via Vact! : "
                  "https://vact.tech/wp-json/wp/v2/share_action?act_id="+id+"&user_id="+userId;
                      // "https://play.google.com/store/apps/details?id=vact.politics.activism.community";
                  Share.share(shareText);
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                            right: 10,
                          ),
                          child: SvgPicture.asset(
                            'assets/images/Union.svg',
                            color: PrimaryColor,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: 'share'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget loadList(List<Report> tempList) {
    List _table = tempList;
    return _table.length > 0
        ? Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5,
        ),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 0.0),
              itemCount: _table.length,
              itemBuilder: (context, index) {
                final Report record = _table[index];
                //print(record);
                return _buildRow(
                  record.id,
                  record.name,
                  record.postName,
                  record.description,
                  record.datetime,
                  record.userId,
                  record.completed_status
                );
              },
            ),
            isLoading ? loadingCard(context) : Container(),
          ],
        ),
      ),
    )
        : Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Center(
        child: const Text(
          'No Data Found',
          style: TextStyle(color: Color(0XFF808080), fontSize: 20.0),
        ),
      ),
    );
  }

  String getInitials(String name) => name.isNotEmpty
      ? name.trim().split(' ').map((l) => l[0]).take(2).join().toUpperCase()
      : '';

  String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);
    var dt = input.toLocal();
    var newFormat = DateFormat.yMMMMd('en_US');
    String updatedDt = newFormat.format(dt);

    if (diff.inDays > 1) {
      /* return '${diff.inDays} days ago'; */
      return updatedDt;
    } else if (diff.inDays == 1) {
      return 'a day ago';
    } else if (diff.inHours > 1) {
      return '${diff.inHours} hours ago';
    } else if (diff.inHours == 1) {
      return 'an hour ago';
    } else if (diff.inMinutes > 1) {
      return '${diff.inMinutes} minutes ago';
    } else if (diff.inMinutes == 1) {
      return 'a minute ago';
    } else if (diff.inSeconds > 1) {
      return '${diff.inSeconds} seconds ago';
    } else if (diff.inSeconds == 1) {
      return 'a second ago';
    } else {
      return 'just now';
    }
  }

  Future<void> _showReportPopup(String postId, String userId) async {
    String selected;

    final _selectedReason = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setButtonState) {
            return AlertDialog(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: FractionalOffset.topRight,
                    child: GestureDetector(
                      child: Icon(
                        Icons.clear,
                        color: Colors.black,
                        size: 30,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 5,
                              right: 10,
                            ),
                            child: SvgPicture.asset(
                              'assets/images/flag.svg',
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: 'Report this post?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'What reason are you reporting for?',
                    //'Select why you want to report:',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              titlePadding: EdgeInsets.all(15),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 4.0,
                      ),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: GestureDetector(
                          onTap: () => setButtonState(() {
                            selected = 'Misinformation';
                            print(selected);
                          }),
                          child: Text(
                            'Misinformation',
                            style: TextStyle(
                              color: (selected != null && selected == 'Misinformation')
                                  ? PrimaryColor
                                  : Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 4.0,
                      ),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: GestureDetector(
                          onTap: () => setButtonState(() {
                            selected = 'Abuse';
                            print(selected);
                          }),
                          child: Text(
                            'Abuse',
                            style: TextStyle(
                              color: (selected != null && selected == 'Abuse')
                                  ? PrimaryColor
                                  : Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 4.0,
                      ),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: GestureDetector(
                          onTap: () => setButtonState(() {
                            selected = 'Spam';
                            print(selected);
                          }),
                          child: Text(
                            'Spam',
                            style: TextStyle(
                              color: (selected != null &&
                                  selected == 'Spam')
                                  ? PrimaryColor
                                  : Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 4.0,
                      ),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: GestureDetector(
                          onTap: () => setButtonState(() {
                            selected = 'Block User';
                            print(selected);
                          }),
                          child: Text(
                            'Block User',
                            style: TextStyle(
                              color: (selected != null &&
                                  selected == 'Block User')
                                  ? PrimaryColor
                                  : Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 4.0,
                      ),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: GestureDetector(
                          onTap: () => setButtonState(() {
                            selected = 'Other';
                            print(selected);
                          }),
                          child: Text(
                            'Other',
                            style: TextStyle(
                              color: (selected != null &&
                                  selected == 'Other')
                                  ? PrimaryColor
                                  : Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 4.0,
                      ),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Text(
                          'Enter Reason (optional):',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          bottom: 10,
                        ),
                        child: TextField(
                          maxLines: 5,
                          controller: _selectedReason,
                          decoration: InputDecoration(
                            hintText: "Your text",
                            hintStyle: TextStyle(
                              color: Colors.black45,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                new Radius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                      onPressed: () async {
                        if (selected == null) {
                          print('selected');
                        } else {
                          print(selected);
                          bool val = await callUpdatePostApi(
                              userId, postId, selected, _selectedReason.text);
                          if (val) {
                            Navigator.pop(context);
                            _showReportConfirmPopup();
                          }
                        }
                      },
                      child: Text('Submit',
                          style: TextStyle(
                            color: selected == null
                                ? Colors.black54
                                : Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          )),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: selected == null
                                ? Colors.black54
                                : PrimaryColor,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showReportConfirmPopup() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setButtonState) {
            return AlertDialog(
              title: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Text(
                            'Report Submitted',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        Container(
                          alignment: FractionalOffset.topRight,
                          child: GestureDetector(
                            child: Icon(
                              Icons.clear,
                              color: Colors.black,
                              size: 30,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    /* Container(
                      alignment: FractionalOffset.topRight,
                      child: GestureDetector(
                        child: Icon(
                          Icons.clear,
                          color: Colors.black,
                          size: 30,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Center(
                      child: Text(
                        'Report Submitted',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),*/
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Thank you for submitting a report! Our team will carefully review the content of the post and the user’s activity.',
                          //'Thank you for submitting a report--our team will review the content of the post and the user’s activity.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              titlePadding: EdgeInsets.all(15),
            );
          },
        );
      },
    );
  }

  Future<void> openFilter() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        void _loadCounter(phone,identifier) async {
          final prefs = await SharedPreferences.getInstance();
          setState(() {
            prefs.setInt(identifier, phone);
          });
        }
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setFilterState) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  floating: true,
                  pinned: true,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title: Container(
                    color: Colors.white,
                    /* decoration: BoxDecoration(
                      color: Colors.white,
                      border: new Border(
                        bottom: new BorderSide(
                            width: 1.0, style: BorderStyle.solid),
                      ),
                    ), */
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Text(
                        'Filter by:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overscroll) {
                          overscroll.disallowGlow();
                          return true;
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                onTap: () {
                                  callMostRecentApi();
                                  setState(()  {
                                    filterGroupValue = 0;

                                  });
                                  Navigator.pop(context);
                                  _loadCounter(0,'filterGroupValue');
                                  print(filterGroupValue);
                                  // final prefs = await SharedPreferences.getInstance();
                                  // setState(() {
                                  //   prefs.setInt("filterGroupValue", filterGroupValue);
                                  // });
                                },
                                title: Text(
                                  'Most Recent',
                                  style: TextStyle(
                                    color: filterGroupValue==0 ? Colors.blue : Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                trailing: filterGroupValue==0 ? Icon(
                                  Icons.check_box,
                                  color: Colors.blue,
                                ) : null,
                              ),
                              ExpansionTile(
                                title: Text(
                                  'Action Type',
                                  style: TextStyle(
                                    color: filterGroupValue==-1 ? Colors.blue : Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                children: <Widget>[
                                  CheckboxListTile(
                                    activeColor: CheckboxBlueColor,
                                    title: Text(
                                      'Petition',
                                      style: TextStyle(
                                        color: filterList.contains('Petition') ? Colors.blue : Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    value: filterList.contains('Petition'),
                                    onChanged: (val)  {
                                      setState(()  {
                                        filterGroupValue = -1;

                                      });
                                      setFilterState(() {
                                        if (filterList.contains('Petition')) {
                                          setState(() {
                                            filterList.remove('Petition');
                                          });

                                        } else {
                                          setState(() {
                                            filterList.add('Petition');
                                          });
                                        }
                                      });
                                      callActionTypeFilterApi();
                                      _loadCounter(-1,'filterGroupValue');

                                    },
                                  ),
                                  CheckboxListTile(
                                    activeColor: CheckboxBlueColor,
                                    title: Text(
                                      'Donate',
                                      style: TextStyle(
                                        color: filterList.contains('Donate') ? Colors.blue : Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    value: filterList.contains('Donate'),
                                    onChanged: (val)  {
                                      setState(()  {
                                        filterGroupValue = -1;

                                      });
                                      setFilterState(() {
                                        if (filterList.contains('Donate')) {
                                          filterList.remove('Donate');
                                        } else {
                                          filterList.add('Donate');
                                        }
                                      });
                                      callActionTypeFilterApi();
                                      _loadCounter(-1,'filterGroupValue');

                                    },
                                  ),
                                  CheckboxListTile(
                                    activeColor: CheckboxBlueColor,
                                    title: Text(
                                      'Email',
                                      style: TextStyle(
                                        color: filterList.contains('Email') ? Colors.blue : Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    value: filterList.contains('Email'),
                                    onChanged: (val)  {
                                      setState(() {
                                        filterGroupValue = -1;

                                      });
                                      setFilterState(() {
                                        if (filterList.contains('Email')) {
                                          filterList.remove('Email');
                                        } else {
                                          filterList.add('Email');
                                        }
                                      });
                                      callActionTypeFilterApi();
                                      _loadCounter(-1,'filterGroupValue');

                                    },
                                  ),
                                  CheckboxListTile(
                                    activeColor: CheckboxBlueColor,
                                    title: Text(
                                      'Call',
                                      style: TextStyle(
                                        color: filterList.contains('Call') ? Colors.blue : Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    value: filterList.contains('Call'),
                                    onChanged: (val)  {
                                      setState(()  {
                                        filterGroupValue = -1;
                                      });
                                      setFilterState(() {
                                        if (filterList.contains('Call')) {
                                          setState(() {
                                            filterList.remove('Call');
                                          });

                                        } else {
                                          setState(() {
                                            filterList.add('Call');
                                          });

                                        }
                                      });
                                      callActionTypeFilterApi();

                                    },
                                  ),
                                  CheckboxListTile(
                                    activeColor: CheckboxBlueColor,
                                    title: Text(
                                      'Event',
                                      style: TextStyle(
                                        color: filterList.contains('Event') ? Colors.blue : Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    value: filterList.contains('Event'),
                                    onChanged: (val)  {
                                      setState(()  {
                                        filterGroupValue = -1;

                                      });
                                      setFilterState(() {
                                        if (filterList.contains('Event')) {
                                          filterList.remove('Event');
                                        } else {
                                          filterList.add('Event');
                                        }
                                      });
                                      callActionTypeFilterApi();
                                      _loadCounter(-1,'filterGroupValue');

                                    },
                                  ),
                                  CheckboxListTile(
                                    activeColor: CheckboxBlueColor,
                                    title: Text(
                                      'Other',
                                      style: TextStyle(
                                        color: filterList.contains('Other') ? Colors.blue : Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    value: filterList.contains('Other'),
                                    onChanged: (val)  {
                                      setState(()  {
                                        filterGroupValue = -1;

                                      });
                                      setFilterState(() {
                                        if (filterList.contains('Other')) {
                                          filterList.remove('Other');
                                        } else {
                                          filterList.add('Other');
                                        }
                                      });
                                      callActionTypeFilterApi();
                                      _loadCounter(-1,'filterGroupValue');

                                    },
                                  ),
                                ],
                              ),
                              ListTile(
                                onTap: () {
                                  callAllPostApi();
                                  setState(() {
                                    filterGroupValue = 1;

                                  });
                                  Navigator.pop(context);
                                  _loadCounter(1,'filterGroupValue');

                                  // final prefs = await SharedPreferences.getInstance();
                                  // setState(() {
                                  //   prefs.setInt("filterGroupValue", filterGroupValue);
                                  // });
                                },
                                title: Text(
                                  'Your Interests',
                                  style: TextStyle(
                                    color: filterGroupValue==1 ? Colors.blue : Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                trailing: filterGroupValue==1 ? Icon(
                                  Icons.check_box,
                                  color: Colors.blue,
                                ) : null,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> callAllPostApi() async {
    try {
      if(pageNo==1){
        setState(() {
          loading = true;
          reportList = [];
        });
      }
      final SharedPreferences prefs = await _sprefs;
      String userId = prefs.getInt("ID").toString();

      var uri =
          'https://vact.tech/wp-json/wp/v2/get_all_user_details?user_id=$userId&page_no=$pageNo';
      print('uri : ' + uri);
      var response = await post(Uri.parse(uri));
      //log('response :' + response.body);
      Map data = new Map();
      data = json.decode(response.body) as Map;
      if (data['success']) {
        print("success");
        //log(data['data'].toString());
        convertDataToList(data['data']);
      } else {
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> callSearchPostApi(String searchText) async {
    try {
      setState(() {
        loading = true;
        reportList = [];
      });
      var uri =
          'https://vact.tech/wp-json/wp/v2/search_action_post?search=$searchText';
      print('uri : ' + uri);
      var response = await post(Uri.parse(uri));
      //log('response :' + response.body);
      Map data = new Map();
      data = json.decode(response.body) as Map;
      if (data['success']) {
        //log(data['data'].toString());
        convertDataToList(data['data']);
      } else {
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> callMostRecentApi() async {
    try {
      setState(() {
        loading = true;
        reportList = [];
      });
      final SharedPreferences prefs = await _sprefs;
      String userId = prefs.getInt("ID").toString();
      var uri = 'https://vact.tech/wp-json/wp/v2/filter_most_recent?user_id=$userId';
      print('uri : ' + uri);
      var response = await post(Uri.parse(uri));
      //log('response :' + response.body);
      Map data = new Map();
      data = json.decode(response.body) as Map;
      if (data['success']) {
        log(data['data'].toString());
        convertDataToList(data['data']);
      } else {
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> callActionTypeFilterApi() async {
    try {
      setState(() {
        loading = true;
        reportList = [];
      });
      String actionListType = filterList.join(', ');
      print(actionListType);
      final SharedPreferences prefs = await _sprefs;
      String userId = prefs.getInt("ID").toString();
      var uri;
      if(!actionListType.isEmpty){
        uri = 'https://vact.tech/wp-json/wp/v2/filter_action_type?action_type=$actionListType&user_id=$userId';
      }else{
        uri =
        'https://vact.tech/wp-json/wp/v2/get_all_user_details?user_id=$userId&page_no=$pageNo';
      }

      print('uri : ' + uri);
      var response = await post(Uri.parse(uri));
      //log('response :' + response.body);
      Map data = new Map();
      data = json.decode(response.body) as Map;
      if (data['success']) {
        //log(data['data'].toString());
        convertDataToList(data['data']);
      } else {
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  convertDataToList(List data) {
    List<Report> tempList = [];
    try{
      setState(() {
        if (data.length != 5) {
          print("end");
          isEnd = true;
        }
      });
      for (var item in data) {
        tempList.add(Report(
          id: item['post_action_id'],
          userId: item['user_id'],
          name: item['user_name'],
          description: item['desc_action_item'],
          postName: item['post_name'],
          datetime: item['created_date'],
            completed_status: item['completed_status']
        ));
      }

      setState(() {
        print("end1");
        reportList.addAll(tempList);
        print(reportList);
        isLoading = false;
        loading = false;
      });
    }
    catch(e){
      setState(() {
        isEnd = true;
        isLoading = false;
      });
    }
  }

  Future<bool> callUpdatePostApi(String userPostedId, String postId,
      String selected, String selectedReason) async {
    try {
      final SharedPreferences prefs = await _sprefs;
      String userId = prefs.getInt("ID").toString();
      var uri =
          'https://vact.tech/wp-json/wp/v2/save_report_action_post?user_post_id=$userPostedId&user_action_id=$userId&post_action_id=$postId&status=$selected&reason=$selectedReason';

      print('uri : ' + uri);
      var response = await post(Uri.parse(uri));
      log('response :' + response.body);
      Map data = new Map();
      data = json.decode(response.body) as Map;
      return data['success'];
    } catch (e) {
      print(e);
    }
  }
}