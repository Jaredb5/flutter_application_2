import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'teams_model.dart';

class LineChartSample extends StatelessWidget {
  final Team team;
  final String dataType;

  LineChartSample({required this.team, required this.dataType});

  @override
  Widget build(BuildContext context) {
    List<LineChartBarData> lineBarsData = []; 

    if (dataType == 'matches') {
      lineBarsData = [
        LineChartBarData(
          spots: [
            FlSpot(0, team.wins.toDouble()),
            FlSpot(1, team.draws.toDouble()),
            FlSpot(2, team.losses.toDouble()),
          ],
          isCurved: true,
          colors: [Colors.green],
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
        ),
      ];
    } else if (dataType == 'corners') {
      lineBarsData = [
        LineChartBarData(
          spots: [
            FlSpot(0, team.corners_total_home.toDouble()),
            FlSpot(1, team.corners_total_away.toDouble()),
          ],
          isCurved: true,
          colors: [Colors.blue],
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
        ),
      ];
    } else {
      lineBarsData = [
        LineChartBarData(
          spots: [
            FlSpot(0, team.goals_scored.toDouble()),
            FlSpot(1, team.goals_conceded.toDouble()),
          ],
          isCurved: true,
          colors: [Colors.red], 
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
        ),
      ];
    }

    return LineChart(
      LineChartData(
        lineBarsData: lineBarsData,
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              switch (dataType) {
                case 'matches':
                  switch (value.toInt()) {
                    case 0:
                      return 'Victorias';
                    case 1:
                      return 'Empates';
                    case 2:
                      return 'Derrotas';
                    default:
                      return '';
                  }
                case 'corners':
                  switch (value.toInt()) {
                    case 0:
                      return 'Casa';
                    case 1:
                      return 'Fuera';
                    default:
                      return '';
                  }
                case 'goals':
                  switch (value.toInt()) {
                    case 0:
                      return 'Anotados';
                    case 1:
                      return 'Recibidos';
                    default:
                      return '';
                  }
                default:
                  return '';
              }
            },
          ),
          leftTitles: SideTitles(showTitles: true),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: true),
      ),
    );
  }
}
