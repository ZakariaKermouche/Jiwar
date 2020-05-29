
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dir_khir/utils/component.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dir_khir/screens/map.dart';
import 'package:dir_khir/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' as i; //"i" also can be another char or word, is just an example



class AddEvent extends StatefulWidget {
  static String id = 'AddEvent';
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {

  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();
  String _eventTitle;
  String _address;
  String _description;
  bool _coorganizer;

  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  @override
  void initState(){
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async{
    try{
      final user = await _auth.currentUser();
      if(user != null){
        loggedInUser = user;
      }
    }catch(e){
      print(e);
    }
  }
  
  Future _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2030),
    );
    if (picked != null && picked != _date){
      print('Date selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }

  PickedFile _image;
  final picker = ImagePicker();
  var url;
  var _eventId;
  
  @override
  Widget build(BuildContext context) {
    final maxLines = 5;

    Future<void> _addPathToDatabase(String text) async {
      try {
        // Get image URL from firebase
        final ref = FirebaseStorage().ref().child(text);
        var imageString = await ref.getDownloadURL();
        setState(() {
          _eventId = loggedInUser.email + _date.toIso8601String() + _time.toString();
        });
        // Add location and url to database
        await Firestore.instance.collection('storage').document().setData({'eventId': _eventId,'url':imageString , 'location':text});
      }catch(e){
        print(e.message);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(e.message),
              );
            }
        );
      }
    }

    Future<void> _uploadImageToFirebase(PickedFile image) async {
      try{
        int randomNumber = Random().nextInt(100000);
        String imageLocation = 'images/image$randomNumber.jpg';

        final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(imageLocation);
        final StorageUploadTask uploadTask = firebaseStorageRef.putFile(i.File(image.path));
        await uploadTask.onComplete;
        _addPathToDatabase(imageLocation);
      }catch(e){
        print(e.message);
      }
    }

    Future getImage() async{
      // Get image from gallery
      var image = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
    }




    return Scaffold(
      appBar: new AppBar(
        title: Text('Add Event'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
//        itemExtent: 106.0,
        children: <Widget>[
          SizedBox(height: 30,),
          Theme(
            data: new ThemeData(
              primaryColor: Colors.indigoAccent,
              primaryColorDark: Colors.indigo,
            ),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Event Title',
                labelText: 'Event Title',
              ),
              onChanged: (value){
                _eventTitle = value;
              },
            ),
          ),
          SizedBox(height: 20,),
          Text(
            'Event Address',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              color: Colors.indigoAccent,
            ),
          ),
          Text(
            'Please locate the event address in the map',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(8),
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(80)),
            ),
            child: MyMap(),
          ),
          SizedBox(height: 20,),
          Text(
            'Or just write the address here',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 7,),
          Theme(
            data: new ThemeData(
              primaryColor: Colors.indigoAccent,
              primaryColorDark: Colors.indigo,
            ),
            child: TextField(
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              decoration: kTextFieldDecoration,
              onChanged: (value) {
                _address = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: MyButton(
              text: "Select Date",
              textColor: Colors.white,
              color: Colors.indigoAccent,
              tap: (){
                _selectDate(context);
              },
            ),
          ),
          Container(
            height: maxLines * 24.0,
            child: Theme(
              data: new ThemeData(
                primaryColor: Colors.indigoAccent,
                primaryColorDark: Colors.indigo,
              ),

              child: TextField(
                maxLines: maxLines,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Description',
                  labelText: 'Add a description to the event'
                ),
                onChanged: (value) {
                  _description = value;
                },
              ),
            ),
          ),
          SizedBox(height: 20,),
          Text(
            'if you have a photo of the event, please choose it from your gallery',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: MyButton(
              text: "Select from Phone",
              textColor: Colors.white,
              color: Colors.indigoAccent,
              tap: (){
                getImage();
                },
            ),
          ),
          SizedBox(height: 20,),
          Text(
            'Do you have a co-organaizer ?',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 7,),
          Container(
            padding: EdgeInsets.all(8),
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: MyButton(
                    text: 'yes',
                    color: Colors.indigoAccent,
                    textColor: Colors.white,
                    tap: (){
                      _coorganizer = true;
                    },
                  ),
                ),
              SizedBox(
                width: 12,
              ),
                Expanded(
                  child: MyButton(
                    text: 'no',
                    color: Colors.indigoAccent,
                    textColor: Colors.white,
                    tap: (){
                      _coorganizer = false;
                    },
                  ),
                ),
              ],
              ),
      ),
          SizedBox(height: 7,),
          Container(
            padding: EdgeInsets.all(8),
            child: MyButton(
              text: 'Submit',
              textColor: Colors.white,
              color: Color(0xFFFD7F5B),
              tap: (){
                _firestore.collection('events').add(
                  {
                    //'date': _date,
                    'coorganizer': _coorganizer,
                    'description': _description,
                    'address': _address,
                    'eventId': _eventId,
                    'eventTitle': _eventTitle,
                    'organizer': loggedInUser.email,
                  }
                );
                _uploadImageToFirebase(_image);
              },
            ),
          ),
      ]
    ),
    );
  }


}
