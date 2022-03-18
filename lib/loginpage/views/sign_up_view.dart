import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../widgets.dart';


class SignUpPage extends StatelessWidget {
  // const SignUpPage({Key? key}) : super(key: key);
  var email ="";
  var pass = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Align(
                alignment: Alignment.center,
                child: Container(
                    margin: const EdgeInsets.only(top: 90, left: 28, right: 28),
                    height: context.height,
                    child: SingleChildScrollView(
                        child: Form(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                          const Text(
                            "Sign up",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextWidget("Create an Account"),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: ((value) => {
                              email=value
                            }),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: "Email",
                              hintText: "name@example.com",
                              prefixIcon: const Icon(Icons.email),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            // obscureText: true,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                             onChanged: ((value) => {
                              pass=value
                            }),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: "Password",
                              prefixIcon: const Icon(FontAwesomeIcons.key),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: "Confirm Password",
                              prefixIcon: const Icon(FontAwesomeIcons.key),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ConstrainedBox(
                            constraints:
                                BoxConstraints.tightFor(width: context.width),
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  UserCredential userCredential =
                                      await FirebaseAuth
                                          .instance
                                          .createUserWithEmailAndPassword(
                                              email: email,
                                              password: pass,
                                              );
                                               Get.toNamed('/home/:tab');
                                } 
                                on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    print('No user found for that email.');
                                  } else if (e.code == 'wrong-password') {
                                    print(
                                        'Wrong password provided for that user.');
                                  }
                                }
                               
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepPurpleAccent),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(14),
                                ),
                              ),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidget("Already have an account? "),
                              FlatButton(
                                  onPressed: () {
                                    Get.toNamed('/SignUpPage');
                                  },
                                  child: const Text("Login",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.purple,
                                      ))),
                            ],
                          ),
                        ])))))));
  }
}
