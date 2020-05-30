import 'package:dir_khir/screens/map.dart';
import 'package:dir_khir/screens/notification.dart';
import 'package:dir_khir/screens/profile.dart';
import 'package:dir_khir/screens/rooms.dart';
import 'package:flutter/material.dart';

import 'event_page.dart';

class NavigationPage extends StatefulWidget {
  static String id = 'NavigationPage';
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1.0,
          leading: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: Icon(Icons.settings, color: Color(0xff7D2AE6)),
              onPressed: () => {},
            ),
          ),
          title: SizedBox(height: 50.0, child: Image.asset("images/logo.PNG")),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: CircleAvatar(
                maxRadius: 20,
                child: IconButton(
                  icon: Icon(Icons.account_circle, color: Colors.white),
                  onPressed: () => {Navigator.pushNamed(context, Profile.id)},
                ),
                backgroundColor: Color(0xff7D2AE6),
              ),
            ),
          ],
        ),
        body: IndexedStack(
          index: _index,
          children: <Widget>[
            MapPage(),
            NotificationPage(),
            EventPage(),
            RoomsPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 5.0,
          backgroundColor: Color(0xff7D2AE6),
          selectedIconTheme: IconThemeData(color: Color(0xffFE8A51)),
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          currentIndex: _index,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.map,
                  color: Colors.white,
                ),
                title: Text("Map", style: TextStyle(color: Colors.white))),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications, color: Colors.white),
                title: Text("Notifs", style: TextStyle(color: Colors.white))),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today, color: Colors.white),
                title: Text("Events", style: TextStyle(color: Colors.white))),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat, color: Colors.white),
                title: Text("Rooms", style: TextStyle(color: Colors.white))),
          ],
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
        ),
      ),
    );
  }
}
