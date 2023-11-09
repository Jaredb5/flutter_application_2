import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'player_model.dart'; // Asegúrate de que este modelo tenga los datos necesarios

class PieChartSamplePlayer extends StatelessWidget {
  final Player player;
  final String dataType; 

  PieChartSamplePlayer({required this.player, required this.dataType});

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections;

    if (dataType == 'goals') {
      sections = [
        PieChartSectionData(
          value: player.goalsHome.toDouble(),
          color: Colors.blue,
          title: 'Goles Casa',
          radius: 50,
        ),
        PieChartSectionData(
          value: player.goalsAway.toDouble(),
          color: Colors.orange,
          title: 'Goles Fuera',
          radius: 50,
        ),
      ];
    } else if (dataType == 'assists') {
      sections = [
        PieChartSectionData(
          value: player.assistsHome.toDouble(),
          color: Colors.green,
          title: 'Asistencias Casa',
          radius: 50,
        ),
        PieChartSectionData(
          value: player.assistsAway.toDouble(),
          color: Colors.pink,
          title: 'Asistencias Fuera',
          radius: 50,
        ),
      ];
    } else if (dataType == 'yellowCards') {
      sections = [
        PieChartSectionData(
          value: player.yellowCardsOverall.toDouble(),
          color: Colors.amber,
          title: 'Tarjetas Amarillas',
          radius: 50,
        ),
      ];
    } else {
      sections = [];
    }

    return PieChart(
      PieChartData(
        sections: sections,
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
        }),
      ),
    );
  }
}
