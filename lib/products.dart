import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class RemoveProducts extends StatefulWidget {
  const RemoveProducts({super.key});

  @override
  State<RemoveProducts> createState() => _RemoveProductsState();
}

class _RemoveProductsState extends State<RemoveProducts> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                    right: 20,
                                    child: Container(
                                      height: 20,
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
                                                Center(
                                                  child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          showDialog(
                                                            context: context,
                                                            builder: (ctx) =>
                                                                AlertDialog(
                                                              backgroundColor:
                                                                  Colors.black,
                                                              title: const Text(
                                                                  'Cancel Massage',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                              content: const Text(
                                                                  "Are you sure to cancel?",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            ctx)
                                                                        .pop();
                                                                  },
                                                                  child: InkWell(
                                                                      onTap: () {
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      child: const SizedBox(child: Text("No", style: TextStyle(color: Colors.white)))),
                                                                ),
                                                                InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    child:
                                                                        Container()),
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              ctx)
                                                                          .pop();
                                                                      setState(
                                                                          () {
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection("products")
                                                                            .doc(document.id.toString())
                                                                            .delete()
                                                                            .then(
                                                                              (doc) => log(document.id.toString()),
                                                                              onError: (e) => log("Error updating document $e"),
                                                                            );
                                                                      });
                                                                    },
                                                                    child: const SizedBox(
                                                                        child: Text(
                                                                            "yes",
                                                                            style:
                                                                                TextStyle(color: Colors.white)))),
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                      },
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 15),
                                                        height: 15,
                                                        width: context.width,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child: const Center(
                                                            child: Text(
                                                                "Remove",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                      )),
                                                ),
                                              ]),
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                showBottomSheet(
                                                  context: context,
                                                  builder: (c) => SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.7,
                                                    width: double.infinity,
                                                    child: SizedBox(
                                                      child: Column(
                                                        children: [
                                                          Image.network(
                                                              fit: BoxFit.fill,
                                                              '${data["url"]}'),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Text(
                                                            data['proudctname']
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blue
                                                                    .shade900,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            data['price']
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blue
                                                                    .shade900,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const Divider(
                                                            color: Colors.black,
                                                          ),
                                                          Expanded(
                                                            child:
                                                                SingleChildScrollView(
                                                              child: SizedBox(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.5,
                                                                width: double
                                                                    .infinity,
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      data['description']
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .blue
                                                                              .shade900,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Center(
                                                                      child:
                                                                          SizedBox(
                                                                        child: Center(
                                                                            child: Text(
                                                                          "Model ${data["made"]}",
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.bold),
                                                                        )),
                                                                      ),
                                                                    ),
                                                                    Center(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          TextButton(
                                                                              child: Text("Cancel", style: TextStyle(color: Colors.blue.shade900)),
                                                                              onPressed: () {
                                                                                Navigator.of(c).pop();
                                                                              }),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                "show description",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ),
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

  Future uploadFile(var price, var proudctname, var made, var url) async {
    try {
      await FirebaseFirestore.instance.collection('orders').add({
        'price': price,
        'proudctname': proudctname,
        'made': made,
        'url': url
      });
    } catch (e) {
      log('error occured');
    }
  }
}
