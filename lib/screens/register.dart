import 'package:flutter/material.dart';
import 'package:grandeur_app/models/user.dart';
import 'package:grandeur_app/screens/profile.dart';
import 'package:grandeur_app/utils/server_post.dart';
import 'package:localstorage/localstorage.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.title}) : super(key: key);

  // This widget is the login page of the application.

  final String title;
  static const String routeName = '/register';

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
  final TextEditingController __idNumber = TextEditingController();

  late bool isCreatingAccount = false;
  LocalStorage storage = LocalStorage('grandeur_app');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: !isCreatingAccount
                ? buildColumn()
                : const CircularProgressIndicator(),
          )),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Expanded(
                child: TextField(
              controller: _firstname,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter firstname',
              ),
            ))),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Expanded(
                child: TextField(
              controller: _lastname,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter lastname',
              ),
            ))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Expanded(
              child: TextField(
            controller: _email,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter email address',
            ),
          )),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Expanded(
                child: TextField(
              obscureText: true,
              controller: _password,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter password',
              ),
            ))),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Expanded(
                child: TextField(
              controller: _phoneNumber,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter phone number',
              ),
            ))),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Expanded(
                child: TextField(
              controller: __idNumber,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter ID',
              ),
            ))),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Expanded(
                child: TextField(
              controller: _bio,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Bio details',
              ),
            ))),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isCreatingAccount = true;
                });
                serverPost('http://10.0.2.2:3000/account/register', {
                  'firstname': _firstname.text,
                  'lastname': _lastname.text,
                  'emailAddress': _email.text,
                  'password': _password.text,
                  'mobileNumber': _phoneNumber.text,
                  'idNumber': __idNumber.text,
                  'bio': _bio.text
                }).then((value) => {
                      storage.setItem('user', User.fromJson(value['user'])),
                      Navigator.of(context).pushReplacementNamed(
                          Profile.routeName,
                          arguments: User.fromJson(value['user']))
                    });
              },
              child: const Text('Register'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            )
          ],
        )
      ],
    );
  }
}
