import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tailor_application/widgets/Indecator_widget.dart';
import 'package:tailor_application/widgets/pieChartSection.dart';



class PieChartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartPageState();
}

class PieChartPageState extends State {
  int touchedIndex =0;

  @override
  Widget build(BuildContext context) => Container(
    //width: MediaQuery.of(context).size.width,
    //child: Card(
      child: Column(
      children: <Widget>[
          PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (pieTouchResponse) {
                  // setState(() {
                  //   if (pieTouchResponse.touchInput is FlLongPressEnd ||
                  //       pieTouchResponse.touchInput is FlPanEnd) {
                  //     touchedIndex = -1;
                  //   } else {
                  //     touchedIndex = pieTouchResponse.touchedSectionIndex;
                  //   }
                  // });
                },
              ),
              borderData: FlBorderData(show: false),
              sectionsSpace: 0,
              centerSpaceRadius: 50,
              sections: getSections(touchedIndex),
            ),
          ),
        //IndicatorsWidget(),
      ],
    ),
  //),
 );
}