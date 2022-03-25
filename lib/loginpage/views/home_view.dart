import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:management/loginpage/controller/home_controller.dart';
import 'package:management/main.dart';
import 'package:management/resources/app_strings.dart';
import 'package:management/roles/admin.dart';
import 'package:management/roles/no_user.dart';
import 'package:management/roles/super_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets.dart';

// nu:
// admin:view,
// superadmin:view,edit

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var email = snapshot.data!.getString('email');
            var password = snapshot.data!.getString('password');
            var role = snapshot.data!.getString('role');
            if (email != null && password != null && role != null) {
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: email, password: password)
                  .then((value) {
                initializeRole(value, email, password).then((value) {
                  Get.toNamed('/home/${AppStrings.CONTENT_ENTRY}');
                });
              });
              return Center(child: Container(child: CircularProgressIndicator()));
            }
            return Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(left: 28, right: 28),
                      height: context.height,
                      child: SingleChildScrollView(
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: controller.loginFormKey,
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: DropdownButton(
                                      elevation: 0,
                                      items: const [
                                        DropdownMenuItem(
                                          child: Text("'dark'"),
                                          value: 1,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("light"),
                                          value: 2,
                                        )
                                      ],
                                      hint: const Text("Themes"),
                                      onChanged: (int? value) {},
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: "Email",
                                  hintText: "name@example.com",
                                  prefixIcon: const Icon(Icons.email),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                controller: controller.emailController,
                                onSaved: (value) {
                                  controller.email = value!;
                                },
                                validator: (value) {
                                  return controller.validateEmail(value!);
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: "Password",
                                  prefixIcon: const Icon(FontAwesomeIcons.key),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                controller: controller.passwordController,
                                onSaved: (value) {
                                  controller.password = value!;
                                },
                                validator: (value) {
                                  return controller.validatePassword(value!);
                                },
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    width: context.width),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    controller.checkLogin();
                                    try {
                                      UserCredential userCredential =
                                          await FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: controller.email,
                                                  password:
                                                      controller.password);
                                      await initializeRole(
                                          userCredential,
                                          controller.email,
                                          controller.password);
                                      Get.toNamed(
                                          '/home/${AppStrings.CONTENT_ENTRY}');
                                    } on FirebaseAuthException catch (e) {
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
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              FlatButton(
                                  onPressed: () {},
                                  child: TextWidget("Forget your password?")),
                              const SizedBox(
                                height: 100,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey[300],
                                      height: 100,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: TextWidget('or continue with'),
                                  ),
                                  Expanded(
                                      child: Divider(
                                    color: Colors.grey[400],
                                    height: 50,
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                            ),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.blueAccent),
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(14),
                                          ),
                                        ),
                                        child: Wrap(
                                          children: const [
                                            Icon(FontAwesomeIcons.facebook),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Facebook",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        )),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                            ),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.deepPurpleAccent),
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(14),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 6.0, right: 6.0),
                                          child: Wrap(
                                            children: const [
                                              Icon(FontAwesomeIcons.twitter),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Twitter",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     TextWidget("Don't have account?"),
                              //     const SizedBox(
                              //       width: 10,
                              //     ),
                              //     FlatButton(
                              //       onPressed: () {
                              //         Get.toNamed('SignUpPage');
                              //       },
                              //       child: TextWidget("Sign up"),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

Future<void> initializeRole(userCreds, email, password) async {
  try {
    //FIXME: testing remove this later
    var TEST = "l57Ov9N45rb5M4rkrJxyrOakPrF3";
    userCreds = TEST;

    var value = //await FirebaseFirestore.instance.doc('Admin/$TEST').get();
        await FirebaseFirestore.instance.doc('Admin/${userCreds}').get();
    var role = value.get("role");
    if (role == "admin") {
      Get.put(AuthDataController(Admin(), userCreds));
    }
    if (role == "superadmin") {
      Get.put(AuthDataController(SuperAdmin(), userCreds));
    } else {
      Get.put(AuthDataController(NoUser(), userCreds));
    }
    //Shared prefs
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setString('role', role);
    print(prefs.getString('role'));
  } catch (exception) {
    Get.put(AuthDataController(NoUser(), userCreds));
  }
}
