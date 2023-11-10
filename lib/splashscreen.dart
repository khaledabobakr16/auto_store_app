import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    handlrData(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 250,
          ),
          Center(child: Image.asset("images/carlogo.png")),
          const Spacer(),
          Text(
            "",
            style: TextStyle(color: Colors.blue.shade900),
          ),
        ],
      ),
    );
  }

  Future<void> handlrData(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.of(context).pushReplacementNamed("login_screen");
  }
}
