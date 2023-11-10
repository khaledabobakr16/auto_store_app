import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'products.dart';
import 'adminhome.dart';
import 'loginscreen.dart';
import 'messages.dart';
import 'ordersadmin.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  List<Widget> pages = [
    const ImageUploads(),
    const RemoveProducts(),
    const OrdersAdmin(),
    const Messages()
  ];
  List<String> text = [
    "Admin Panel",
    "Products",
    "Orders",
    "Messages",
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: _index == 0
                ? Icon(
                    Icons.dashboard,
                    color: Colors.blue.shade900,
                    size: 30,
                  )
                : _index == 1
                    ? Icon(
                        Icons.add_business_sharp,
                        color: Colors.blue.shade900,
                        size: 30,
                      )
                    : _index == 2
                        ? Icon(
                            Icons.shopping_cart,
                            color: Colors.blue.shade900,
                            size: 30,
                          )
                        : Icon(
                            Icons.message_outlined,
                            color: Colors.blue.shade900,
                            size: 30,
                          ),
            backgroundColor: Colors.grey[50],
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                    });
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.blue.shade900,
                  )),
            ],
            title: Column(
              children: [
                Text(
                  text[_index],
                  style: TextStyle(
                      color: Colors.blue.shade900,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          extendBody: true,
          body: pages[_index],
          bottomNavigationBar: FloatingNavbar(
            width: double.infinity,
            backgroundColor: Colors.blue.shade900,
            onTap: (int val) => setState(() => _index = val),
            currentIndex: _index,
            items: [
              FloatingNavbarItem(icon: Icons.home, title: 'Home'),
              FloatingNavbarItem(
                  icon: Icons.add_business_sharp, title: 'proudcts'),
              FloatingNavbarItem(
                  icon: Icons.shopping_cart_outlined, title: 'orders'),
              FloatingNavbarItem(icon: Icons.chat, title: 'Messages'),
            ],
          ),
        ),
      ),
    );
  }

  Future _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
