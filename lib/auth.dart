import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String? uid;

class AuthenticationHelper {
  String? uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  Future signUp(
      {String? email,
      String? password,
      String? firstname,
      String? lastname,
      String? phonenum}) async {
    try {
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future addUser(
      String firstname, String lasttname, String phonenum, String email) {
    DocumentReference<Map<String, dynamic>> users = FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser?.uid.toString());

    return users
        .set({
          'firstname': firstname, 
          'lasttname': lasttname, 
          'phonenum': phonenum,
          'email': email
        })
        .then((value) => log("User Added"))
        .catchError((error) => log("Failed to add user: $error"));
  }

  Future signIn({String? email, String? password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      uid = user.uid;
      log("kkkhjbkbjh${uid!}");
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future resetpassword(String? email) async {
    try {
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signOut() async {
    await _auth.signOut();
  }

  String getCurrentUID() {
    uid = user.uid;
    return uid!;
  }

  Future<void> deleblackl() async {
    final collection =
        await FirebaseFirestore.instance.collection("orders").get();

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in collection.docs) {
      batch.delete(doc.reference);
    }

    return batch.commit();
  }
}
