import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flashlabs/classes/lab1equipment.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Lab1 extends StatefulWidget {
  @override
  _LabOne createState() => _LabOne();
}

class _LabOne extends State<Lab1> {
  int _utilisationTime;
  int _minutes;
  Timestamp start;
  Timestamp end;
  String _remark = 'null';
  bool isLoading = true;
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

  void updateData(String item,bool isClicked)async{
  if(!isClicked){ 
    await Firestore.instance.collection('Lab1').document('$item').updateData({
    'user':'Free for Use',
    'isUtilised': isClicked,
    'endUtilisation': DateTime.now(),
  }).catchError((e){print(e);});
   var timedef = await Firestore.instance.collection('Lab1').document('$item').get();
    start = timedef.data['startUtilisation'];
    print(start);
    DateTime startd = start.toDate();
    end = timedef.data['endUtilisation'];
    DateTime endd = end.toDate();
    print(end);
    _minutes = timedef.data['minutes'];
    _utilisationTime = endd.difference(startd).inMinutes;
    print(_utilisationTime);
    _minutes += _utilisationTime;
    
    await Firestore.instance.collection('Lab1').document('$item').updateData({
    'minutes': _minutes,
  }).catchError((e){print(e);});
  }
if(isClicked){
  FirebaseUser user =await FirebaseAuth.instance.currentUser();

  await Firestore.instance.collection('Lab1').document('$item').updateData({
    'user':'${user.email}',
    'isUtilised': isClicked,
    'startUtilisation': DateTime.now(),
  }).catchError((e){print(e);});
}
}

void getdata()async{
  try{
    var cro1data = await Firestore.instance.collection('Lab1').document('CRO1').get();
    setState(() {
      isClicked1=cro1data.data['isUtilised'];
      button1Color = isClicked1 ? orange : black;
    });
    var cro2data = await Firestore.instance.collection('Lab1').document('CRO2').get();
    setState(() {
      isClicked2=cro2data.data['isUtilised'];
      button2Color = isClicked2 ? orange : black;
    });
    var dmm1data = await Firestore.instance.collection('Lab1').document('DMM1').get();
    setState(() {
      isClicked3=dmm1data.data['isUtilised'];
      button3Color = isClicked3 ? orange : black;
    });
    var dmm2data = await Firestore.instance.collection('Lab1').document('DMM2').get();
    setState(() {
      isClicked4=dmm2data.data['isUtilised'];
      button4Color = isClicked4 ? orange : black;
    });
    var tkdata = await Firestore.instance.collection('Lab1').document('TrainerKit').get();
    setState(() {
      isClicked5=tkdata.data['isUtilised'];
      button5Color = isClicked5 ? orange : black;
    });
    setState(() {
      isLoading = false;
    });
  }
  catch(e){
    print(e);
    Flushbar(
        message: 'Please check your connection!',
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(8),
        borderRadius: 8,
        backgroundColor: Color.fromRGBO(242, 62, 16, 1),
        icon: Icon(Icons.error_outline),
        flushbarPosition: FlushbarPosition.TOP,
            )..show(context);
  }

}

@override
  void initState(){
    try{

      getdata();

    }catch(e)
    {
      print(e);
}
  super.initState();

  }
  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();
    

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Remarks'),
            content: TextField(
              onChanged: (value){
                _remark = value;
              },
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Submit'),
                onPressed: ()async {                
                  Navigator.of(context).pop(customController.text.toString());
                  FirebaseUser user = await FirebaseAuth.instance.currentUser();
                  Firestore.instance.collection('Lab1Remarks').add({
                    'remark' : _remark,
                    'user' :'${user.email}',
                  });
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
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        opacity: 1,
        color: Color.fromRGBO(24, 26, 30, 1),
        progressIndicator: SpinKitWave(
            color: Color.fromRGBO(242, 62, 16, 1),
            size: 50,
          ),
        child: Stack(
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
                            updateData('CRO1',isClicked1);
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
                            updateData('CRO2',isClicked2);
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
                            updateData('DMM1',isClicked3);
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
                            updateData('DMM2',isClicked4);
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
                            updateData('TrainerKit',isClicked5);
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
      ),
    );
  }
}

