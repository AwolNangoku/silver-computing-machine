import 'package:flutter/material.dart';
import 'package:grandeur_app/models/user.dart';
import 'package:grandeur_app/screens/booking.dart';
import 'package:grandeur_app/screens/bookings.dart';
import 'package:grandeur_app/screens/login.dart';
import 'package:localstorage/localstorage.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
          DrawerHeader(
              decoration: const BoxDecoration(color: Colors.green),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        width: 50,
                        height: 50,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            imageUrl:
                                'https://www.allthetests.com/quiz22/picture/pic_1171831236_1.png',
                            fit: BoxFit.fill,
                          ),
                        )),
                    const Text('App Settings')
                  ])),
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
        onPressed: () => Navigator.pushNamed(context, Booking.routeName),
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipOval(
                  child: CachedNetworkImage(
                width: 150,
                height: 150,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                imageUrl:
                    'https://www.allthetests.com/quiz22/picture/pic_1171831236_1.png',
                fit: BoxFit.fill,
              )),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('First Name:'),
                    Text(snapshot.data!.firstname)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Last Name:'),
                    Text(snapshot.data!.lastname)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Email Address:'),
                    Text(snapshot.data!.emailAddress)
                  ],
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
