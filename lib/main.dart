import 'package:flutter/material.dart';

import 'package:flashlabs/loginpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: Color.fromRGBO(242, 62, 16, 1),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}