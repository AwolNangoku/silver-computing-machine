import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grandeur_app/models/user.dart';
import 'package:grandeur_app/screens/booking.dart';
import 'package:grandeur_app/screens/login.dart';
import 'package:grandeur_app/screens/profile.dart';
import 'package:localstorage/localstorage.dart';

class Bookings extends StatelessWidget {
  final String title;
  static LocalStorage storage = LocalStorage('grandeur_app');

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
                        width: 80,
                        height: 80,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            imageUrl:
                                'https://img.freepik.com/free-vector/woman-avatar-spa_24877-5702.jpg?size=626&ext=jpg',
                            fit: BoxFit.fill,
                          ),
                        )),
                    const Text('App Settings')
                  ])),
          ListTile(
            title: const Text('My Profile'),
            onTap: () => Navigator.pushNamed(context, Profile.routeName),
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
      future: Future<User>(() {
        final user = storage.getItem('user');
        return user;
      }),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = ['Booking A', 'Booking B', 'Booking C', 'Booking D'];
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return ListTile(
                title: Text(item),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
