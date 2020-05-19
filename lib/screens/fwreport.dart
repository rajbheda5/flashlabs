import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

int lab1u1=0;
int lab2u1=0;
int lab3u1=0;
int lab1u2=0;
int lab2u2=0;
int lab3u2=0;

class FWreport extends StatefulWidget {
  @override
  _FWreportState createState() => _FWreportState();
}

class _FWreportState extends State<FWreport> {
  String name1;
  String name2;
  int totalMin1;
  int totalMin2;

  void getdata() async {
    try {
      var u1 = await Firestore.instance
          .collection('users')
          .document('1@2.com')
          .get();
      setState(() {
        name1 = u1.data['name'];
        totalMin1 = u1.data['minutes'];
        lab1u1 = u1.data['lab1util'];
        lab2u1 = u1.data['lab2util'];
        lab3u1 = u1.data['lab3util'];
      });
      var u2 = await Firestore.instance
          .collection('users')
          .document('a@1.com')
          .get();
      setState(() {
        name2 = u2.data['name'];
        totalMin2 = u2.data['minutes'];
        lab1u2 = u2.data['lab1util'];
        lab2u2 = u2.data['lab2util'];
        lab3u2 = u2.data['lab3util'];
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

  // Future<Widget> createAlertDialog(BuildContext context){
  //   return showDialog(
  //     context: context,
  //     builder: (context){
  //       return AlertDialog(
  //         title: Text('Lab vs Utilisation graph'),
  //       backgroundColor: Color(0xff46426c),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(20)),
  //       ),
  //         content: Expanded(
  //           child: LineChartSample1(),
  //         ),
  //         actions: <Widget>[
  //             MaterialButton(
  //               elevation: 5.0,
  //               child: Text('Close'),
  //               onPressed: () async {
  //                 Navigator.pop(context);
  //               },
  //             )
  //           ],
  //       );
  //     }
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 26, 30, 1),
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Faculty Wise Report'),
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
                              'User 1',
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
                              'Name: $name1',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          Container(
                            margin: EdgeInsets.only(left: 24),
                            child: Text(
                              'Total Utilisation: $totalMin1 minutes',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          Container(
                            margin: EdgeInsets.only(left: 24),
                            child: Text(
                              'Lab 1 Utilisation: $lab1u1 minutes\nLab 2 Utilisation: $lab2u1 minutes \nLab3 Utilisation: $lab3u1 minutes',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ]),
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
                              'User 2',
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
                              'Name: $name2',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          Container(
                            margin: EdgeInsets.only(left: 24),
                            child: Text(
                              'Total Utilisation: $totalMin2 minutes',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          Container(
                            margin: EdgeInsets.only(left: 24),
                            child: Text(
                              'Lab 1 Utilisation: $lab1u2 minutes\nLab 2 Utilisation: $lab2u2 minutes \nLab3 Utilisation: $lab3u2 minutes',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: 50),
                  // InkWell(
                  //   onTap: (){
                  //     createAlertDialog(context);
                  //   },
                  //   child: ClayContainer(
                  //     height: 80,
                  //     width: 200,
                  //     borderRadius: 18,
                  //     color: Color.fromRGBO(242, 62, 16, 1),
                  //     spread: 3,
                  //     child: Center(
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //           Icon(
                  //             Icons.graphic_eq,
                  //             color: Colors.white,
                  //             size: 35,
                  //           ),
                  //           SizedBox(width: 10),
                  //           Text(
                  //             'Generate Graph',
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  LineChartSample1(),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color(0xff4af699),
                            ),
                          ),
                          SizedBox(width: 15),
                          Text(' - User 1',style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),)
                        ],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color(0xffaa4cfc),
                            ),
                          ),
                          SizedBox(width: 15),
                          Text(' - User 2',style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),)
                        ],)
                      ],
                    )
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

class LineChartSample1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: const [
              Color.fromRGBO(24, 26, 30, 1),
              Color.fromRGBO(25, 26, 32, 1)
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 12),
                const Text(
                  'Faculty wise Utilisation',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 37,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: LineChart(
                      sampleData1(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'Lab 1';
              case 7:
                return 'Lab 2';
              case 12:
                return 'Lab 3';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10m';
              case 2:
                return '20m';
              case 3:
                return '30m';
              case 4:
                return '40m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 14,
      maxY: 4,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(2, lab1u1.toDouble() / 10),
        FlSpot(7, lab2u1.toDouble() / 10),
        FlSpot(12, lab3u1.toDouble()/10),
      ],
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(2, lab1u2.toDouble() / 10),
        FlSpot(7, lab2u2.toDouble() / 10),
        FlSpot(12, lab3u2.toDouble()/10),
      ],
      isCurved: true,
      colors: [
        const Color(0xffaa4cfc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );

    return [
      lineChartBarData1,
      lineChartBarData2,
    ];
  }
}
