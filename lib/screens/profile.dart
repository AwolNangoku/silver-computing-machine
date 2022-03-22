import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:grandeur_app/models/user.dart';
import 'package:grandeur_app/screens/booking.dart';
import 'package:grandeur_app/screens/bookings.dart';
import 'package:grandeur_app/screens/login.dart';
import 'package:grandeur_app/utils/server_get.dart';
import 'package:grandeur_app/utils/server_put.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: buildFutureBuilder(),
          )),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: Colors.green),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: const NetworkImage(
                          'https://img.freepik.com/free-vector/woman-avatar-spa_24877-5702.jpg?size=626&ext=jpg'),
                      radius: 45,
                      onBackgroundImageError: (e, s) {
                        debugPrint('image issue, $e,$s');
                      },
                    ),
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
      future: Future<User>(() async {
        var updatedUser = await serverGet(
            'http://10.0.2.2:3000/account/user/${storage.getItem('user').id}');

        return User.fromJson(updatedUser);
      }),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String? profileImage = snapshot.data!.profileUrl;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                alignment: const Alignment(1, 1),
                children: <Widget>[
                  ClipOval(
                    child: SizedBox(
                        width: 90,
                        height: 90,
                        child: FadeInImage.assetNetwork(
                          placeholder: '....',
                          image: profileImage.toString(),
                        )),
                  ),
                  TextButton(
                      child: const Icon(Icons.photo_camera),
                      onPressed: () async {
                        try {
                          final XFile? pickedFile = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);

                          final profileImage =
                              await http.MultipartFile.fromPath(
                                  'uploaded_file', pickedFile!.path);

                          await serverPut(
                              'http://10.0.2.2:3000/bucket/upload-profile/${snapshot.data!.id}',
                              profileImage);
                        } catch (e) {}
                        // var res = await uploadImage(file.path, widget.url);
                      })
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('First Name:'),
                    Text(snapshot.data!.firstname)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Last Name:'),
                    Text(snapshot.data!.lastname)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Email Address:'),
                    Text(snapshot.data!.emailAddress)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Mobile Number:'),
                    Text(snapshot.data!.mobileNumber)
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text('Bio Details:'),
                    Text(snapshot.data!.bio),
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
