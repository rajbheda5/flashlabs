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
        backgroundColor: Color.fromRGBO(24, 26, 30, 1),
        leading: BackButton(),
        title: Text('Lab 3', 
          style:TextStyle(
            color: Colors.white,
          ),
          ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color.fromRGBO(24, 26, 30, 1),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}