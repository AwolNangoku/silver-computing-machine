import 'package:flutter/material.dart';
import 'package:grandeur_app/models/user.dart';
import 'package:grandeur_app/screens/profile.dart';
import 'package:grandeur_app/utils/server_post.dart';
import 'package:localstorage/localstorage.dart';

class BookingData {
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

  late bool isAddingBooking = false;
  late User signedUser;
  DateTime bookingDate = DateTime.now();

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
                : Column(
                    children: const <Widget>[
                      CircularProgressIndicator(),
                      Text('Adding booking...')
                    ],
                  ),
          )),
    );
  }

  selectBookingDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: bookingDate,
        firstDate: DateTime(1970),
        lastDate: DateTime(2025 + 1),
        helpText: "Select Booking Date",
        cancelText: "Not Now",
        confirmText: "Book");

    if (selectedDate != null && selectedDate != bookingDate) {
      setState(() {
        bookingDate = selectedDate;
      });
    }
  }

  Form buildBookingForm() {
    debugPrint(bookingDate.toString());
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
                  bookingFormData.firstname = value;
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
                  bookingFormData.lastname = value;
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
                bookingFormData.emailAddress = value;
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Mobile Number',
                ),
                onChanged: (value) {
                  bookingFormData.mobileNumber = value;
                },
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextButton(
                  child: const Text('Select Date'),
                  onPressed: () {
                    selectBookingDate(context);
                  })),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Booking Details',
                ),
                onChanged: (value) {
                  bookingFormData.bookingDetails = value;
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isAddingBooking = true;
                  });
                  try {
                    var bookingResults = await serverPost(
                        'http://10.0.2.2:3000/booking/add/${signedUser.id}',
                        bookingFormData.toJson());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Saving booking...')),
                    );
                    if (bookingResults['success']) {
                      Navigator.of(context)
                          .pushReplacementNamed(Profile.routeName);
                    }
                  } catch (error) {
                    setState(() {
                      isAddingBooking = false;
                    });
                  }
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
