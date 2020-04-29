import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashlabs/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  bool _obscureTextLogin = true;
  String _email,_password;

 void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
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
                    try
                    {
                     var check_user=await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
                     FirebaseUser getuser = await FirebaseAuth.instance.currentUser();
                     Navigator.push(context, MaterialPageRoute(
                         builder: (context){

                             return Dashboard();


                         }
                     )
                     );
                    }catch(e)
                    {
                      print(e);
                    }

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
    );
  }
}


//TODO: ADD FIREBASE AUTH FOR LOGIN FOR BACKEND
//TODO: ADD ERROR DIALOG IF LOGIN FAILS