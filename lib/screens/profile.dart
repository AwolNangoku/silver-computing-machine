import 'package:flutter/material.dart';
import 'package:grandeur_app/models/user.dart';
import 'package:grandeur_app/screens/bookings.dart';
import 'package:grandeur_app/screens/login.dart';
import 'package:localstorage/localstorage.dart';

class Profile extends StatelessWidget {
  final String title;
  static LocalStorage storage = LocalStorage('grandeur_app');

  const Profile({Key? key, required this.title}) : super(key: key);

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
          child: buildFutureBuilder()),
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
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const Login(title: 'Grandeur: Signup')), (route) {
              storage.clear();
              return false;
            }),
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

  FutureBuilder<User> buildFutureBuilder() {
    return FutureBuilder<User>(
      future: Future<User>(() => storage.getItem('user')),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.firstname);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
