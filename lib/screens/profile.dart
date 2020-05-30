import 'package:flutter/material.dart';
import 'package:dir_khir/utils/component.dart';

class Profile extends StatefulWidget {
  static String id = 'profile';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<bool> isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xff7D2AE6)),
            onPressed: () => {Navigator.pop(context)},
          ),
          title: SizedBox(height: 50.0, child: Image.asset("images/logo.PNG")),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings, color: Color(0xff7D2AE6)),
              onPressed: () => {
                //Information of the discussion
              },
            )
          ],
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Color(0xff7D2AE6),
              ),
            ),
            Center(
              child: Text(
                "Zakaria Kermouche",
                style: TextStyle(
                  color: Color(0xff7D2AE6),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Center(
                child: ToggleButtons(
                  borderRadius: BorderRadius.circular(20),
                  borderWidth: 2,
                  color: Color(0xff7D2AE6),
                  borderColor: Color(0xff7D2AE6),
                  fillColor: Color(0xffFE8A51),
                  selectedColor: Colors.white,
                  selectedBorderColor: Color(0xff7D2AE6),
                  children: <Widget>[
                    Text(
                      " Organisation ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " Participation ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "  Reviews  ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                  isSelected: isSelected,
                  onPressed: (int index) {
                    setState(() {
                      if (index == 0) {
                        isSelected[0] = true;
                        isSelected[1] = false;
                        isSelected[2] = false;
                      } else {
                        if (index == 1) {
                          isSelected[0] = false;
                          isSelected[1] = true;
                          isSelected[2] = false;
                        } else {
                          isSelected[0] = false;
                          isSelected[1] = false;
                          isSelected[2] = true;
                        }
                      }
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
