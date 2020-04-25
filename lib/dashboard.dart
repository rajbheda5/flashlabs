import 'package:flashlabs/update.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';

class Dashboard extends StatefulWidget{
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>{
  String userName="Dr. Charles Lee";
  String userInfo="Professor, IT Department"; 
  //Here, for UI, I've initialised the strings but the value of string will actually the one fetched from firestore
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
            color: Color.fromRGBO(242, 242, 242, 1),
          )
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height:75, width: double.infinity,),
                    Container(                     
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/Animoji.png'),
                        radius: 100,
                      )
                    ),
                    SizedBox(height:25),
                    Text(userName, 
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(userInfo,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 56),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                                return UpdateScreen();
                              }
                            )
                            );
                          },
                          child: ClayContainer(
                            height: 150,
                            width: 150,
                            color: Color.fromRGBO(242, 242, 242, 1),
                            // spread: 2,
                            // depth: 100,
                            child: Icon(Icons.edit,
                            size: 75,
                            ),
                            borderRadius: 25,
                          ),
                        ),
                        SizedBox(width: 55),
                        ClayContainer(
                          height: 150,
                          width: 150,
                          color: Color.fromRGBO(242, 242, 242, 1),
                          // spread: 2,
                          // depth: 100,
                          child: Icon(Icons.event_note ,
                          size: 75,
                          ),
                          borderRadius: 25,
                        )
                      ],
                    ),
                         SizedBox(height: 100),
                          InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: ClayContainer(
                          height:50,
                          width: 150,
                          spread: 2,
                          depth: 50,
                          color: Color.fromRGBO(242, 242, 242, 1),
                          borderRadius: 30,
                          child: Center(
                            child: Text('Logout',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ),
                        ),
                      ),
                      SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
  
}