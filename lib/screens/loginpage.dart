//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashlabs/screens/dashboard.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dashboard.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  bool _obscureTextLogin = true;
  bool isLoading = false;
  String _email,_password;

 void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 26, 30, 1),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        //opacity: 0,
        progressIndicator: SpinKitWave(
            color: Color.fromRGBO(242, 62, 16, 1),
          size: 50,
          ),
        child: Stack(
          children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color.fromRGBO(24, 26, 30, 1),
            )
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 58),
                  Container(
                    width: double.infinity,
                    child: Image.asset('assets/logo.png', height: 158, width: 158),
                  ),
                  SizedBox(height: 45),
                  ClayContainer(
                    // spread: 2,
                    // depth: 40,
                    curveType: CurveType.convex,
                    height: 300.0,
                    width: 300.0,
                    color: Color.fromRGBO(24, 26, 30, 1),
                    borderRadius: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            top: 24,
                            left: 24
                          ),
                          child: Text(
                              'Welcome!',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ),
                        SizedBox(height: 26),
                        Container(
                          margin: EdgeInsets.only(
                            left: 24,
                          ),
                          child: Text(
                              'Please enter your email',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(
                            left: 24,
                          ),
                          child: ClayContainer(
                            height: 50,
                            width: 250,
                            color: Color.fromRGBO(24, 26, 30, 1),
                            borderRadius: 30.0,
                            spread: 1,
                            depth: 100,
                            child: TextField(
                              onChanged: (value){
                                _email=value;
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 14.0),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                )
                              ),
                            )
                          )
                        ),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.only(
                            left: 24,
                          ),
                          child: Text(
                              'Please enter your password',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.only(
                            left: 24,
                          ),
                          child: ClayContainer(
                            height: 50,
                            width: 250,
                            color: Color.fromRGBO(24, 26, 30, 1),
                            borderRadius: 30.0,
                            spread: 1,
                            depth: 100,
                            child: TextField(
                              onChanged: (value){
                                _password=value;
                              },
                              textAlignVertical: TextAlignVertical.center,
                             obscureText: _obscureTextLogin,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 14.0),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                suffixIcon: GestureDetector(
                                onTap: _toggleLogin,
                                child: Icon(
                                  _obscureTextLogin
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 15.0,
                                  color: Colors.grey,
                                ),
                              ),
                              ),
                            )
                          )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 100),
                  InkWell(
                      onTap: ()async{
                        setState(() {
                          isLoading= true;
                        });
                        try
                        {
                         var checkuser=await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
                         FirebaseUser getuser = await FirebaseAuth.instance.currentUser();
                         Navigator.push(context, MaterialPageRoute(
                             builder: (context){
                                   return Dashboard();
                                 }
                         )
                         );
                        }
                        catch(e)
                        {
                          Flushbar(
                        message: 'Login Failed',
                        duration: Duration(seconds: 2),
                        margin: EdgeInsets.all(8),
                        borderRadius: 8,
                        backgroundColor: Color.fromRGBO(24, 26, 30, 1),
                        icon: Icon(Icons.error_outline),
                        flushbarPosition: FlushbarPosition.TOP,
                      )..show(context);
                        }
                        setState(() {
                          isLoading=false;
                        });
                        },
                      child: ClayContainer(
                        height:50,
                        width: 150,
                        spread: 2,
                        depth: 50,
                        color: Color.fromRGBO(224, 62, 16, 1),
                        borderRadius: 30,
                        child: Center(
                          child: Text('Login',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                         )
                       ),
                      ),
                    ),
                  SizedBox(height: 100),
                ],
              )
            ),
          ),
         ]
        ),
      ),
    );
  }
}


//TODO: ADD FIREBASE AUTH FOR LOGIN FOR BACKEND
//TODO: ADD ERROR DIALOG IF LOGIN FAILS