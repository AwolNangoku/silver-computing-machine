import 'package:flutter/material.dart';
import 'package:grandeur_app/screens/login.dart';
import 'package:grandeur_app/screens/profile.dart';

class Bookings extends StatelessWidget {
  final String title;

  const Bookings({Key? key, required this.title}) : super(key: key);

  static const String routeName = '/bookings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20.0),
          child: Text(title)),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text('App settings')),
          ListTile(
            title: const Text('My Profile'),
            onTap: () => Navigator.pushNamed(context, Profile.routeName),
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
