import 'package:flutter/material.dart';
import 'package:grandeur_app/models/user.dart';
import 'package:grandeur_app/screens/bookings.dart';
import 'package:grandeur_app/screens/login.dart';

class Profile extends StatelessWidget {
  final String title;
  final User signedInUser;

  const Profile({Key? key, required this.title, required this.signedInUser})
      : super(key: key);

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20.0),
          child: const Text('Grandeur profile.')),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text('App settings')),
          ListTile(
            title: const Text('My Bookings'),
            onTap: () => Navigator.pushNamed(context, Bookings.routeName),
          ),
          ListTile(
            title: const Text('Sign out'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(Login.routeName),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('Add a booking'),
        tooltip: 'Book a Grandeur Beauty and Spa session',
        child: const Icon(Icons.add),
      ),
    );
  }
}
