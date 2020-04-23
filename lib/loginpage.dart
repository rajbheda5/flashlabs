import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromRGBO(51, 83, 241, 1),
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
                  spread: 15,
                  depth: 30,
                  curveType: CurveType.convex,
                  height: 300.0,
                  width: 300.0,
                  color: Color.fromRGBO(51, 82, 241, 1),
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
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
                              fontSize: 16,
                              color: Colors.white,
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
                          color: Color.fromRGBO(51, 82, 241, 1),
                          borderRadius: 30.0,
                          spread: 1,
                          depth: 45,
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 14.0),
                              hintText: 'Email',
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
                              fontSize: 16,
                              color: Colors.white,
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
                          color: Color.fromRGBO(51, 82, 241, 1),
                          borderRadius: 30.0,
                          spread: 1,
                          depth: 45,
                          child: TextField(
                           obscureText: true,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 14.0),
                              hintText: 'Password',
                            ),
                          )
                        )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100),
                ClayContainer(
                  height:50,
                  width: 150,
                  spread: 2,
                  depth: 50,
                  color: Color.fromRGBO(51, 82, 241, 1),
                  borderRadius: 30,
                  child: Center(
                    child: Text('Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    )
                    ),
                ),
                SizedBox(height: 100),
              ],
              )
          ),
        ),
      ]),
    );
  }
}