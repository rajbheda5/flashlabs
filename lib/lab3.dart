import 'package:flutter/material.dart';

class Lab3 extends StatefulWidget{
  @override
  _LabThree createState()=> _LabThree();
}

class _LabThree extends State<Lab3>{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text('Lab 3', 
          style:TextStyle(
            color: Colors.black,
          ),
          ),
      ),
    );
  }
}