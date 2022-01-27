import 'package:flutter/material.dart';
import 'package:ourvoice/screens/addpage.dart';
import 'package:ourvoice/screens/homepage.dart';
import 'package:ourvoice/screens/profilepage.dart';
import 'package:ourvoice/config/tab_item.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final CustomTabItem tabItem;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (RouteSettings routeSettings) {
        switch (tabItem) {
          case CustomTabItem.home:
            return MaterialPageRoute(
              builder: (context) => new MyHomePage(),
            );
            break;
          case CustomTabItem.add:
            return MaterialPageRoute(
              builder: (context) => new AddPage(),
              fullscreenDialog: true,
              maintainState: false,
            );
            break;
          default:
            return MaterialPageRoute(
              builder: (context) => new ProfilePage(),
            );
            break;
        }
      },
    );
  }
}
