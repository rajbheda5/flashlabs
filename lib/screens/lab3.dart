import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flashlabs/classes/lab3equipment.dart';
import 'package:flushbar/flushbar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Lab3 extends StatefulWidget{
  @override
  _LabThree createState()=> _LabThree();
}

class _LabThree extends State<Lab3>{
  String _remark = 'null';
  bool isLoading = true;
  bool isClicked1 = false;
  bool isClicked2 = false;
  bool isClicked3 = false;
  bool isClicked4 = false;
  final Color black = Color.fromRGBO(24, 26, 30, 1);
  final Color orange = Color.fromRGBO(242, 62, 16, 1);
  Color button1Color = Color.fromRGBO(24, 26, 30, 1);
  Color button2Color = Color.fromRGBO(24, 26, 30, 1);
  Color button3Color = Color.fromRGBO(24, 26, 30, 1);
  Color button4Color = Color.fromRGBO(24, 26, 30, 1);

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
                  Navigator.of(context).pop(customController.text.toString());
                  FirebaseUser user = await FirebaseAuth.instance.currentUser();
                  Firestore.instance.collection('Lab3Remarks').add({
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

  void updateData(String item,bool isClicked)async{
  if(!isClicked){ 
    await Firestore.instance.collection('Lab3').document('$item').updateData({
    'user':'Free for Use',
    'isUtilised': isClicked,
  }).catchError((e){print(e);});}
  if(isClicked){
    FirebaseUser user =await FirebaseAuth.instance.currentUser();

    await Firestore.instance.collection('Lab3').document('$item').updateData({
      'user':'${user.email}',
      'isUtilised': isClicked,
    }).catchError((e){print(e);});
  }
}
  void getdata()async{
  try{
    var pc1data = await Firestore.instance.collection('Lab3').document('PC1').get();
    setState(() {
      isClicked1=pc1data.data['isUtilised'];
      button1Color = isClicked1 ? orange : black;
    });
    var pc2data = await Firestore.instance.collection('Lab3').document('PC2').get();
    setState(() {
      isClicked2=pc2data.data['isUtilised'];
      button2Color = isClicked2 ? orange : black;
    });
    var pc3data = await Firestore.instance.collection('Lab3').document('PC3').get();
    setState(() {
      isClicked3=pc3data.data['isUtilised'];
      button3Color = isClicked3 ? orange : black;
    });
    var pc4data = await Firestore.instance.collection('Lab3').document('PC4').get();
    setState(() {
      isClicked4=pc4data.data['isUtilised'];
      button4Color = isClicked4 ? orange : black;
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                          setState(() {
                            isClicked1 = !isClicked1;
                            button1Color = isClicked1 ? orange : black;
                            updateData('PC1', isClicked1);
                          });
                        },
                        child: Lab3Equipment(eq3name: 'PC\n 1',colour: button1Color),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        InkWell(
                          onTap: () {
                          setState(() {
                            isClicked2 = !isClicked2;
                            button2Color = isClicked2 ? orange : black;
                            updateData('PC2', isClicked2);
                          });
                        },
                        child: Lab3Equipment(eq3name: 'PC\n 2',colour: button2Color),
                        ),
                      ],
                    ), 
                    SizedBox(height: 25),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                          setState(() {
                            isClicked3 = !isClicked3;
                            button3Color = isClicked3 ? orange : black;
                            updateData('PC3', isClicked3);
                          });
                        },
                        child: Lab3Equipment(eq3name: 'PC\n 3',colour: button3Color),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        InkWell(
                          onTap: () {
                          setState(() {
                            isClicked4 = !isClicked4;
                            button4Color = isClicked4 ? orange : black;
                            updateData('PC4', isClicked4);
                          });
                        },
                        child: Lab3Equipment(eq3name: 'PC\n 4',colour: button4Color),
                        ),
                      ],
                    ), 
                    SizedBox(height: 70),
                      InkWell(
                        onTap: () {
                          createAlertDialog(context).then((onValue)async{
                            FirebaseUser user =await FirebaseAuth.instance.currentUser();
                            await Firestore.instance.collection('Lab3Remarks').document('${user.email}').updateData({
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
              )
            )
          ],
        ),
      ),
    );
  }
}