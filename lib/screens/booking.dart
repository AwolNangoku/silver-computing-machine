import 'package:flutter/material.dart';
import 'package:grandeur_app/models/user.dart';
import 'package:grandeur_app/utils/server_post.dart';
import 'package:localstorage/localstorage.dart';

class BookingData {
  String? signedInUserId;
  String? firstname;
  String? lastname;
  String? emailAddress;
  String? password;
  String? mobileNumber;
  String? bookingDetails;

  BookingData(
      {this.firstname,
      this.lastname,
      this.emailAddress,
      this.mobileNumber,
      this.bookingDetails});

  Object toJson() {
    return {
      'signedInUserId': signedInUserId,
      'firstname': firstname,
      'lastname': lastname,
      'emailAddress': emailAddress,
      'mobileNumber': mobileNumber,
      'bookingDetails': bookingDetails,
    };
  }
}

class Booking extends StatefulWidget {
  const Booking({Key? key, required this.title}) : super(key: key);

  final String title;
  static const String routeName = '/booking';

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  BookingData bookingFormData = BookingData();
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
                ? buildBookingForm()
                : const CircularProgressIndicator(),
          )),
    );
  }

  Form buildBookingForm() {
    return Form(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Expanded(
                  child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'First Name',
                ),
                onChanged: (value) {
                  bookingFormData.firstname = value;
                },
              ))),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Expanded(
                  child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Last Name',
                ),
                onChanged: (value) {
                  bookingFormData.lastname = value;
                },
              ))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Expanded(
                child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'example@domain.com',
                labelText: 'Email Address',
              ),
              onChanged: (value) {
                bookingFormData.emailAddress = value;
              },
            )),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Expanded(
                  child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Mobile Number',
                ),
                onChanged: (value) {
                  bookingFormData.mobileNumber = value;
                },
              ))),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Expanded(
                  child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Booking Details',
                ),
                onChanged: (value) {
                  bookingFormData.bookingDetails = value;
                },
              ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // setState(() {
                  //   isAddingBooking = true;
                  // });
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
        ]));
  }
}
