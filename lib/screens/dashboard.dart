import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashlabs/screens/reportscreen.dart';
import 'package:flashlabs/screens/update.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String userName = 'test', userInfo = 'test';
  bool isLoading = true;
  //Here, for UI, I've initialised the strings but the value of string will actually the one fetched from firestore

  void getuserdata() async {
    try {
      FirebaseUser getuser = await FirebaseAuth.instance.currentUser();
      var userdetail = await Firestore.instance
          .collection('users')
          .document('${getuser.email}')
          .get();

      setState(() {
        userName = userdetail.data['name'];
        userInfo = userdetail.data['deg'];
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    try {
      getuserdata();
    } catch (e) {
      print(e);
    }

    print(userInfo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(24, 26, 30, 1),
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
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(24, 26, 30, 1),
                    )),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 75, width: double.infinity),
                          Container(
                              child: CircleAvatar(
                            backgroundImage: AssetImage('assets/Animoji.png'),
                            radius: 100,
                          )),
                          SizedBox(height: 25),
                          Text(
                            userName,
                            style: TextStyle(
                              fontSize: 36,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            userInfo,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(height: 56),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                //splashColor: Color.fromRGBO(242, 62, 16, 0.8),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return UpdateScreen();
                                  }));
                                },
                                child: ClayContainer(
                                  height: 150,
                                  width: 150,
                                  color: Color.fromRGBO(24, 26, 30, 1),
                                  // spread: 2,
                                  // depth: 100,
                                  child: Icon(
                                    Icons.edit,
                                    size: 75,
                                    color: Colors.white,
                                  ),
                                  borderRadius: 25,
                                ),
                              ),
                              SizedBox(width: 55),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Report();
                                    }));
                                  },
                                  child: ClayContainer(
                                    height: 150,
                                    width: 150,
                                    color: Color.fromRGBO(24, 26, 30, 1),
                                    // spread: 2,
                                    // depth: 100,
                                    child: Icon(
                                      Icons.event_note,
                                      size: 75,
                                      color: Colors.white,
                                    ),
                                    borderRadius: 25,
                                  ))
                            ],
                          ),
                          SizedBox(height: 100),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: ClayContainer(
                              height: 50,
                              width: 150,
                              spread: 2,
                              depth: 50,
                              color: Color.fromRGBO(242, 62, 16, 1),
                              borderRadius: 30,
                              child: Center(
                                  child: Text(
                                'Logout',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ),
                          ),
                          SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
