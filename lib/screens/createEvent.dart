
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  var eventId;
  
  @override
  Widget build(BuildContext context) {
    final maxLines = 5;

    Future<void> _addPathToDatabase(String text) async {
      try {
        // Get image URL from firebase
        final ref = FirebaseStorage().ref().child(text);
        var imageString = await ref.getDownloadURL();

        // Add location and url to database
        await Firestore.instance.collection('storage').document().setData({'eventId': eventId,'url':imageString , 'location':text});
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
            ),
          ),
          Container(
            child: RaisedButton(
              onPressed:(){
                _selectDate(context);
              },
              padding: const EdgeInsets.all(0.0),
              textColor: Colors.white,
              color: Colors.indigoAccent,
              
              child:Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 85),
                  child:Text(
                    "Select The Date Of The Event",
                    style: TextStyle(
                    ),
                  )
              ),
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
              ),
            ),
          ),
          Container(
            child: RaisedButton(
              onPressed: (){
                getImage();
              },
              //padding: const EdgeInsets.all(0.0),
              textColor: Colors.white,
              color: Colors.indigoAccent,
              child:Container(

                  //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 85),
                  child:Text(
                    "Select from Phone",
                    style: TextStyle(
                    ),
                  )
              ),
            ),
          ),
          Container(
            child: RaisedButton(
              onPressed: (){
                _uploadImageToFirebase(_image);
              },
              //padding: const EdgeInsets.all(0.0),
              textColor: Colors.white,
              padding: EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
              child:Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFFFC6473),
                          Color(0xFFFD7F5B),
                          Color(0xFFFF9A44),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(80.0))
                  ),
                  padding: EdgeInsets.fromLTRB(20,10,20, 10),
                  child:Text(
                    "Submit",
                    style: TextStyle(
                    ),
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }


}
