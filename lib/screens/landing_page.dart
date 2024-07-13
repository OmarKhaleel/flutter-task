import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_task/screens/home_screen.dart';
import 'package:flutter_task/screens/profile_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int index = 0;
  late Color selectedItem = Colors.blue;
  Color unselectedItem = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
            backgroundColor: const Color(0xFF003366),
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 3,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.home,
                    color: index == 0 ? selectedItem : unselectedItem,
                    size: 22,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.profile_circled,
                  color: index == 1 ? selectedItem : unselectedItem,
                  size: 26,
                ),
                label: 'Profile',
              )
            ]),
      ),
      body: index == 0 ? const HomeScreen() : const ProfileScreen(),
    );
  }
}
