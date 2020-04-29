import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flashlabs/classes/lab1equipment.dart';

class Lab1 extends StatefulWidget {
  @override
  _LabOne createState() => _LabOne();
}

class _LabOne extends State<Lab1> {
  bool isClicked1 = false;
  bool isClicked2 = false;
  bool isClicked3 = false;
  bool isClicked4 = false;
  bool isClicked5 = false;
  final Color black = Color.fromRGBO(24, 26, 30, 1);
  final Color orange = Color.fromRGBO(242, 62, 16, 1);
  Color button1Color = Color.fromRGBO(24, 26, 30, 1);
  Color button2Color = Color.fromRGBO(24, 26, 30, 1);
  Color button3Color = Color.fromRGBO(24, 26, 30, 1);
  Color button4Color = Color.fromRGBO(24, 26, 30, 1);
  Color button5Color = Color.fromRGBO(24, 26, 30, 1);

  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Remarks'),
            content: TextField(
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Submit'),
                onPressed: () {
                  Navigator.of(context).pop(customController.text.toString());
                  Flushbar(
                    message: 'Submitted Successfully!',
                    duration: Duration(seconds: 1),
                    margin: EdgeInsets.all(8),
                    borderRadius: 8,
                    backgroundColor: Color.fromRGBO(24, 26, 30, 1),
                    icon: Icon(Icons.check),
                  )..show(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(24, 26, 30, 1),
        leading: BackButton(),
        title: Text(
          'Lab 1',
          style: TextStyle(
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
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                    ),
                    InkWell(
                      onTap: () {
                        setState((){
                          isClicked1 = !isClicked1;
                          button1Color = isClicked1 ? orange : black;
                          UpdateData('CRO1',isClicked1);
                        });
                      },
                      child:
                          Lab1Equipment(eq1name: 'CRO 1', colour: button1Color),
                    ),
                    SizedBox(height: 25),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isClicked2 = !isClicked2;
                          button2Color = isClicked2 ? orange : black;
                          UpdateData('CRO2',isClicked2);
                        });
                      },
                      child:
                          Lab1Equipment(eq1name: 'CRO 2', colour: button2Color),
                    ),
                    SizedBox(height: 25),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isClicked3 = !isClicked3;
                          button3Color = isClicked3 ? orange : black;
                          UpdateData('DMM1',isClicked3);
                        });
                      },
                      child:
                          Lab1Equipment(eq1name: 'DMM 1', colour: button3Color),
                    ),
                    SizedBox(height: 25),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isClicked4 = !isClicked4;
                          button4Color = isClicked4 ? orange : black;
                          UpdateData('DMM2',isClicked4);
                        });
                      },
                      child:
                          Lab1Equipment(eq1name: 'DMM 2', colour: button4Color),
                    ),
                    SizedBox(height: 25),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isClicked5 = !isClicked5;
                          button5Color = isClicked5 ? orange : black;
                          UpdateData('TrainerKit',isClicked5);
                        });
                      },
                      child: Lab1Equipment(
                          eq1name: 'Trainer Kit', colour: button5Color),
                    ),
                    SizedBox(height: 70),
                    InkWell(
                      onTap: () {
                        createAlertDialog(context).then((onValue)async{
                          FirebaseUser user =await FirebaseAuth.instance.currentUser();
                          await Firestore.instance.collection('Lab1Remarks').document('${user.email}').updateData({
                            'user':'${user.email}',
                            'remark':onValue,
                          }).catchError((e){print(e);});
                        });
                      },
                      child: ClayContainer(
                        height: 80,
                        width: 200,
                        borderRadius: 18,
                        color: Color.fromRGBO(242, 62, 16, 1),
                        spread: 3,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.feedback,
                                color: Colors.white,
                                size: 35,
                              ),
                              SizedBox(width: 15),
                              Text(
                                'Add Remarks',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 70),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

void UpdateData(String item,bool isclicked)async{
  if(!isclicked){ await Firestore.instance.collection('Lab1').document('$item').updateData({
    'user':'Free for Use',
  }).catchError((e){print(e);});}
if(isclicked){
  FirebaseUser user =await FirebaseAuth.instance.currentUser();

  await Firestore.instance.collection('Lab1').document('$item').updateData({
    'user':'${user.email}',
  }).catchError((e){print(e);});
}

  
}