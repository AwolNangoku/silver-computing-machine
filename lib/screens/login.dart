import 'package:flutter/material.dart';
import 'package:grandeur_app/models/user.dart';
import 'package:grandeur_app/screens/profile.dart';
import 'package:grandeur_app/utils/server_post.dart';
import 'package:grandeur_app/screens/register.dart';
import 'package:localstorage/localstorage.dart';

class LoginData {
  String? username;
  String? password;

  LoginData({
    this.username,
    this.password,
  });

  Object toJson() {
    return {'username': username, 'password': password};
  }
}

class Login extends StatefulWidget {
  const Login({Key? key, required this.title}) : super(key: key);

  // This widget is the login page of the application.

  final String title;
  static const String routeName = '/login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late bool isSigningIn = false;
  LoginData loginFormData = LoginData();

  LocalStorage storage = LocalStorage('grandeur_app');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: !isSigningIn
              ? Form(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Expanded(
                            child: TextFormField(
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'example@domain.com',
                            labelText: 'Email Address',
                          ),
                          onChanged: (value) {
                            loginFormData.username = value;
                          },
                        ))),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Expanded(
                            child: TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: '****************',
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          onChanged: (value) {
                            loginFormData.password = value;
                          },
                        ))),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isSigningIn = true;
                              });
                              try {
                                var loginResults = await serverPost(
                                    'http://10.0.2.2:3000/account/login',
                                    loginFormData.toJson());

                                if (loginResults['success']) {
                                  var loggedInuser =
                                      User.fromJson(loginResults['user']);
                                  storage.setItem('user', loggedInuser);

                                  Navigator.of(context).pushReplacementNamed(
                                      Profile.routeName,
                                      arguments: loggedInuser);
                                } else {
                                  setState(() {
                                    isSigningIn = false;
                                  });
                                }
                              } catch (error) {
                                setState(() {
                                  isSigningIn = false;
                                });
                              }
                            },
                            child: const Text('Sign in'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Register.routeName);
                            },
                            child: const Text('Sign up'),
                          )
                        ])
                  ],
                ))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                      CircularProgressIndicator(),
                      Text('Signing in...')
                    ]),
        ));
  }
}
