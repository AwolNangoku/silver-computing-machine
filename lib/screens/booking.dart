import 'package:flutter/material.dart';
import 'package:grandeur_app/models/user.dart';
import 'package:grandeur_app/screens/profile.dart';
import 'package:grandeur_app/utils/server_post.dart';
import 'package:localstorage/localstorage.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key, required this.title}) : super(key: key);

  final String title;
  static const String routeName = '/booking';

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();

  late bool isAddingBooking = false;
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
            child: !isAddingBooking
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
                labelText: 'First Name',
              ),
            ))),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Expanded(
                child: TextField(
              controller: _lastname,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Last Name',
              ),
            ))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Expanded(
              child: TextField(
            controller: _email,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Email Address',
            ),
          )),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Expanded(
                child: TextField(
              controller: _phoneNumber,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Phone Number',
              ),
            ))),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isAddingBooking = true;
                });
                print('Adding a new booking');
                // serverPost('http://10.0.2.2:3000/booking/add', {
                //   'firstname': _firstname.text,
                //   'lastname': _lastname.text,
                //   'emailAddress': _email.text,
                //   'mobileNumber': _phoneNumber.text,
                // }).then((value) => {
                //       storage.setItem('user', User.fromJson(value['user'])),
                //       Navigator.of(context).pushReplacementNamed(
                //           Profile.routeName,
                //           arguments: User.fromJson(value['user']))
                //     });
              },
              child: const Text('Submit'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            )
          ],
        )
      ],
    );
  }
}
