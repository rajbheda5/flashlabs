import 'package:flashlabs/loginpage.dart';
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
            color: Color.fromRGBO(51, 83, 241, 1),
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
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(userInfo,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 56),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClayContainer(
                          height: 150,
                          width: 150,
                          color: Color.fromRGBO(51, 83, 241, 1),
                          spread: 2,
                          depth: 100,
                          child: Icon(Icons.edit,color: Colors.white,
                          size: 75,
                          ),
                          borderRadius: 25,
                        ),
                        SizedBox(width: 55),
                        ClayContainer(
                          height: 150,
                          width: 150,
                          color: Color.fromRGBO(51, 83, 241, 1),
                          spread: 2,
                          depth: 100,
                          child: Icon(Icons.event_note ,color: Colors.white,
                          size: 75,
                          ),
                          borderRadius: 25,
                        )
                      ],
                    ),
                         SizedBox(height: 100),
                          InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return LoginScreen();
                            }
                            )
                            );
                        },
                        child: ClayContainer(
                          height:50,
                          width: 150,
                          spread: 2,
                          depth: 50,
                          color: Color.fromRGBO(51, 82, 241, 1),
                          borderRadius: 30,
                          child: Center(
                            child: Text('Logout',
                            style: TextStyle(
                              color: Colors.white,
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