import 'package:flutter/material.dart';
import 'package:grandeur_app/utils/server_post.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.title}) : super(key: key);

  // This widget is the login page of the application.

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _username,
              decoration: const InputDecoration(hintText: 'Enter username'),
            ),
            TextField(
              controller: _password,
              decoration: const InputDecoration(hintText: 'Enter password'),
            ),
            ElevatedButton(
              onPressed: () {
                String uname = _username.text;
                String pword = _password.text;

                serverPost('http://10.0.2.2:3000/account/login',
                    {'username': uname, 'password': pword});
              },
              child: const Text('Sign in'),
            )
          ],
        ),
      ),
    );
  }
}
