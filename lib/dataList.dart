import 'dart:convert';

import 'package:demoapi/apiCall.dart';
import 'package:demoapi/model/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void deleteData() async {
    var response = await http.delete(Uri.parse(login + '/1'),
        headers: {"Content-Type": "application/json"});
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    print(response.statusCode);
  }

  late List<Users>? _userModel = [];
  final String login = 'http://192.168.20.46:8080/api/users';
  void _getData() async {
    const storage = FlutterSecureStorage();
    try {
      var value = await storage.read(key: 'token');
      print("---");
      print(value);
      var response = await http.get(Uri.parse(login), headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $value"
      });
      _userModel = usersFormJson(response.body);
      Future.delayed(const Duration(seconds: 1))
          .then((value) => setState(() {}));
    } catch (e) {
      print(e);
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert!!"),
          content: Text("You are awesome!"),
          actions: [
            MaterialButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Widget _getProductList(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          elevation: 5,
          shadowColor: Colors.black,
          title: Text('Rest API Example for Post'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  "/form",
                );
              },
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/home/", (route) => false);
              },
              icon: const Icon(Icons.gamepad),
            ),
          ],
        ),
        body: _userModel == null
            ? const Center(
                child: LinearProgressIndicator(),
              )
            : Center(
                child: ListView.builder(
                  itemCount: _userModel!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const FlutterLogo(
                        size: 40,
                      ),
                      title: Text(_userModel![index].username.toString()),
                      subtitle: Text(_userModel![index].email.toString()),
                      trailing: PopupMenuButton<int>(
                        itemBuilder: (context) => [
                          // PopupMenuItem 1
                          const PopupMenuItem(
                            value: 1,
                            // row with 2 children
                            child: Row(
                              children: [
                                Icon(Icons.add_moderator),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Edit")
                              ],
                            ),
                          ),
                          // PopupMenuItem 2
                          const PopupMenuItem(
                            value: 2,
                            // row with two children
                            child: Row(
                              children: [
                                Icon(Icons.delete_forever_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("delete")
                              ],
                            ),
                          ),
                        ],
                        offset: const Offset(0, 100),
                        color: Colors.grey,
                        elevation: 2,
                        // on selected we show the dialog box
                        onSelected: (value) {
                          // if value 1 show dialog
                          if (value == 1) {
                            _showDialog(context);
                            // if value 2 show dialog
                          } else if (value == 2) {
                            _showDialog(context);
                          }
                        },
                      ),
                    );
                  },
                ),
              ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _getProductList(context);
  }
}
