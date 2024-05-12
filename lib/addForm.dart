import 'dart:convert';

import 'package:demoapi/model/users.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class createform extends StatefulWidget {
  const createform({super.key});

  @override
  State<createform> createState() => _createformState();
}

class _createformState extends State<createform> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: addform()),
    );
  }
}

class addform extends StatelessWidget {
  addform({super.key});
  static String idScreen = "form";
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController firstnameTextEditingController =
      TextEditingController();
  TextEditingController lastnameTextEditingController = TextEditingController();
  final String create = 'http://192.168.20.46:8080/api/users';
  Future<void> addData(Users user) async {
    var response = await http.post(Uri.parse(create),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user.toJson()));
    print(response.body);
    print("hellojava");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(154, 70, 37, 6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              const Image(
                image: NetworkImage(
                    "https://us.123rf.com/450wm/boxfile123/boxfile1232010/boxfile123201000075/156598224-sm-logo-design-vector-icon-symbol-luxury.jpg"),
                width: 350.0,
                height: 200.0,
                alignment: Alignment.center,
              ),
              const SizedBox(
                height: 1.0,
              ),
              const Text(
                "SM Enterprise",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: usernameTextEditingController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: "User Name",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        // hintText: "Email",
                        hintStyle: TextStyle(fontSize: 25, color: Colors.grey),
                      ),
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        // hintText: "Email",
                        hintStyle: TextStyle(fontSize: 25, color: Colors.grey),
                      ),
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        // hintText: "Email",
                        hintStyle: TextStyle(fontSize: 25, color: Colors.grey),
                      ),
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    TextField(
                      controller: firstnameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "First Name",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        // hintText: "Email",
                        hintStyle: TextStyle(fontSize: 25, color: Colors.grey),
                      ),
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    TextField(
                      controller: lastnameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Last Name",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        // hintText: "Email",
                        hintStyle: TextStyle(fontSize: 25, color: Colors.grey),
                      ),
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 228, 170, 94)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            // side: BorderSide(color: Colors.red)
                          ))),
                      child: Container(
                        height: 50.0,
                        child: const Center(
                          child: Text(
                            "Registration",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "bolt-semibold",
                                color: Colors.white),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        // print("Registration Button Clicked");

                        String name = usernameTextEditingController.text;
                        String email = emailTextEditingController.text;
                        String password = passwordTextEditingController.text;
                        String userfirstName =
                            firstnameTextEditingController.text;
                        String userlastName =
                            lastnameTextEditingController.text;
                        Users user = Users(
                            username: name,
                            email: email,
                            password: password,
                            userFirstName: userfirstName,
                            userLastName: userlastName,
                            roles: []);
                        await addData(user);
                      },
                    ),
                  ],
                ),
              ),
              // TextButton(
              //     onPressed: () {
              //       print("Registered Button Clicked");

              //       Navigator.pushNamedAndRemoveUntil(
              //           context, "/login", (route) => false);
              //     },
              //     child: const Text("Already have an Account? Login Here"))
            ],
          ),
        ),
      ),
    );
  }
}

displayToastMessage(String message) {
  Fluttertoast.showToast(msg: message);
}
