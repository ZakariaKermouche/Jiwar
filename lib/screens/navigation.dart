import 'package:dir_khir/screens/map.dart';
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
          leading: new Icon(
            Icons.settings,
            color: Colors.black,
          ),
          title: SizedBox(height: 35.0, child: Image.asset("images/test.png")),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: CircleAvatar(
                maxRadius: 20,
                child: Icon(Icons.account_circle),
                //apres tji photo orofil t3 user -- khir  m icon lidertha abdenour
                backgroundColor: Colors.black,
              ),
            )
          ],
        ),
        body: IndexedStack(
          index: _index,
          children: <Widget>[
            MapPage(),
            Scaffold(),
            EventPage(),
            RoomsPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 5.0,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          currentIndex: _index,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.map), title: Text("Map")),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), title: Text("Notifications")),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), title: Text("Event")),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat), title: Text("Chat")),
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
