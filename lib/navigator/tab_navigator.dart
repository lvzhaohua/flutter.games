import 'dart:developer';

import 'package:app/pages/home.dart';
import 'package:app/pages/search.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => (_TabNavigatorState());
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  final MaterialColor _defaultColor = Colors.grey;
  final MaterialColor _activeColor = Colors.blue;
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[Home(), Search()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index){
          _pageController.jumpToPage(index);
          setState(() {
            _index = index;
          });
        },
        items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _defaultColor,
            ),
            activeIcon: Icon(Icons.home, color: _activeColor),
            title: Text(
              'home',
              style:
                  TextStyle(color: _index != 0 ? _defaultColor : _activeColor),
            )),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _defaultColor,
            ),
            activeIcon: Icon(
              Icons.search,
              color: _activeColor,
            ),
            title: Text(
              'search',
              style:
                  TextStyle(color: _index != 1 ? _defaultColor : _activeColor),
            )),
      ]),
    );
  }
}
