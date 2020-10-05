import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:irespondph/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:irespondph/screens/blank_screen.dart';
import 'package:irespondph/screens/login_screens.dart';
import 'package:irespondph/screens/registerd.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;
  String signup;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  height: 200.0,
                  child: Image.asset('images/Irespond.png'),
                ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'First Name',
                style: TextStyle(color: Colors.black,fontSize: 18.0,),
              ),
              TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    signup = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your First Name')
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Last Name',
                style: TextStyle(color: Colors.black,fontSize: 18.0,),
              ),
              TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    signup = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Last Name')
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Address',
                style: TextStyle(color: Colors.black,fontSize: 18.0,),
              ),
              TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    signup = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Address')
              ),

            Column(
                  children: <Widget>[
              new TextField(
                textAlign: TextAlign.center,
              decoration: new InputDecoration(hintText: "Enter your number"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
                onChanged: (value) {
                  signup = value;
                },
              ),
                    // Only numbers can be entered
              SizedBox(
                height: 8.0,
              ),

              Text(
                'Email',
                textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black,fontSize: 18.0,),
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email= value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Email')
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Password',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black,fontSize: 18.0,),
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Password')
              ),
              SizedBox(
                height: 24.0,
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Color(0xFFFF9800),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: ()  async{
                      _firestore.collection('sign up').add({
                        'First Name': signup,
                        'Last Name': signup,
                        'Address': signup,
                        'Contact Number':signup,

                      });
                      setState(() {
                        showSpinner= true;
                      });
                      try {
                        final newUser = await _auth
                            .createUserWithEmailAndPassword(
                            email: email, password: password);
                        if (newUser != null) {
                          Navigator.pushNamed(context, registered.id);
                        }
                        setState(() {
                          showSpinner=false;
                        });
                      }
                      catch(e){
                        print(e);
                      }

                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, LoginScreen.id );
                },
                child: Center(
                  child: RichText(
                    text: TextSpan(
                        text: 'Already have an Account?',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Log In',
                            style: TextStyle(
                                color: Colors.teal, fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                ),
              )
            ],
          ),

          ]
        ),
      ),
      ),
    );

  }


}
