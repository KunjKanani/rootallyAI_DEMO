import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rootally_ai/constants/app_colors.dart';
import 'package:rootally_ai/view/demo_screen/demo_screen.dart';
import 'package:rootally_ai/view/profile_screen/profile_screen.dart';
import 'package:rootally_ai/view/rehab_screen/raheb_screen.dart';
import 'package:rootally_ai/view/today_screen/today_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;

  static const List<Widget> _uiScreens = [
    TodayScreen(),
    RahebScreen(),
    DemoScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        elevation: 0,
        selectedItemColor: AppColors.secondaryColor,
        unselectedItemColor: AppColors.greyColor,
        showUnselectedLabels: true,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            label: 'Today',
            icon: Icon(Icons.calendar_today_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Rehab',
            icon: Icon(Icons.hiking_rounded),
          ),
          BottomNavigationBarItem(
            label: 'Demo',
            icon: Icon(Icons.explore_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person_outline_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: _uiScreens.elementAt(_currentIndex),
      ),
    );
  }
}
