import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class Lab2 extends StatefulWidget {
  @override
  _LabTwo createState() => _LabTwo();
}

class _LabTwo extends State<Lab2> {
  int _burrette = 0;
  int _flask = 0;
  int _testTube = 0;

  void _incrementBurrete() {
    setState(() {
      _burrette++;
    });
  }

  void _decrementBurrete() {
    setState(() {
      if (_burrette >= 1)
        _burrette--;
      else
        _burrette = 0;
    });
  }

  void _incrementflask() {
    setState(() {
      _flask++;
    });
  }

  void _decrementflask() {
    setState(() {
      if (_flask >= 1)
        _flask--;
      else
        _flask = 0;
    });
  }

  void _incrementTestTube() {
    setState(() {
      _testTube++;
    });
  }

  void _decrementTestTube() {
    setState(() {
      if (_testTube >= 1)
        _testTube--;
      else
        _testTube = 0;
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
          'Lab 2',
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
                    Text('Burrette',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                      'Quantity: $_burrette',
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
                        createAlertDialog(context).then((onValue) {});
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
