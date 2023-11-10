import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'widgets.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  var email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: context.width,
          decoration: BoxDecoration(
            color: Colors.grey[50],
          ),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
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
                      color: Colors.blueGrey,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 200,
                  width: context.width,
                  child: Image.asset("images/Forgotpassword.png")),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    "Reset Your Password",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                        "Lost your password Please enter your email address.",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13.0),
                    child: Text(
                        "You will receive a link to create a new password via email.",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 14,
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
                        prefixIconiconColor: Colors.grey,
                        prefixicon: Icons.email,
                        txt: "E-mail",
                        typecontrol: email,
                        txtinput: TextInputType.emailAddress),
                  ),
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
                                          Navigator.pop(context);
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
                      width: 160,
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
