import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'widgets.dart';
import 'loginscreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var check = true;
  var check2 = true;
  var email = TextEditingController();
  var password = TextEditingController();
  var password2 = TextEditingController();
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var phonenumber = TextEditingController();

  void hidePassword() {
    setState(() {
      if (check == true) {
        check = false;
      } else {
        check = true;
      }
    });
  }

  void hidePassword2() {
    setState(() {
      if (check2 == true) {
        check2 = false;
      } else {
        check2 = true;
      }
    });
  }

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
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Color.fromARGB(255, 30, 61, 106),
                          )),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Center(
                        child: Text(
                      "Let's Get Started!",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )),
                    const Center(
                        child: Text(
                      "Create an account to get all features",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                      ),
                    )),
                    const SizedBox(
                      height: 65,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.grey[50]),
                        child: txtFormName(
                            typecontrol: firstname,
                            prefixicon: Icons.person,
                            prefixIconiconColor: Colors.grey,
                            txt: "First Name")),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.grey[50]),
                        child: txtFormName(
                            typecontrol: lastname,
                            prefixicon: Icons.person,
                            prefixIconiconColor: Colors.grey,
                            txt: "Last Name")),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.grey[50]),
                        child: txtFormPhone(
                            typecontrol: phonenumber,
                            txtinput: TextInputType.phone,
                            prefixicon: Icons.phone,
                            prefixIconiconColor: Colors.grey,
                            txt: "Phone Number")),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.grey[50]),
                        child: txtFormEmail(
                            txtinput: TextInputType.emailAddress,
                            typecontrol: email,
                            prefixicon: Icons.email_outlined,
                            prefixIconiconColor: Colors.grey,
                            txt: "E-mail")),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.white),
                        child: txtFormPassword(
                            typecontrol: password,
                            isCheck: check,
                            prefixicon: Icons.lock_outline,
                            prefixIconiconColor: Colors.grey,
                            txt: "Password",
                            hidepassword: hidePassword,
                            suffixicon: Icons.remove_red_eye_outlined,
                            suffixIconcolor: Colors.grey)),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.white),
                        child: txtFormPassword(
                            typecontrol: password2,
                            isCheck: check2,
                            prefixicon: Icons.lock_outline,
                            prefixIconiconColor: Colors.grey,
                            txt: "Confirm Password",
                            hidepassword: hidePassword2,
                            suffixicon: Icons.remove_red_eye_outlined,
                            suffixIconcolor: Colors.grey)),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(email.text) ||
                                password.toString().isEmpty ||
                                password2.toString().isEmpty ||
                                firstname.toString().isEmpty ||
                                !RegExp(r'^[a-z A-Z]+$')
                                    .hasMatch(firstname.text) ||
                                !RegExp(r'^[a-z A-Z]+$')
                                    .hasMatch(lastname.text) ||
                                lastname.toString().isEmpty ||
                                password2.text == password.text) {
                              if (formKey.currentState!.validate()) {
                                if (formKey.currentState!.validate()) {
                                  
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                  signup(
                                      email.text,
                                      password.text,
                                      firstname.text,
                                      lastname.text,
                                      phonenumber.text);
                                }
                              }
                            
                            }
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 30, 61, 106),
                              borderRadius: BorderRadius.circular(30)),
                          child: const Center(
                              child: Text(
                            "Sign up",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signup(var email, password, firstname, lastname, phone) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      CollectionReference<Map<String, dynamic>> user =
          FirebaseFirestore.instance.collection('users');

      user.doc(userCredential.user!.uid).set({
        'firstname': firstname,
        'lasttname': lastname,
        'phonenum': phone,
        'email': email,
      });

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.blue.shade900,
          title: const Text('Success message',
              style: TextStyle(color: Colors.white)),
          content: const Text("Successfully registered",
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const SizedBox(
                  child: Text("okay", style: TextStyle(color: Colors.white))),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.blue.shade900,
          title: const Text('Error Massage',
              style: TextStyle(color: Colors.white)),
          content: Text("$e", style: const TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const SizedBox(
                  child: Text("okay", style: TextStyle(color: Colors.white))),
            ),
          ],
        ),
      );
    }
  }
}
