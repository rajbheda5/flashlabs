import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

int pc1, pc2, pc3, pc4;
int cro1, cro2, dmm1, dmm2, tk;
int burrette, flask, tt;

class IWreport extends StatefulWidget {
  @override
  _IWreportState createState() => _IWreportState();
}

class _IWreportState extends State<IWreport> {
  void getdata() async {
    try {
      var lab1i1 =
          await Firestore.instance.collection('Lab1').document('CRO1').get();
      setState(() {
        cro1 = lab1i1.data['minutes'];
      });
      var lab1i2 =
          await Firestore.instance.collection('Lab1').document('CRO2').get();
      setState(() {
        cro2 = lab1i2.data['minutes'];
      });
      var lab1i3 =
          await Firestore.instance.collection('Lab1').document('DMM1').get();
      setState(() {
        dmm1 = lab1i3.data['minutes'];
      });
      var lab1i4 =
          await Firestore.instance.collection('Lab1').document('DMM2').get();
      setState(() {
        dmm2 = lab1i4.data['minutes'];
      });
      var lab1i5 = await Firestore.instance
          .collection('Lab1')
          .document('TrainerKit')
          .get();
      setState(() {
        tk = lab1i5.data['minutes'];
      });
      var lab2i1 = await Firestore.instance
          .collection('Lab2')
          .document('Burrette')
          .get();
      setState(() {
        burrette = lab2i1.data['no'];
      });
      var lab2i2 =
          await Firestore.instance.collection('Lab2').document('Flask').get();
      setState(() {
        flask = lab2i2.data['no'];
      });
      var lab2i3 = await Firestore.instance
          .collection('Lab2')
          .document('TestTubes')
          .get();
      setState(() {
        tt = lab2i3.data['no'];
      });
      var lab3i1 =
          await Firestore.instance.collection('Lab3').document('PC1').get();
      setState(() {
        pc1 = lab3i1.data['minutes'];
      });
      var lab3i2 =
          await Firestore.instance.collection('Lab3').document('PC2').get();
      setState(() {
        pc2 = lab3i2.data['minutes'];
      });
      var lab3i3 =
          await Firestore.instance.collection('Lab3').document('PC3').get();
      setState(() {
        pc3 = lab3i3.data['minutes'];
      });
      var lab3i4 =
          await Firestore.instance.collection('Lab3').document('PC4').get();
      setState(() {
        pc4 = lab3i4.data['minutes'];
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

  Future<Widget> createAlertDialog(BuildContext context){
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Lab vs Utilisation graph'),
        backgroundColor: Color.fromRGBO(30, 33, 38, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
          content: Expanded(
            child: BarChartSample3(),
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
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 26, 30, 1),
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Instrument Wise Report'),
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
                            'Lab 1',
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
                            'CRO1 Utilisation: $cro1 minutes',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 13),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'CRO2 Utilisation: $cro2 minutes',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 13),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'DMM1 Utilisation: $dmm1 minutes',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 13),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'DMM2 Utilisation: $dmm2 minutes',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 13),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'Trainer Kit Utilisation: $tk minutes',
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
                            'Lab 2',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'Burrete quantity: $burrette',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'Flask quantity: $flask',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'Test Tube quantity: $tt',
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
                            'Lab 3',
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
                            'PC1 Utilisation: $pc1 minutes',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 17),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'PC2 Utilisation: $pc2 minutes',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 17),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'PC3 Utilisation: $pc3 minutes',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 17),
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            'PC4 Utilisation: $pc4 minutes',
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
                    onTap: (){
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
                  SizedBox(
                    height: 50,
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

class BarChartSample3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  final Color orange = Color.fromRGBO(242, 62, 16, 1);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color.fromRGBO(24, 26, 30, 1),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 20,
            barTouchData: BarTouchData(
              enabled: false,
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.transparent,
                tooltipPadding: const EdgeInsets.all(0),
                tooltipBottomMargin: 8,
                getTooltipItem: (
                  BarChartGroupData group,
                  int groupIndex,
                  BarChartRodData rod,
                  int rodIndex,
                ) {
                  return BarTooltipItem(
                    rod.y.round().toString(),
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                textStyle: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 0.8),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                margin: 20,
                getTitles: (double value) {
                  switch (value.toInt()) {
                    case 0:
                      return 'CRO1';
                    case 1:
                      return 'CRO2';
                    case 2:
                      return 'DMM1';
                    case 3:
                      return 'DMM2';
                    case 4:
                      return 'TK';
                    case 5:
                      return 'PC1';
                    case 6:
                      return 'PC2';
                    case 7:
                      return 'PC3';
                    case 8:
                      return 'PC4';
                    default:
                      return '';
                  }
                },
              ),
              leftTitles: SideTitles(showTitles: false),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: [
              BarChartGroupData(
                  x: 0,
                  barRods: [BarChartRodData(y: cro1.toDouble(), color: orange)],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 2,
                  barRods: [BarChartRodData(y: cro2.toDouble(), color: orange)],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 2,
                  barRods: [BarChartRodData(y: dmm1.toDouble(), color: orange)],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 3,
                  barRods: [BarChartRodData(y: dmm2.toDouble(), color: orange)],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 3,
                  barRods: [BarChartRodData(y: tk.toDouble(), color: orange)],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 3,
                  barRods: [BarChartRodData(y: pc1.toDouble(), color: orange)],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 3,
                  barRods: [BarChartRodData(y: pc2.toDouble(), color: orange)],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 3,
                  barRods: [BarChartRodData(y: pc3.toDouble(), color: orange)],
                  showingTooltipIndicators: [0]),
                  BarChartGroupData(
                  x: 3,
                  barRods: [BarChartRodData(y: pc4.toDouble(), color: orange)],
                  showingTooltipIndicators: [0]),
            ],
          ),
        ),
      ),
    );
  }
}
