import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

int util1 = 0;
int util2 = 0;
int util3 = 0;

class LWreport extends StatefulWidget {
  @override
  _LWreportState createState() => _LWreportState();
}

class _LWreportState extends State<LWreport> {
  String status1 = 'Free for use';
  String status2 = 'Free for use';
  String status3 = 'Free for use';
  String start1;
  String start2;
  String start3;
  String end1;
  String end2;
  String end3;
  bool isOpen1;
  bool isOpen2;
  bool isOpen3;
  bool isLoading = true;

  void getdata() async {
    try {
      var get1 = await Firestore.instance
          .collection('Lab1')
          .document('utilisation')
          .get();
      setState(() {
        status1 = get1.data['currentUser'];
        util1 = get1.data['minutes'];
        isOpen1 = get1.data['isOpen'];
      });
      setState(() {
        start1 = get1.data['open'].toDate().toString();
        if (!isOpen1) {
          end1 = get1.data['close'].toDate().toString();
        } else {
          end1 = 'Active Now';
        }
      });
      var get2 = await Firestore.instance
          .collection('Lab2')
          .document('utilisation')
          .get();
      setState(() {
        status2 = get2.data['currentUser'];
        util2 = get2.data['minutes'];
        isOpen2 = get2.data['isOpen'];
      });
      setState(() {
        start2 = get2.data['open'].toDate().toString();
        if (!isOpen2) {
          end2 = get2.data['close'].toDate().toString();
        } else {
          end2 = 'Active Now';
        }
      });
      var get3 = await Firestore.instance
          .collection('Lab3')
          .document('utilisation')
          .get();
      setState(() {
        status3 = get3.data['currentUser'];
        util3 = get3.data['minutes'];
        isOpen3 = get3.data['isOpen'];
      });
      setState(() {
        start3 = get3.data['open'].toDate().toString();
        if (!isOpen3) {
          end3 = get3.data['close'].toDate().toString();
        } else {
          end3 = 'Active Now';
        }
      });
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
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

  Future<Widget> createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Lab vs Utilisation graph'),
            backgroundColor: Color.fromRGBO(30, 33, 38, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            content: Expanded(
              child: LineChart1(),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Close'),
                onPressed: () async {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 26, 30, 1),
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Lab Wise Report'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color.fromRGBO(24, 26, 30, 1),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                  ),
                  ClayContainer(
                    height: 250,
                    width: 350,
                    borderRadius: 25,
                    color: Color.fromRGBO(24, 26, 30, 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 24, left: 24),
                          child: Text(
                            'LAB 1',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'Current Status: $status1',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'Total Utilisation: $util1 minutes',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'Last Use Cycle: \nLab Opened at: $start1 \nLab Closed at: $end1',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                  ),
                  ClayContainer(
                    height: 250,
                    width: 350,
                    borderRadius: 25,
                    color: Color.fromRGBO(24, 26, 30, 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 24, left: 24),
                          child: Text(
                            'LAB 2',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'Current Status: $status2',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'Total Utilisation: $util2 minutes',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'Last Use Cycle: \nLab Opened at: $start2 \nLab Closed at: $end2',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                  ),
                  ClayContainer(
                    height: 250,
                    width: 350,
                    borderRadius: 25,
                    color: Color.fromRGBO(24, 26, 30, 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 24, left: 24),
                          child: Text(
                            'LAB 3',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'Current Status: $status3',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'Total Utilisation: $util3 minutes',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'Last Use Cycle: \nLab Opened at: $start3 \nLab Closed at: $end3',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                  ),
                  InkWell(
                    onTap: () {
                      createAlertDialog(context);
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
                              Icons.graphic_eq,
                              color: Colors.white,
                              size: 35,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Generate Graph',
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
                  SizedBox(height: 50),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LineChart1 extends StatefulWidget {
  @override
  _LineChart1State createState() => _LineChart1State();
}

class _LineChart1State extends State<LineChart1> {
  List<Color> gradientColors = [
    const Color.fromRGBO(128, 182, 244, 1),
    const Color.fromRGBO(148, 217, 115, 1),
    const Color.fromRGBO(250, 216, 116, 1),
    const Color.fromRGBO(244, 144, 128, 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              color: Color.fromRGBO(24, 26, 30, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'Lab 1';
              case 5:
                return 'Lab 2';
              case 8:
                return 'Lab 3';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10min';
              case 3:
                return '30min';
              case 5:
                return '60min';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 0),
            FlSpot(2, (util1.toDouble() / 10)),
            FlSpot(5, (util2.toDouble() / 10)),
            FlSpot(8, (util3.toDouble() / 10)),
            FlSpot(11, 0),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
