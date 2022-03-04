import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grandeur_app/screens/booking.dart';
import 'package:grandeur_app/screens/bookings.dart';
import 'package:grandeur_app/screens/login.dart';
import 'package:grandeur_app/screens/profile.dart';
import 'package:grandeur_app/screens/register.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Grandeur Beauty and Spa',
        onGenerateRoute: (settings) {
          if (settings.name == Register.routeName) {
            return MaterialPageRoute(builder: (context) {
              return const Register(title: 'Grandeur: Signup');
            });
          }
          if (settings.name == Login.routeName) {
            return MaterialPageRoute(builder: (context) {
              return const Login(title: 'Grandeur: Signin');
            });
          }
          if (settings.name == Profile.routeName) {
            return MaterialPageRoute(builder: (context) {
              return const Profile(title: 'My Profile');
            });
          }
          if (settings.name == Bookings.routeName) {
            return MaterialPageRoute(builder: (context) {
              return const Bookings(title: 'My Bookings');
            });
          }
          if (settings.name == Booking.routeName) {
            return MaterialPageRoute(builder: (context) {
              return const Booking(
                  title: 'Grandeur: Beauty and Spa session reservation');
            });
          }

          return MaterialPageRoute(builder: (context) {
            return const Login(title: 'Grandeur: Signin');
          });
        },
        onUnknownRoute: (settings) => MaterialPageRoute(builder: (context) {
              return const Login(title: 'Grandeur: Signin');
            }),
        theme: ThemeData(primarySwatch: Colors.green),
        home: const Login(title: 'Grandeur: Signin'));
  }
}
