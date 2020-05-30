import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  static String id = 'notifications';
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                //backgroundImage: AssetImage(widget.photo),
                backgroundColor: Color(0xffFE8A51),
                child: Icon(Icons.group, color: Colors.white),
                maxRadius: 30,
              ),
              title: Text(""),
              subtitle: Text(
                  "Invitation to organize a group event as Co-Organizer. Collecting Donations for Cancer Patients on July, 8th."),
              //dense: true,
              // onTap: () => {},
            ),
            ListTile(
              leading: CircleAvatar(
                //backgroundImage: AssetImage(widget.photo),
                backgroundColor: Color(0xff7D2AE6),
                child: Icon(Icons.account_circle, color: Colors.white),
                maxRadius: 30,
              ),
              title: Text("AYMENE", style: TextStyle(color: Color(0xff7D2AE6))),
              subtitle: Text(
                  "Review on Awareness about Costumer's Rights event, held on June 19th."),
              //dense: true,
              // onTap: () => {},
            ),
            ListTile(
              leading: CircleAvatar(
                //backgroundImage: AssetImage(widget.photo),
                backgroundColor: Color(0xffFE8A51),
                child: Icon(Icons.group, color: Colors.white),
                maxRadius: 30,
              ),
              title: Text(""),
              subtitle: Text(
                  "Invitation to organize a group event as Co-Organizer. Collecting Donations for Cancer Patients on June, 5th."),
              //dense: true,
              // onTap: () => {},
            ),
            ListTile(
              leading: CircleAvatar(
                //backgroundImage: AssetImage(widget.photo),
                backgroundColor: Color(0xffFE8A51),
                child: Icon(Icons.group, color: Colors.white),
                maxRadius: 30,
              ),
              title: Text(""),
              subtitle: Text(
                  "Invitation to organize a group event as Co-Organizer. Collecting Donations for Cancer Patients on May, 24th."),
              //dense: true,
              // onTap: () => {},
            ),
            ListTile(
              leading: CircleAvatar(
                //backgroundImage: AssetImage(widget.photo),
                backgroundColor: Color(0xff7D2AE6),
                child: Icon(Icons.account_circle, color: Colors.white),
                maxRadius: 30,
              ),
              title:
                  Text("ZAKARIA", style: TextStyle(color: Color(0xff7D2AE6))),
              subtitle: Text(
                  "Review on Awareness about Plogging's event, held on May 15th."),
              //dense: true,
              // onTap: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
