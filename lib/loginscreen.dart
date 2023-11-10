import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/widgets.dart';
import 'adminpage.dart';
import 'signupscreen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';
import 'forgetscreen.dart';

import 'homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var check = true;
  var email = TextEditingController();
  var password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: context.width,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.grey[50],
                    ),
                    child: Stack(
                      children: [
                        Image.asset("images/logologin.png"),
                        const Positioned(
                            bottom: 25,
                            left: 132,
                            child: Text(
                              "Welcome back!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                        const Positioned(
                            bottom: 7,
                            left: 100,
                            child: Text(
                              "Login in to your existant account ",
                              style: TextStyle(color: Colors.blueGrey),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.grey[50]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: Colors.white),
                            child: txtFormEmail(
                                typecontrol: email,
                                prefixicon: Icons.email_outlined,
                                prefixIconiconColor: Colors.grey,
                                txt: "E-mail")),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: Colors.white),
                            child: txtFormPassword(
                                typecontrol: password,
                                isCheck: check,
                                prefixicon: Icons.lock_outline,
                                prefixIconiconColor: Colors.grey,
                                txt: "Password",
                                hidepassword: hidePassword,
                                suffixicon: Icons.remove_red_eye_outlined,
                                suffixIconcolor: Colors.grey)),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetScreen()));
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: const Text("Forget Password?",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                AuthenticationHelper()
                                    .signIn(
                                        email: email.text,
                                        password: password.text)
                                    .then((result) {
                                  if (result == null) {
                                    if (email.text == "admin@gmail.com" &&
                                        password.text == "123456789") {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Admin()),
                                        (Route<dynamic> route) => false,
                                      );
                                    } else {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen()),
                                        (Route<dynamic> route) => false,
                                      );
                                    }
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        backgroundColor: Colors.blue.shade900,
                                        title: const Text('Error Massage',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        content: Text("$result",
                                            style: const TextStyle(
                                                color: Colors.white)),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: const SizedBox(
                                                child: Text("okay",
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                });
                                isLoading = true;
                              });
                              Future.delayed(const Duration(seconds: 3), () {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            },
                            child: isLoading
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        color: Colors.blue.shade900,
                                      ),
                                    ],
                                  )
                                : Container(
                                    height: 40,
                                    width: 160,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 30, 61, 106),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: const Center(
                                        child: Text(
                                      "LOG IN",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(children: [
                          Expanded(
                              child: Divider(
                            color: Colors.grey,
                            endIndent: 5,
                            indent: 70,
                            thickness: 2,
                          )),
                          Text("OR"),
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              endIndent: 70,
                              indent: 5,
                              thickness: 2,
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                signInWithFacebook();
                              },
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 5, 48, 83),
                                    borderRadius: BorderRadius.circular(25)),
                                child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.facebook_sharp,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "acebook",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      )
                                    ]),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            InkWell(
                              onTap: () {
                                signInWithGoogle();
                              },
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 224, 60, 5),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/google.png",
                                        fit: BoxFit.fill,
                                        height: 15,
                                        width: 15,
                                        //color: Color.fromARGB(255, 224, 60, 5),
                                      ),
                                      const SizedBox(width: 1),
                                      const Text(
                                        "oogle",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 233, 215, 215),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                              child: Text(
                                "Don't have accounts?",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen()));
                              },
                              child: const SizedBox(
                                child: Text(
                                  " Sign Up",
                                  style: TextStyle(
                                    color: Colors.lightBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  void signInWithGoogle() async {
  
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

   
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

  
    UserCredential result = await auth.signInWithCredential(credential);
    User? user = result.user;

    if (user != null) {
      log("done");
      String fn = (user.displayName!);
      String ln = (user.displayName!);
      addUser(
          fn,
          ln,
          user.phoneNumber == null ? "0123456789" : user.phoneNumber.toString(),
          user.email!,
          user.photoURL!);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (Route<dynamic> route) => false,
      );
    } 
    
  }

  Future<void> signInWithFacebook() async {
  
    final LoginResult loginResult = await FacebookAuth.instance.login();

    
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

   
    UserCredential result =
        await auth.signInWithCredential(facebookAuthCredential);
    User? user = result.user;

    if (user != null) {
      log("done");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  void hidePassword() {
    setState(() {
      if (check == true) {
        check = false;
      } else {
        check = true;
      }
    });
  }

  Future addUser(String firstname, String lasttname, String phonenum,
      String email, String photo) {
    DocumentReference<Map<String, dynamic>> users = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.uid.toString());

    return users
        .set({
          'firstname': firstname, 
          'lasttname': lasttname, 
          'phonenum': phonenum,
          'email': email,
          'photo': photo
        })
        .then((value) => log("User Added"))
        .catchError((error) => log("Failed to add user: $error"));
  }

  getfirstname(String name) {
    var names = name.split(' ');
    String firstname = "";

    for (int i = 0; i != names.length; i++) {
      if (i != names.length - 1) {
        if (i == 0) {
          firstname += names[i];
        } else {
          firstname += "firstname ${names[i]}";
        }
      }
    }
    return firstname;
  }

  getlastname(String name) {
    var names = name.split(' ');
    return names[names.length - 1].toString(); // dead
  }
}
