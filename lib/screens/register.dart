import 'package:flutter/material.dart';
import 'package:grandeur_app/models/user.dart';
import 'package:grandeur_app/utils/server_post.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.title}) : super(key: key);

  // This widget is the login page of the application.

  final String title;

  @override
  State<Register> createState() => _RegisterSate();
}

class _RegisterSate extends State<Register> {
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _bio = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              controller: _firstname,
              decoration: const InputDecoration(hintText: 'Enter Firstname'),
            ),
            TextField(
              controller: _lastname,
              decoration: const InputDecoration(hintText: 'Enter Lastname'),
            ),
            TextField(
              controller: _phoneNumber,
              decoration:
                  const InputDecoration(hintText: 'Enter Mobile number'),
            ),
            TextField(
              controller: _email,
              decoration: const InputDecoration(hintText: 'Enter email'),
            ),
            TextField(
              controller: _password,
              decoration: const InputDecoration(hintText: 'Enter password'),
            ),
            ElevatedButton(
              onPressed: () {
                print(User(
                    name: _firstname.text,
                    email: _email.text,
                    password: _password.text,
                    phoneNumber: _phoneNumber.text,
                    bio: _bio.text));
                // serverPost(
                //     'http://10.0.2.2:3000/account/register',
                //     User(
                //         name: _firstname.text,
                //         email: _email.text,
                //         password: _password.text,
                //         phoneNumber: _phoneNumber.text,
                //         bio: _bio.text));
              },
              child: const Text('Register'),
            )
          ],
        ),
      ),
    );
  }
}
