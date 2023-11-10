import 'package:flutter/material.dart';

var formKey = GlobalKey<FormState>();

Widget txtFormName({
  required var typecontrol,
  bool isCheck = false,
  required IconData? prefixicon,
  required Color? prefixIconiconColor,
  required String? txt,
  var hidepassword,
  Color? suffixIconcolor,
  IconData? suffixicon,
  TextInputType? txtinput,
}) {
  return TextFormField(
    obscureText: isCheck,
    keyboardType: txtinput,
    controller: typecontrol,
    style: const TextStyle(color: Colors.blue),
    decoration: InputDecoration(
      border: InputBorder.none,
      prefixIcon: Icon(
        prefixicon,
        color: prefixIconiconColor,
        size: 20,
      ),
      hintText: txt!,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.blue.shade900)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.blue.shade900)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.red.shade900)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.blue.shade900)),
      suffixIcon: IconButton(
          onPressed: hidepassword,
          icon: Icon(
            suffixicon,
            color: suffixIconcolor,
          )),
    ),
    validator: (value) {
      if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
        return 'Enter correct name';
      } else {
        return null;
      }
    },
  );
}

Widget txtFormEmail({
  required var typecontrol,
  required IconData? prefixicon,
  required Color? prefixIconiconColor,
  required String? txt,
  TextInputType? txtinput,
}) {
  return TextFormField(
    keyboardType: txtinput,
    controller: typecontrol,
    style: const TextStyle(color: Colors.blue),
    decoration: InputDecoration(
      border: InputBorder.none,
      prefixIcon: Icon(
        prefixicon,
        color: prefixIconiconColor,
        size: 20,
      ),
      hintText: txt!,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.blue.shade900)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.blue.shade900)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.red.shade900)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.blue.shade900)),
    ),
    validator: (value) {
      if (value!.isEmpty ||
          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
        return 'Enter correct E-mail';
      } else {
        return null;
      }
    },
  );
}

Widget txtFormPassword({
  required var typecontrol,
  bool isCheck = false,
  required IconData? prefixicon,
  required Color? prefixIconiconColor,
  required String? txt,
  var hidepassword,
  Color? suffixIconcolor,
  IconData? suffixicon,
  TextInputType? txtinput,
}) {
  return TextFormField(
    obscureText: isCheck,
    keyboardType: txtinput,
    controller: typecontrol,
    style: const TextStyle(color: Colors.blue),
    decoration: InputDecoration(
      border: InputBorder.none,
      prefixIcon: Icon(
        prefixicon,
        color: prefixIconiconColor,
        size: 20,
      ),
      hintText: txt!,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.blue.shade900)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.blue.shade900)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.red.shade900)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.blue.shade900)),
      suffixIcon: IconButton(
          onPressed: hidepassword,
          icon: Icon(
            suffixicon,
            color: suffixIconcolor,
          )),
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Enter the password';
      } else {
        return null;
      }
    },
  );
}

Widget txtFormPhone({
  required var typecontrol,
  required IconData? prefixicon,
  required Color? prefixIconiconColor,
  required String? txt,
  TextInputType? txtinput,
}) {
  return TextFormField(
    keyboardType: txtinput,
    controller: typecontrol,
    style: const TextStyle(color: Colors.blue),
    decoration: InputDecoration(
      border: InputBorder.none,
      prefixIcon: Icon(
        prefixicon,
        color: prefixIconiconColor,
        size: 20,
      ),
      hintText: txt!,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.blue.shade900)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.blue.shade900)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.red.shade900)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.blue.shade900)),
    ),
    validator: (value) {
      if (value!.isEmpty ||
          !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
              .hasMatch(value)) {
        return 'Enter correct phone number';
      } else {
        return null;
      }
    },
  );
}
