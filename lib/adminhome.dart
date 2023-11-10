import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/widgets.dart';

class ImageUploads extends StatefulWidget {
  const ImageUploads({Key? key}) : super(key: key);

  @override
  ImageUploadsState createState() => ImageUploadsState();
}

class ImageUploadsState extends State<ImageUploads> {
  var price = TextEditingController();
  var productname = TextEditingController();
  var made = TextEditingController();
  var discount = TextEditingController();
  var description = TextEditingController();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile(price.text, productname.text, made.text, discount.text,
            description.text);
      } else {
        log('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile(price.text, productname.text, made.text, discount.text,
            description.text);
      } else {
        log('No image selected.');
      }
    });
  }

  Future uploadFile(var price, var proudctname, var made, var discount,
      var description) async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
      final url = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('products')
          .add({
            'price': price,
            'proudctname': proudctname,
            'made': made,
            'url': url,
            'discount': discount,
            'description': description,
          })
          .then((value) => (log(value.id)))
          .catchError((error) => log("Failed to add user: $error"));
    } catch (e) {
      log('error occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 32,
              ),
              Container(
                width: context.width,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(35)),
                child: txtFormName(
                    typecontrol: price,
                    prefixIconiconColor: Colors.grey,
                    prefixicon: Icons.price_check,
                    txt: "Enter the price of the car"),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: context.width,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(35)),
                child: txtFormName(
                    typecontrol: productname,
                    prefixIconiconColor: Colors.grey,
                    prefixicon: Icons.car_crash,
                    txt: "Enter the car type"),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: context.width,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(35)),
                child: txtFormName(
                    typecontrol: made,
                    prefixIconiconColor: Colors.grey,
                    prefixicon: Icons.date_range,
                    txt: "Enter the car model"),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: context.width,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(35)),
                child: txtFormName(
                    typecontrol: discount,
                    prefixIconiconColor: Colors.grey,
                    prefixicon: Icons.discount_outlined,
                    txt: "Enter discount"),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: context.width,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(35)),
                child: txtFormName(
                    typecontrol: description,
                    prefixIconiconColor: Colors.grey,
                    prefixicon: Icons.date_range,
                    txt: "Enter the descripiton"),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.blue.shade900,
                    child: _photo != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _photo!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(50)),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: SizedBox(
              child: Wrap(
                children: [
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
