import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'homescreen.dart';
import 'loginscreen.dart';
import 'signupscreen.dart';
import 'splashscreen.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.width;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const Car());
}

class Car extends StatelessWidget {
  const Car({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, routes: {
      "/": (_) => const SplashScreen(),
      "login_screen": (_) => const LoginScreen(),
      "signup_screen": (_) => const SignUpScreen(),
      "homescreen": (_) => const HomeScreen()
    });
  }
}
