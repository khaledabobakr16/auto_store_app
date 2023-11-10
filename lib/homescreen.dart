import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'userinformation.dart';
import 'messages.dart';
import 'settingscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = [
    const UserInformation(),
    const Messages(),
    const Setting(),
  ];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBody: true,
        body: pages[_index],
        bottomNavigationBar: FloatingNavbar(
          width: double.infinity,
          backgroundColor: Colors.blue.shade900,
          onTap: (int val) => setState(() => _index = val),
          currentIndex: _index,
          items: [
            FloatingNavbarItem(icon: Icons.home, title: 'Home'),
            FloatingNavbarItem(icon: Icons.chat, title: 'Messages'),
            FloatingNavbarItem(
                icon: Icons.account_circle_rounded, title: 'profile'),
          ],
        ),
      ),
    );
  }
}
