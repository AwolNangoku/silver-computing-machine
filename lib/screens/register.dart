import 'package:flutter/material.dart';
import 'package:grandeur_app/models/user.dart';
import 'package:grandeur_app/screens/profile.dart';
import 'package:grandeur_app/utils/server_post.dart';
import 'package:localstorage/localstorage.dart';

class RegistrationData {
  String? firstname;
  String? lastname;
  String? emailAddress;
  String? password;
  String? mobileNumber;
  String? idNumber;
  String? bio;

  RegistrationData(
      {this.firstname,
      this.lastname,
      this.emailAddress,
      this.idNumber,
      this.password,
      this.mobileNumber,
      this.bio});

  Object toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'emailAddress': emailAddress,
      'password': password,
      'mobileNumber': mobileNumber,
      'idNumber': idNumber,
      'bio': bio
    };
  }
}

class Register extends StatefulWidget {
  const Register({Key? key, required this.title}) : super(key: key);

  // This widget is the login page of the application.

  final String title;
  static const String routeName = '/register';

  @override
  State<Register> createState() => _RegisterSate();
}

class _RegisterSate extends State<Register> {
  RegistrationData accountFormData = RegistrationData();

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
                ? buildAccountForm()
                : Column(
                    children: const <Widget>[
                      CircularProgressIndicator(),
                      Text('Creating account...')
                    ],
                  ),
          )),
    );
  }

  Form buildAccountForm() {
    return Form(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              autofocus: true,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'First Name',
              ),
              onChanged: (value) {
                accountFormData.firstname = value;
              },
            )),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Last Name',
              ),
              onChanged: (value) {
                accountFormData.lastname = value;
              },
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'example@domain.com',
              labelText: 'Email Address',
            ),
            onChanged: (value) {
              accountFormData.emailAddress = value;
            },
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Password',
              ),
              obscureText: true,
              onChanged: (value) {
                accountFormData.password = value;
              },
            )),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Mobile Number',
              ),
              onChanged: (value) {
                accountFormData.mobileNumber = value;
              },
            )),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Identity Number',
              ),
              onChanged: (value) {
                accountFormData.idNumber = value;
              },
            )),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'A little bit about yourself ^_^',
                labelText: 'Bio Details',
              ),
              onChanged: (value) {
                accountFormData.bio = value;
              },
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isCreatingAccount = true;
                });

                try {
                  var accountResults = await serverPost(
                      'http://10.0.2.2:3000/account/register',
                      accountFormData.toJson());
                  if (accountResults['success']) {
                    var newUser = User.fromJson(accountResults['user']);

                    storage.setItem('user', newUser);
                    Navigator.of(context)
                        .pushReplacementNamed(Profile.routeName);
                  }
                } catch (error) {
                  setState(() {
                    isCreatingAccount = false;
                  });
                }
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
    ));
  }
}
