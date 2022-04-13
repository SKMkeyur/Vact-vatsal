import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ourvoice/screens/profilepage.dart';
import 'package:ourvoice/widgets/bottom_navigation.dart';
import 'package:ourvoice/config/tab_item.dart';
import 'package:ourvoice/widgets/tab_navigator.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  var _currentTab = CustomTabItem.home;
  final _navigatorKeys = {
    CustomTabItem.home: GlobalKey<NavigatorState>(),
    CustomTabItem.add: GlobalKey<NavigatorState>(),
    CustomTabItem.profile: GlobalKey<NavigatorState>(),
  };

  void _selectTab(CustomTabItem tabItem) {
    print(tabItem);
    if (tabItem == CustomTabItem.profile){
      print("profile");
      Navigator
          .of(context)
          .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
        return new ProfilePage();
      }));
    }else if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {

      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab].currentState.maybePop();

        print(isFirstRouteInCurrentTab);
        if (_currentTab != CustomTabItem.home) {
          // select 'main' tab
          _selectTab(CustomTabItem.home);
          // back button handled by app
          return false;
        } else {
          SystemNavigator.pop();
          return false;
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: _buildOffstageNavigator(_currentTab),
        bottomNavigationBar: BottomNavigation(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(CustomTabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
