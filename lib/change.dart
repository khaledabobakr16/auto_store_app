import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/widgets.dart';
import 'homescreen.dart';

class Change extends StatefulWidget {
  const Change({super.key});

  @override
  State<Change> createState() => _ChangeState();
}

class _ChangeState extends State<Change> {
  var email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: context.width,
          height: double.infinity,
          color: Colors.grey[50],
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
                child: Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey[50],
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Image.asset(
                "images/Forgotpassword.png",
                height: MediaQuery.of(context).size.height / 3,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "Change Your Password",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                        "Lost your password Please enter your email address.",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                        "You will receive a link to create a new password via email.",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[50]),
                      child: txtFormEmail(
                          typecontrol: email,
                          prefixicon: Icons.email,
                          prefixIconiconColor: Colors.grey,
                          txt: "E-mail")),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (email.text.isEmpty ||
                            !email.text.contains('@') ||
                            !email.text.contains('.')) {
                          log('Invalid email!');
                        } else {
                          try {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            auth.sendPasswordResetEmail(email: email.text);
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                backgroundColor: Colors.blue.shade900,
                                title: const Text('Sucessfull Massage',
                                    style: TextStyle(color: Colors.white)),
                                content: const Text("check your email",
                                    style: TextStyle(color: Colors.white)),
                                actions: <Widget>[
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          Navigator.of(ctx).pop();
                                        });
                                      },
                                      child: const SizedBox(
                                          child: Text("okay",
                                              style: TextStyle(
                                                  color: Colors.white)))),
                                ],
                              ),
                            );
                          } on FirebaseAuthException catch (e) {
                            log(e.code);
                            log(e.message.toString());
                          }
                        }
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 180,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                          child: Text(
                        "Reset Password",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
