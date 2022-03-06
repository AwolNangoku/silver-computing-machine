import 'package:flutter/material.dart';
import 'package:grandeur_app/models/user.dart';
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
  final TextEditingController _bookingDetails = TextEditingController();

  late bool isAddingBooking = false;
  late User signedUser;
  LocalStorage storage = LocalStorage('grandeur_app');

  @override
  void initState() {
    super.initState();
    setState(() {
      signedUser = storage.getItem('user');
    });
  }

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
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Expanded(
                child: TextField(
              controller: _bookingDetails,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Booking Details',
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
                print(
                    'Adding a new booking loggedInuser: ${signedUser.id} firstname: ${_firstname.text} lastname: ${_lastname.text} emailAddress: ${_email.text} mobileNumber: ${_phoneNumber.text} ');
                // serverPost('http://10.0.2.2:3000/booking/add/signedUser.id', {
                //   'loggedInuser': signedUser.id,
                //   'firstname': _firstname.text,
                //   'lastname': _lastname.text,
                //   'emailAddress': _email.text,
                //   'mobileNumber': _phoneNumber.text,
                //   'bookingDetails: _bookingDetails._text,
                // }).then((value) => {
                //       storage.setItem('user', User.fromJson(value['user'])),
                //       Navigator.of(context).pushReplacementNamed(
                //           Profile.routeName,
                //           arguments: User.fromJson(value['user']))
                //     });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Saving booking...')),
                );
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
