import 'package:dir_khir/screens/discussion.dart';
import 'package:dir_khir/screens/navigation.dart';
import 'package:dir_khir/screens/login.dart';
import 'package:dir_khir/screens/onboard.dart';
import 'package:dir_khir/screens/registeration.dart';
import 'package:dir_khir/screens/map.dart';
import 'package:dir_khir/screens/rooms.dart';
import 'package:flutter/material.dart';

import 'screens/createEvent.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jiwar',
      theme: ThemeData(
        primaryColor: Color(0xff7D2AE6),
        accentColor: Color(0xffFE8A51),
      ),
      initialRoute: Onboard.id,
      routes: {
        Onboard.id: (context) => Onboard(),
        LoginPage.id: (context) => LoginPage(),
        RegistrationPage.id: (context) => RegistrationPage(),
        MapPage.id: (context) => MapPage(),
        NavigationPage.id: (context) => NavigationPage(),
        RoomsPage.id: (context) => RoomsPage(),
        DiscussionPage.id: (context) => DiscussionPage(),
        AddEvent.id: (context) => AddEvent(),
      },
    );
  }
}
