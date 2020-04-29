import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  @override
  _ReportScreen createState() => _ReportScreen();
}

class _ReportScreen extends State<Report> {
  String dropdownValue = 'Lab wise Report';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(24, 26, 30, 1),
        leading: BackButton(),
        title: Text(
          'Reports',
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
                  Text(
                    'Select Type of Report',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 25),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.white),
                    underline: Container(
                      height: 2,
                      color: Color.fromRGBO(242, 62, 16, 1),
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                        print(dropdownValue);

                        if(dropdownValue =='Faculty wise Report'){
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context){

                        return Scaffold(
                                     backgroundColor: Colors.amberAccent,
                                           body: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                        StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance.collection('users').snapshots(),
                        builder: (context,value){
                        if(!value.hasData)
                        {
                        CircularProgressIndicator();
                        }
                        List<Text> Data = [];
                        String data;
                        for(var snap in value.data.documents){
                        data =snap.data.toString();
                        Data.add(Text(data));
                        }

                        return Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: Data,
                        ),
                        );
                        }
                        )
                        ],
                        ),
                        );
                        }
                        )
                        );
                        }else if(dropdownValue =='Lab wise Report'){
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context){

                        return Scaffold(
                        backgroundColor: Colors.amberAccent,
                        body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance.collection('Lab1').snapshots(),
                        builder: (context,value){
                        if(!value.hasData)
                        {
                        CircularProgressIndicator();
                        }
                        List<Text> Data = [];
                        String data;
                        for(var snap in value.data.documents){
                        data =snap.data.toString();
                        Data.add(Text(data));
                        }

                        return Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: Data,
                        ),
                        );
                        }
                        )
                        ],
                        ),
                        );
                        }
                        )
                        );

                        }
                        else if(dropdownValue =='Instrument wise Report'){
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context){

                        return Scaffold(
                        backgroundColor: Colors.amberAccent,
                        body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance.collection('Lab2').snapshots(),
                        builder: (context,value){
                        if(!value.hasData)
                        {
                        CircularProgressIndicator();
                        }
                        List<Text> Data = [];
                        String data;
                        for(var snap in value.data.documents){
                        data =snap.data.toString();
                        Data.add(Text(data));
                        }

                        return Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: Data,
                        ),
                        );
                        }
                        )
                        ],
                        ),
                        );
                        }
                        )
                        );
                        }

                      });
                    },
                    items: <String>[
                      'Lab wise Report',
                      'Faculty wise Report',
                      'Instrument wise Report',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
