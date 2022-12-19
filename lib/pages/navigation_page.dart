import 'package:flutter/material.dart';

import 'home_page/home_screen.dart';
import 'journal_page/journal_screen.dart';
import 'settings_page/settings_screen.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key, required this.initPage}) : super(key: key);

  final int initPage;

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<NavigationPage> {
  int _index = 1;

  final List _screens = [
    const JournalScreen(),
    const HomeScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _updateIndex(widget.initPage);
  }

  void _updateIndex(int value) {
    setState(() {
      _index = value;
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
        body: _screens[_index],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 20.0,
          enableFeedback: true,
          currentIndex: _index,
          onTap: _updateIndex,
          iconSize: 35,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.book_outlined,
                ),
                label: 'Journal',
                tooltip: 'Journal'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: 'Home',
                tooltip: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                ),
                label: 'Settings',
                tooltip: 'Settings'),
          ],
        ));
  }
}
