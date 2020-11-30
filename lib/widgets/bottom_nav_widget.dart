
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/const/data.dart';
import '../style/color.dart';

class BottomNavWidget extends StatefulWidget {
  final Function setViewForIndex;
  final int rootSelectedIndex;
  BottomNavWidget({
    this.setViewForIndex,
    this.rootSelectedIndex,
  });
  @override
  _BottomNavWidgetState createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<BottomNavWidget> {

  @override
  void initState() {
    super.initState();
  }

  void _bottomItemTapped(int tappedIndex) {
    
    widget.setViewForIndex(tappedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      unselectedItemColor: Colors.grey,
      selectedItemColor: AppColor.PRIMARY_COLOR,
      currentIndex: widget.rootSelectedIndex,
      iconSize: 23.0,
      elevation: 10.0,
      onTap: (int index) {
        _bottomItemTapped(index);
      },
      type: BottomNavigationBarType.fixed,
      items: [
        for (var item in Data.bottomAppBarItem)
          _buildBottomNavigationBarItem(item['icon'], item['text']),
      ],
    );
  }

  Widget _getIcon(IconData icon, bool isActive) {
    return Icon(icon);
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData iconData, String text) {
    return BottomNavigationBarItem(
      icon: _getIcon(iconData, false),
      activeIcon: _getIcon(iconData, true),
      label: text,
    );
  }
}
