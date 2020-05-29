import 'package:dir_khir/screens/createEvent.dart';
import 'package:dir_khir/screens/navigation.dart';
import 'package:dir_khir/screens/login.dart';
import 'package:dir_khir/screens/onboard.dart';
import 'package:dir_khir/screens/registeration.dart';
import 'package:dir_khir/screens/map.dart';
import 'package:dir_khir/screens/rooms.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jiwar',
      initialRoute: Onboard.id,
      routes: {
        Onboard.id: (context) => Onboard(),
        LoginPage.id: (context) => LoginPage(),
        RegistrationPage.id: (context) => RegistrationPage(),
        MapPage.id: (context) => MapPage(),
        NavigationPage.id: (context) => NavigationPage(),
        RoomsPage.id: (context) => RoomsPage(),
        AddEvent.id: (context) => AddEvent(),
      },
    );
  }
}
