import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'teams_model.dart';

class PieChartSample extends StatelessWidget {
  final Team team;
  final String dataType; 

  PieChartSample({required this.team, required this.dataType});

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections;

    if (dataType == 'matches') {
      sections = [
        PieChartSectionData(
          value: team.wins.toDouble(),
          color: Colors.green,
          title: 'Victorias',
          radius: 50,
        ),
        PieChartSectionData(
          value: team.draws.toDouble(),
          color: Colors.amber,
          title: 'Empates',
          radius: 50,
        ),
        PieChartSectionData(
          value: team.losses.toDouble(),
          color: Colors.red,
          title: 'Derrotas',
          radius: 50,
        ),
      ];
    } else if (dataType == 'goals'){ // 'goals'
      sections = [
        PieChartSectionData(
          value: team.goals_scored.toDouble(),
          color: Colors.blue,
          title: 'Anotados',
          radius: 50,
        ),
        PieChartSectionData(
          value: team.goals_conceded.toDouble(),
          color: Colors.orange,
          title: 'Recibidos',
          radius: 50,
        ),
      ];
    } else {
      sections = [
        PieChartSectionData(
          value: team.corners_total_home.toDouble(),
          color: Colors.blue,
          title: 'Casa',
          radius: 50,
        ),
        PieChartSectionData(
          value: team.corners_total_away.toDouble(),
          color: Colors.orange,
          title: 'Fuera',
          radius: 50,
        ),
      ];
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
