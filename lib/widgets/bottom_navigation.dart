import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ourvoice/config/palette.dart';
import 'package:ourvoice/config/tab_item.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({this.currentTab, this.onSelectTab});
  final CustomTabItem currentTab;
  final ValueChanged<CustomTabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      style: TabStyle.fixedCircle,
      color: PrimaryColor,
      activeColor: PrimaryColor,
      items: [
        TabItem(
          icon: SvgPicture.asset(
            'assets/images/home.svg',
            color: PrimaryColor,
          ),
        ),
        TabItem(icon: Icons.add),
        TabItem(
          icon: SvgPicture.asset(
            'assets/images/profile.svg',
            color: PrimaryColor,
          ),
        ),
      ],
      onTap: (index) => onSelectTab(
        CustomTabItem.values[index],
      ),
    );
  }
}
