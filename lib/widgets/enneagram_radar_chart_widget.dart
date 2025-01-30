import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class EnneagramRadarChartWidget extends StatelessWidget {
  final Enneagram enneagramData;
  const EnneagramRadarChartWidget({super.key, required this.enneagramData});

  @override
  Widget build(BuildContext context) {
    final List<RadarEntry> listEnneagram = [
      RadarEntry(value: enneagramData.achiever),
      RadarEntry(value: enneagramData.challenger),
      RadarEntry(value: enneagramData.enthusiast),
      RadarEntry(value: enneagramData.helper),
      RadarEntry(value: enneagramData.individualist),
      RadarEntry(value: enneagramData.investigator),
      RadarEntry(value: enneagramData.loyalist),
      RadarEntry(value: enneagramData.peacemaker),
      RadarEntry(value: enneagramData.perfectionist),
    ];

    final List<String> listEnneagramResult = [
      "- Logrador:  ${enneagramData.achiever} \n"
      "- Retador:  ${enneagramData.challenger} \n"
      "- Entusiasta:  ${enneagramData.enthusiast} \n"
      "- Ayudador:  ${enneagramData.helper} \n"
      "- Individualista:  ${enneagramData.individualist} \n"
      "- Investigador:  ${enneagramData.investigator} \n"
      "- Leal:  ${enneagramData.loyalist} \n"
      "- Pacificador:  ${enneagramData.peacemaker} \n"
      "- Perfeccionista:  ${enneagramData.perfectionist} \n"
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            "Personalidad del Eneagrama ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 300,
            child: RadarChart(
              RadarChartData(
                radarShape: RadarShape.polygon,
                radarBackgroundColor: Colors.transparent,
                radarBorderData: BorderSide(color: Colors.grey, width: 2),
                tickCount: 5,
                ticksTextStyle: TextStyle(color: Colors.grey, fontSize: 10),
                getTitle: (index, angle) {
                  List<String> labels = [
                    "Logrador",
                    "Retador",
                    "Entusiasta",
                    "Ayudador",
                    "Individualista",
                    "Investigador",
                    "Leal",
                    "Pacificador",
                    "Perfeccionista"
                  ];
                  if (index < labels.length) {
                    return RadarChartTitle(
                      text: labels[index],
                      angle: angle,
                    );
                  }
                  return const RadarChartTitle(text: '');
                },
                dataSets: [
                  RadarDataSet(
                    fillColor: Colors.blue.withAlpha(50),
                    borderColor: Colors.blue,
                    entryRadius: 3,
                    dataEntries: listEnneagram,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          _buildListResult(  listEnneagramResult)
        ],
      ),
    );
  }

  Widget _buildListResult(
     
    List<String> list,
  ) {
    return ListView.builder(

      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length, 
      itemBuilder: (context, index) {
        return Text(list[index]);
      },
    );
  }
}
