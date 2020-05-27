import 'package:dir_khir/screens/login.dart';
import 'package:dir_khir/utils/component.dart';
import 'package:dir_khir/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationPage extends StatefulWidget {
  static String id = 'registration';
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  
  final _auth = FirebaseAuth.instance;

  String mail;
  String password;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Jiwar',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      'Create an account ',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade400),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only( top: 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      
                      children: <Widget>[
                        /*TextField(
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          onChanged: (value){
                            name = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'Full Name',
                            hintText: 'Enter your full name',
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),*/
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value){
                            mail = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'E-mail',
                            hintText: 'Enter your E-mail',
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextField(
                          textAlign: TextAlign.center,
                          obscureText: true,
                          onChanged: (value){
                            password = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'Password',
                            hintText: 'Enter your Password',
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        MyButton(
                          text: 'REGISTER',
                          color: Colors.green,
                          textColor: Colors.white,
                          tap: () async {
                            try{
                              final newUser = await _auth.createUserWithEmailAndPassword(email: mail, password: password);
                              if(newUser != null){
                                Navigator.pushNamed(context, LoginPage.id);
                              }
                            }catch(e){
                              print(e);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 8.3) ,child: Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Text('I\'m already a member.' ,style: TextStyle(fontWeight: FontWeight.bold ),),GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text(' Login.' ,style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold ),),
                ),],
              ),),
            ],
          ),
        ),
      ),
    );
  }
}