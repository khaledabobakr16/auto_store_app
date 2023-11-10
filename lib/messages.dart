import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/main.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  AsyncSnapshot<DocumentSnapshot>? snapshot;
  String? username;
  String? phone;
  String? email;
  var messagee = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  var massage = TextEditingController();

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('massages').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Send Message",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        backgroundColor: Colors.blue.shade900,
                        title: const Text('Send Message',
                            style: TextStyle(color: Colors.white)),
                        content: Container(
                          width: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[50]),
                          child: TextFormField(
                            controller: messagee,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.send, color: Colors.grey),
                              label: Text("Write Message",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          InkWell(
                              onTap: () {
                                setState(() {
                                  sendMessage(messagee.text);
                                  Navigator.of(ctx).pop();
                                });
                              },
                              child: const SizedBox(
                                  child: Text("Send",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)))),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(12)),
                    height: 50,
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Messages"),
        backgroundColor: Colors.blue.shade900,
        elevation: 2,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(25)),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data["email"].toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: context.width,
                              child: Text(
                                overflow: TextOverflow.visible,
                                " >> ${data["massage"]}",
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Future<void> sendMessage(var massage) async {
    String? email;
    try {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final email1 = user.email;
          email = email1;
        }
      } catch (e) {
        log('error occured');
      }
      CollectionReference<Map<String, dynamic>> user =
          FirebaseFirestore.instance.collection('massages');

      user.doc().set({
        'email': email,
        "massage": massage,
      });
    } on FirebaseAuthException catch (_) {
      log("Error don't send");
    }
  }
}
