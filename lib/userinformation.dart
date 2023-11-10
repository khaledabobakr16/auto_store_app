import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:shop_app/orders.dart';

var count = 0;

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  UserInformationState createState() => UserInformationState();
}

class UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
        actions: [
          Stack(
            children: [
              Positioned(
                  left: 20,
                  bottom: 37,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50)),
                    height: 18,
                    width: 20,
                    child: Center(child: Text("$count")),
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Orders()),
                        (Route<dynamic> route) => false,
                      );
                    });
                  },
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    size: 28,
                    color: Colors.grey[50],
                  )),
            ],
          )
        ],
        title: const Column(
          children: [
            Text(
              "Let's find your Car ",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20)),
              height: MediaQuery.of(context).size.height * 0.25,
              child: Image.asset(fit: BoxFit.fill, "images/carrr.png"),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                return GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Stack(
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Colors.blue.shade900),
                                borderRadius: BorderRadius.circular(20.0)),
                            elevation: 10,
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 6,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: Image.network(
                                      fit: BoxFit.fill, '${data["url"]}'),
                                ),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blue.shade900,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              data['proudctname'].toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              data['price'].toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ]),
                                      const Spacer(),
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: IconButton(
                                          onPressed: () {
                                            showBottomSheet(
                                              context: context,
                                              builder: (c) => SizedBox(
                                                height: MediaQuery.of(context)
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
                                                                .blue.shade900,
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
                                                                .blue.shade900,
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
                                                            width:
                                                                double.infinity,
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
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Center(
                                                                  child:
                                                                      SizedBox(
                                                                    child: Center(
                                                                        child: Text(
                                                                      "Model ${data["made"]}",
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )),
                                                                  ),
                                                                ),
                                                                Center(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      TextButton(
                                                                          child: Text(
                                                                              "Cancel",
                                                                              style: TextStyle(color: Colors.blue.shade900)),
                                                                          onPressed: () {
                                                                            Navigator.of(c).pop();
                                                                          }),
                                                                      InkWell(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              snapshot.data?.docs;
                                                                              String price = data["price"].toString();
                                                                              String discount = data["discount"].toString();
                                                                              String productname = data["proudctname"].toString();
                                                                              String made = data["made"].toString();
                                                                              String url = data["url"].toString();
                                                                              String id = document.id.toString();
                                                                              log(document.id.toString());

                                                                              uploadFile(
                                                                                price,
                                                                                productname,
                                                                                made,
                                                                                url,
                                                                                id,
                                                                                discount,
                                                                              );
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (ctx) => AlertDialog(
                                                                                  backgroundColor: Colors.blue.shade900,
                                                                                  title: const Text('', style: TextStyle(color: Colors.white)),
                                                                                  content: const Text("Look at the shopping cart to confirm the order", style: TextStyle(color: Colors.white)),
                                                                                  actions: <Widget>[
                                                                                    TextButton(
                                                                                        onPressed: () {
                                                                                          setState(() {
                                                                                            count++;
                                                                                          });
                                                                                          Navigator.of(ctx).pop();
                                                                                        },
                                                                                        child: const SizedBox(child: Text("okay", style: TextStyle(color: Colors.white)))),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                25,
                                                                            width:
                                                                                130,
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
                                                                            child:
                                                                                const Center(
                                                                              child: Text(
                                                                                "Buy Now",
                                                                                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                          )),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
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
                                          icon: const Icon(
                                              Icons.read_more_rounded),
                                          color: Colors.blue.shade900,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                        Positioned(
                            right: 20,
                            top: 5,
                            child: Container(
                              height: 15,
                              width: 30,
                              color: Colors.red,
                              child: Center(
                                child: Text(
                                  data["discount"].toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future uploadFile(var price, var proudctname, var made, var url, var id,
      var discount) async {
    try {
      await FirebaseFirestore.instance.collection('orders').add({
        'price': price,
        'proudctname': proudctname,
        'made': made,
        'url': url,
        "id": id,
        "discount": discount
      });
    } catch (e) {
      log('error occured');
    }
  }
}
