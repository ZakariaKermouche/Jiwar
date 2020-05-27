import 'package:dir_khir/screens/navigation.dart';
import 'package:dir_khir/screens/registeration.dart';
import 'package:dir_khir/utils/component.dart';
import 'package:dir_khir/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  static String id = 'login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Dir Khir',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      'Sign in to continue!',
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
                          text: 'LOGIN',
                          color: primaryColor,
                          textColor: Colors.white,
                          tap: () async {
                            try{
                              final login = await _auth.signInWithEmailAndPassword(email: mail, password: password);
                              if (login != null){
                                Navigator.pushNamed(context, NavigationPage.id);
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
                children: <Widget>[Text('I\'m a new user.' ,style: TextStyle(fontWeight: FontWeight.bold ),),GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, RegistrationPage.id);
                  },
                  child: Text(' Register' ,style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold ),),
                ),],
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
