import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<loginpage> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final String login = 'http://192.168.20.46:8080/api/auth/signin';

  void loginData() async {
    var reqBody = {
      "username": emailTextEditingController.text,
      "password": passwordTextEditingController.text,
    };
    var response = await http.post(Uri.parse(login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

    var jsonResponse = jsonDecode(response.body);
    const storage = FlutterSecureStorage();
    await storage.write(key: 'token', value: jsonResponse['jwtToken']);
//tosavetoken
    print(jsonResponse);
    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(154, 70, 37, 6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 35.0,
              ),
              const Image(
                // image: AssetImage("images/logo.png"),
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
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 18.0,
                        ),
                        // hintText: "Email",
                        hintStyle: TextStyle(fontSize: 25, color: Colors.grey),
                      ),
                      style:
                          const TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 18.0,
                        ),
                        // hintText: "Email",
                        hintStyle: TextStyle(fontSize: 25, color: Colors.grey),
                      ),
                      style:
                          const TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 228, 170, 94)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 146, 244, 54))))),
                      child: Container(
                        height: 50.0,
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: "bolt-semibold",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        loginData();
                        // if (!emailTextEditingController.text.contains("@")) {
                        //   displayToastMessage(
                        //     "Invalid email. ",
                        //   );
                        // } else if (passwordTextEditingController.text.length <
                        //     6) {
                        //   displayToastMessage(
                        //     "Invalid password. ",
                        //   );
                        // }
                      },
                    )
                  ],
                ),
              ),
              // TextButton(
              //     onPressed: () {
              //       Navigator.pushNamedAndRemoveUntil(
              //           context, "/register", (route) => false);
              //       print("Registered Button Clicked");
              //     },
              //     child: Text("Do not have an Account? Register Here"))
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
