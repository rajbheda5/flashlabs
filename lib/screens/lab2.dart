import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Lab2 extends StatefulWidget {
  @override
  _LabTwo createState() => _LabTwo();
}

class _LabTwo extends State<Lab2> {
  bool switchLoad = true;
  bool isOpen = false;
  Timestamp labOpen;
  Timestamp labClose;
  Timestamp start;
  Timestamp end;
  String _remark = 'null';
  bool isLoading = true;
  int _burrette = 0;
  int _flask = 0;
  int _testTube = 0;

  void _incrementBurrete() {
    setState(() {
      _burrette++;
      updateData('Burrette', true, _burrette);
    });
  }

  void _decrementBurrete() {
    setState(() {
      if (_burrette >= 1) {
        --_burrette;
        updateData('Burrette', true, _burrette);
      } else {
        _burrette = 0;
        updateData('Burrette', false, _burrette);
      }
    });
  }

  void _incrementflask() {
    setState(() {
      _flask++;
      updateData('Flask', true, _flask);
    });
  }

  void _decrementflask() {
    setState(() {
      if (_flask >= 1) {
        _flask--;
        updateData('Flask', true, _flask);
      } else {
        _flask = 0;
        updateData('Flask', false, _flask);
      }
    });
  }

  void _incrementTestTube() {
    setState(() {
      _testTube++;
      updateData('TestTubes', true, _testTube);
    });
  }

  void _decrementTestTube() {
    setState(() {
      if (_testTube >= 1) {
        _testTube--;
        updateData('TestTubes', true, _testTube);
      } else {
        _testTube = 0;
        updateData('TestTubes', false, _testTube);
      }
    });
  }

  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Remarks'),
            content: TextField(
              onChanged: (value) {
                _remark = value;
              },
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Submit'),
                onPressed: () async {
                  Navigator.of(context).pop(customController.text.toString());
                  FirebaseUser user = await FirebaseAuth.instance.currentUser();
                  Firestore.instance.collection('Lab2Remarks').add({
                    'remark': _remark,
                    'user': '${user.email}',
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

  void updateData(String item, bool isclicked, int amt) async {
    if (!isclicked) {
      await Firestore.instance.collection('Lab2').document('$item').updateData({
        'user': 'Free for Use',
        'no': 0,
      }).catchError((e) {
        print(e);
      });
    }
    if (isclicked) {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      await Firestore.instance.collection('Lab2').document('$item').updateData({
        'user': '${user.email}',
        'no': amt,
      }).catchError((e) {
        print(e);
      });
    }
  }

  void getdata() async {
    try {
      var bdata = await Firestore.instance
          .collection('Lab2')
          .document('Burrette')
          .get();
      setState(() {
        _burrette = bdata.data['no'];
      });
      var fdata =
          await Firestore.instance.collection('Lab2').document('Flask').get();
      setState(() {
        _flask = fdata.data['no'];
      });
      var tdata = await Firestore.instance
          .collection('Lab2')
          .document('TestTubes')
          .get();
      setState(() {
        _testTube = tdata.data['no'];
      });
      var open = await Firestore.instance
          .collection('Lab2')
          .document('utilisation')
          .get();
      setState(() {
        isOpen = open.data['isOpen'];
      });
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
      Flushbar(
        message: 'Cannot establish connection!',
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(8),
        borderRadius: 8,
        backgroundColor: Color.fromRGBO(242, 62, 16, 1),
        icon: Icon(Icons.error_outline),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
    }
  }

  void openUpdate(bool isOpen) async {
    if (isOpen) {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      DateTime str = DateTime.now();
      labOpen = Timestamp.fromDate(str);
      await Firestore.instance
          .collection('Lab2')
          .document('utilisation')
          .updateData({
        'open': labOpen,
        'currentUser': 'Occupied by ${user.email}',
      });
    } else {
      DateTime en = DateTime.now();
      labClose = Timestamp.fromDate(en);
      await Firestore.instance
          .collection('Lab2')
          .document('utilisation')
          .updateData({
        'close': labClose,
        'currentUser': 'Free for use',
      });
      var labutil = await Firestore.instance
          .collection('Lab2')
          .document('utilisation')
          .get();
      start = labutil.data['open'];
      DateTime startdd = start.toDate();
      end = labutil.data['close'];
      DateTime enddd = end.toDate();
      int diff = enddd.difference(startdd).inMinutes;
      int getminutes = labutil.data['minutes'];

      await Firestore.instance
          .collection('Lab2')
          .document('utilisation')
          .updateData({
        'minutes': (diff + getminutes),
      });
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      var usermin = await Firestore.instance
          .collection('users')
          .document('${user.email}')
          .get();
      int userminutes = usermin.data['lab2util'];
      await Firestore.instance
          .collection('users')
          .document('${user.email}')
          .updateData({
        'lab2util': (diff + userminutes),
        'minutes': (usermin.data['minutes']+diff),
      });
      print((diff + userminutes));
    }

    await Firestore.instance
        .collection('Lab2')
        .document('utilisation')
        .updateData({
      'isOpen': isOpen,
    });
  }

  @override
  void initState() {
    try {
      getdata();
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  _overlay() {
    return Container(
      color: Color.fromRGBO(24, 26, 30, 1),
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Icon(
          Icons.lock,
          size: 50,
          color: Color.fromRGBO(242, 62, 16, 1),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(24, 26, 30, 1),
        leading: BackButton(),
        title: Text(
          'Lab 2',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          Switch(
            value: isOpen,
            onChanged: (value) {
              setState(() {
                isOpen = !isOpen;
                openUpdate(isOpen);
              });
            },
            activeColor: Colors.orange,
          ),
        ],
      ),
      body: !isOpen
          ? _overlay()
          : ModalProgressHUD(
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
                            Text('Burrette',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(
                              'Quantity: $_burrette ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: _incrementBurrete,
                                  child: ClayContainer(
                                    height: 50,
                                    width: 100,
                                    color: Color.fromRGBO(24, 26, 30, 1),
                                    borderRadius: 25,
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                InkWell(
                                  onTap: _decrementBurrete,
                                  child: ClayContainer(
                                    height: 50,
                                    width: 100,
                                    color: Color.fromRGBO(242, 62, 16, 1),
                                    borderRadius: 25,
                                    child: Center(
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 50),
                            Text('Flask',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(
                              'Quantity: $_flask',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: _incrementflask,
                                  child: ClayContainer(
                                    height: 50,
                                    width: 100,
                                    color: Color.fromRGBO(24, 26, 30, 1),
                                    borderRadius: 25,
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                InkWell(
                                  onTap: _decrementflask,
                                  child: ClayContainer(
                                    height: 50,
                                    width: 100,
                                    color: Color.fromRGBO(242, 62, 16, 1),
                                    borderRadius: 25,
                                    child: Center(
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 50),
                            Text('Test Tubes',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(
                              'Quantity: $_testTube',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: _incrementTestTube,
                                  child: ClayContainer(
                                    height: 50,
                                    width: 100,
                                    color: Color.fromRGBO(24, 26, 30, 1),
                                    borderRadius: 25,
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                InkWell(
                                  onTap: _decrementTestTube,
                                  child: ClayContainer(
                                    height: 50,
                                    width: 100,
                                    color: Color.fromRGBO(242, 62, 16, 1),
                                    borderRadius: 25,
                                    child: Center(
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 70),
                            InkWell(
                              onTap: () {
                                createAlertDialog(context)
                                    .then((onValue) async {
                                  FirebaseUser user =
                                      await FirebaseAuth.instance.currentUser();
                                  await Firestore.instance
                                      .collection('Lab2Remarks')
                                      .document('${user.email}')
                                      .updateData({
                                    'user': '${user.email}',
                                    'remark': onValue,
                                  }).catchError((e) {
                                    print(e);
                                  });
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
