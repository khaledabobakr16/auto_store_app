import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'homescreen.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('orders').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              setState(() {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (Route<dynamic> route) => false,
                );
              });
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            Text(
              "My Orders",
              style: TextStyle(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ],
        ),
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
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.blue.shade900),
                            height: 170,
                            width: context.width,
                            child: Stack(
                              children: [
                                Positioned(
                                    right: 70,
                                    child: Container(
                                      height: 50,
                                      width: 30,
                                      color: Colors.red,
                                      child: Center(
                                        child: Text(
                                          data["discount"].toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 170,
                                          width: 130,
                                          child: Image(
                                            fit: BoxFit.fill,
                                            height: 50,
                                            width: 30,
                                            image: NetworkImage(
                                                data["url"].toString()),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Divider(
                                              color: Colors.white,
                                              indent: 15,
                                              thickness: 2,
                                            ),
                                            SizedBox(
                                              width: 190,
                                              child: Column(children: [
                                                Center(
                                                  child: SizedBox(
                                                    child: Text(
                                                      (data["proudctname"]
                                                          .toString()),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: SizedBox(
                                                    child: Center(
                                                        child: Text(
                                                      "Model ${data["made"]}",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                  ),
                                                ),
                                                Center(
                                                  child: SizedBox(
                                                    child: Center(
                                                        child: Text(
                                                      ("Price ${data["price"]}"),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Colors.white,
                                                  indent: 15,
                                                  thickness: 2,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Center(
                                                      child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder: (ctx) =>
                                                                    AlertDialog(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .blue
                                                                          .shade900,
                                                                  title: const Text(
                                                                      'Cancel Massage',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                  content: const Text(
                                                                      "Are you sure to cancel?",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(ctx)
                                                                            .pop();
                                                                      },
                                                                      child: InkWell(
                                                                          onTap: () {
                                                                            setState(() {});
                                                                          },
                                                                          child: const SizedBox(child: Text("No", style: TextStyle(color: Colors.white)))),
                                                                    ),
                                                                    InkWell(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        child:
                                                                            Container()),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(ctx)
                                                                            .pop();
                                                                      },
                                                                      child: InkWell(
                                                                          onTap: () {
                                                                            setState(() {
                                                                              FirebaseFirestore.instance.collection("orders").doc(document.id.toString()).delete().then(
                                                                                    (doc) => log(document.id.toString()),
                                                                                    onError: (e) => log("Error updating document $e"),
                                                                                  );
                                                                            });
                                                                          },
                                                                          child: const SizedBox(child: Text("yes", style: TextStyle(color: Colors.white)))),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 12),
                                                            child: Container(
                                                              height: 20,
                                                              width: 80,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                              child: const Center(
                                                                  child: Text(
                                                                      "Cancel",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold))),
                                                            ),
                                                          )),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Center(
                                                      child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder: (ctx) =>
                                                                    AlertDialog(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .blue
                                                                          .shade900,
                                                                  title: const Text(
                                                                      'Cancel Massage',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                  content: const Text(
                                                                      "Are you sure to cancel?",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(ctx)
                                                                            .pop();
                                                                      },
                                                                      child: const SizedBox(
                                                                          child: Text(
                                                                              "No",
                                                                              style: TextStyle(color: Colors.white))),
                                                                    ),
                                                                    InkWell(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        child:
                                                                            Container()),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            Navigator.of(ctx).pop();
                                                                            uploadFile(
                                                                                data['price'].toString(),
                                                                                data["proudctname"].toString(),
                                                                                data["made"].toString(),
                                                                                data["url"].toString(),
                                                                                data["discount"].toString());
                                                                          });
                                                                        },
                                                                        child: const SizedBox(
                                                                            child:
                                                                                Text("yes", style: TextStyle(color: Colors.white)))),
                                                                  ],
                                                                ),
                                                              );
                                                            });
                                                          },
                                                          child: Container(
                                                            height: 20,
                                                            width: 80,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: const Center(
                                                                child: Text(
                                                                    "Confirm",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                          )),
                                                    ),
                                                  ],
                                                )
                                              ]),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Future uploadFile(
      var price, var proudctname, var made, var url, var discount) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final name = user.displayName;
        final email = user.email;

        await FirebaseFirestore.instance.collection('ordersadmin').add({
          'email': email,
          'username': name,
          'price': price,
          'proudctname': proudctname,
          'made': made,
          'url': url,
          'discount': discount
        });
      }
    } catch (e) {
      log('error occured');
    }
  }
}
