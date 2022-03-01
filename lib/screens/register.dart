import 'package:flutter/material.dart';
import 'package:grandeur_app/models/user.dart';

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
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20.0),
          child: buildColumn()),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Expanded(
                child: TextField(
              controller: _firstname,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter firstname',
              ),
            ))),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Expanded(
                child: TextField(
              controller: _lastname,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter lastname',
              ),
            ))),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Expanded(
                child: TextField(
              controller: _phoneNumber,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Mobile number',
              ),
            ))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Expanded(
                child: TextField(
              controller: _password,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter password',
              ),
            ))),
        Expanded(
            child: ElevatedButton(
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
        ))
      ],
    );
  }
}
