import 'package:flutter/material.dart';
import 'package:grandeur_app/screens/login.dart';
import 'package:grandeur_app/screens/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.green),
        home: const Scaffold(
          body: Center(child: Register(title: 'Register your account')),
        ));
  }
}
