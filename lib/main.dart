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
        title: 'Grandeur Beauty and Spa',
        onGenerateRoute: (settings) {
          if (settings.name == Register.routeName) {
            return MaterialPageRoute(builder: (context) {
              return const Register(title: 'Grandeur: Signup');
            });
          }
          if (settings.name == Login.routeName) {
            return MaterialPageRoute(builder: (context) {
              return const Login(title: 'Grandeur: Signup');
            });
          }
          return null;
        },
        theme: ThemeData(primarySwatch: Colors.green),
        home: const Login(title: 'Grandeur: Signup'));
  }
}
