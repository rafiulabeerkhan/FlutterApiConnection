import 'package:demoapi/addForm.dart';
import 'package:demoapi/apiCall.dart';
import 'package:demoapi/dataList.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 23, 24, 1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/home/",
      routes: {
        "/login": (context) => loginpage(),
        "/home/": (context) => const Home(),
        "/form": (context) => createform(),
      },
    );
  }
}
