import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/change.dart';

import 'homescreen.dart';

class GetUserName extends StatefulWidget {
  final String documentId;

  const GetUserName(this.documentId, {super.key});

  @override
  State<GetUserName> createState() => _GetUserNameState();
}

class _GetUserNameState extends State<GetUserName> {
  var newfirstname = TextEditingController();

  var newlastname = TextEditingController();

  var newphone = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final user = FirebaseAuth.instance.currentUser;

  Future<void> updateUserFN(String? nfw) {
    return users
        .doc(user!.uid)
        .update({'firstname': nfw})
        .then((value) => log("User Updated"))
        .catchError((error) => log("Failed to update user: $error"));
  }

  Future<void> updateUserln(String? ln) {
    return users
        .doc(user!.uid)
        .update({'lasttname': ln})
        .then((value) => log("User Updated"))
        .catchError((error) => log("Failed to update user: $error"));
  }

  Future<void> updateUserph(String? ph) {
    return users
        .doc(user!.uid)
        .update({'phonenum': ph})
        .then((value) => log("User Updated"))
        .catchError((error) => log("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<DocumentSnapshot>(
          future: users.doc(widget.documentId).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return const Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: Container(
                                height: 50,
                                width: 50,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 80,
                            ),
                            Container(
                                width: 420,
                                color: Colors.blue.shade900,
                                child: const Center(
                                    child: Text("Your Information",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 35)))),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 250,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: TextFormField(
                                        readOnly: true,
                                        //controller: email,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(Icons.person,
                                              color: Colors.grey),
                                          hintText:
                                              "First Name: ${data['firstname']}",
                                          hintStyle: TextStyle(
                                              color: Colors.blue.shade900,
                                              fontWeight: FontWeight.bold),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              borderSide: BorderSide(
                                                  color: Colors.blue.shade900)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            backgroundColor:
                                                Colors.blue.shade900,
                                            title: const Text(
                                                'Change first name',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            content: Container(
                                              width: 50,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.grey.shade700),
                                              child: TextFormField(
                                                controller: newfirstname,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  prefixIcon: Icon(Icons.person,
                                                      color: Colors.white),
                                                  label: Text("New first name",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      updateUserFN(
                                                          newfirstname.text);
                                                      Navigator.of(ctx).pop();
                                                    });
                                                  },
                                                  child: const SizedBox(
                                                      child: Text("change",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18)))),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade900,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        height: 50,
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 250,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: TextFormField(
                                        readOnly: true,
                                        //controller: email,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style:
                                            const TextStyle(color: Colors.grey),
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(Icons.person,
                                              color: Colors.grey),
                                          hintText:
                                              "Last Name: ${data['lasttname']}",
                                          hintStyle: TextStyle(
                                              color: Colors.blue.shade900,
                                              fontWeight: FontWeight.bold),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              borderSide: BorderSide(
                                                  color: Colors.blue.shade900)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            backgroundColor:
                                                Colors.blue.shade900,
                                            title: const Text(
                                                'Change last name',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            content: Container(
                                              width: 50,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.grey.shade700),
                                              child: TextFormField(
                                                controller: newlastname,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  prefixIcon: Icon(Icons.person,
                                                      color: Colors.white),
                                                  label: Text("New last name",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      updateUserln(
                                                          newlastname.text);
                                                      Navigator.of(ctx).pop();
                                                    });
                                                  },
                                                  child: const SizedBox(
                                                      child: Text("change",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18)))),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade900,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        height: 50,
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 250,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: TextFormField(
                                        readOnly: true,
                                        //controller: email,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: TextStyle(
                                            color: Colors.blue.shade900),
                                        decoration: InputDecoration(
                                            prefixIcon: const Icon(Icons.phone,
                                                color: Colors.grey),
                                            hintText:
                                                "phone: ${data['phonenum']}",
                                            hintStyle: TextStyle(
                                                color: Colors.blue.shade900,
                                                fontWeight: FontWeight.bold),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.blue.shade900))),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            backgroundColor:
                                                Colors.blue.shade900,
                                            title: const Text(
                                                'Change phone number',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            content: Container(
                                              width: 50,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.grey.shade700),
                                              child: TextFormField(
                                                controller: newphone,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  prefixIcon: Icon(Icons.phone,
                                                      color: Colors.white),
                                                  label: Text("New phone",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      updateUserph(
                                                          newphone.text);
                                                      Navigator.of(ctx).pop();
                                                    });
                                                  },
                                                  child: const SizedBox(
                                                      child: Text("change",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18)))),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade900,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        height: 50,
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 250,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: SizedBox(
                                        child: TextFormField(
                                          readOnly: true,
                                          //controller: email,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          decoration: InputDecoration(
                                              prefixIcon: const Icon(Icons.lock,
                                                  color: Colors.grey),
                                              hintText: "Change Password ",
                                              hintStyle: TextStyle(
                                                  color: Colors.blue.shade900,
                                                  fontWeight: FontWeight.bold),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .blue.shade900))),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Change()));
                                      },
                                      child: Container(
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade900,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        height: 50,
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 250,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: TextFormField(
                                        readOnly: true,
                                        //controller: email,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: TextStyle(
                                            color: Colors.blue.shade900),
                                        decoration: InputDecoration(
                                            prefixIcon: const Icon(Icons.email,
                                                color: Colors.grey),
                                            hintText:
                                                "E-mail: ${data['email']}",
                                            hintStyle: TextStyle(
                                                color: Colors.blue.shade900,
                                                fontWeight: FontWeight.bold),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.blue.shade900))),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade900,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    height: 50,
                                    child: const Icon(
                                      Icons.no_encryption,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              );
            }

            return const Text("loading");
          },
        ),
      ),
    );
  }
}
